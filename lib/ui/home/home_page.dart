import 'package:chat/helpers/custom_progress.dart';
import 'package:chat/helpers/firestore_helper.dart';
import 'package:chat/provider/auth_provider.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:chat/ui/home/widgets/custom_search_delegate.dart';
import 'package:chat/ui/home/widgets/listview_users.dart';
import 'package:chat/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home';
  HomePage(this.type);
  final String type;

  @override
  Widget build(BuildContext context) {
    FireStoreHelper.fireStoreHelper.getUserFromFirestore().then((value) =>
        Provider.of<UserProvider>(context, listen: false).dataUser = value);

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text("Home"),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logout(type);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: Consumer<UserProvider>(builder: (context, user, child) {
        // user.users == null ? CustomProgress.customProgress.showProgressIndicator() :
        if (!user.getAllUser) {
          user.getAllUers();
          user.getAllUser = true;
        }

        return !user.getAllUser
            ? CustomProgress.customProgress.showProgressIndicator()
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      height: 40,
                      child: TextField(
                        onTap: () {
                          showSearch(
                            context: context,
                            delegate: CustomSearchDelegate(),
                          );
                        },
                        enableInteractiveSelection: false,
                        readOnly: true,
                        showCursor: false,
                        cursorHeight: 14,
                        enableSuggestions: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Colors.black),
                          prefixText: 'Search',
                          prefixStyle: TextStyle(color: Colors.black),
                          labelStyle: TextStyle(
                              color: Colors.black, fontSize: 10, height: 14),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: Container(
                        height: 150,
                        width: 150,
                        child: Icon(
                          Icons.add,
                          size: 50,
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xFFFCACC9), shape: BoxShape.circle),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListViewUsers(user),
                  ),
                ],
              );
      }),
    );
  }
}
