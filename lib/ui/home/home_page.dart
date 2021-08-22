import 'package:chat/provider/auth_provider.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:chat/ui/auth/modals/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  HomePage(this.type);
  final String type;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserModal> users = [];
  bool loading = true;
  @override
  void initState() {
    super.initState();
    getUsers();
  }

  Future<void> getUsers() async {
    await UserProvider().getAllUers().then((value) {
      users = value;
      loading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
              onPressed: () {
                if (widget.type == "Email") {
                  Provider.of<AuthProvider>(context, listen: false)
                      .logoutEmail();
                } else if (widget.type == "Google") {
                  Provider.of<AuthProvider>(context, listen: false)
                      .logoutGoogle();
                } else {
                  Provider.of<AuthProvider>(context, listen: false)
                      .logoutFacebook();
                }
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: users
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.amber[300],
                            child: ListTile(
                              title: Text(e.firstName!),
                              subtitle: Text("${e.lastName!}"),
                              leading: Icon(Icons.person),
                              trailing: Text("${e.country!}"),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
    );
  }
}
