import 'package:chat/helpers/app_router.dart';
import 'package:chat/helpers/firestore_helper.dart';
import 'package:chat/provider/auth_provider.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:chat/ui/chat/chat_page.dart';
import 'package:chat/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
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
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logout(type);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Consumer<UserProvider>(builder: (context, user, child) {
        // user.users == null ? CustomProgress.customProgress.showProgressIndicator() :
        user.getAllUers();
        return ListView.builder(
          itemBuilder: (context, index) => ListTile(
            title: Text(
                '${user.users[index].firstName!} ${user.users[index].lastName!}'),
            leading: CircleAvatar(
              backgroundImage: user.users[index].photoPath == null ||
                      user.users[index].photoPath == ""
                  ? null
                  : NetworkImage(user.users[index].photoPath!),
              child: user.users[index].photoPath == null ||
                      user.users[index].photoPath == ""
                  ? Image.asset('assets/images/user.png')
                  : null,
            ),
            onTap: () {
              user.friend.update('photoPath', (value) {
                value = user.users[index].photoPath ?? "";
                return value;
              });
              user.friend.update('firstName', (value) {
                value = user.users[index].firstName ?? "";
                return value;
              });
              user.friend.update('lastName', (value) {
                value = user.users[index].lastName ?? "";
                return value;
              });
              user.friend.update('id', (value) {
                value = user.users[index].id ?? "";
                return value;
              });
              AppRouter.route.pushNamed(ChatPage.routeName, {});
            },
          ),
          itemCount: user.users.length,
        );
      }),
    );
  }
}
