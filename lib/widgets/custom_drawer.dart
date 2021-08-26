import 'package:chat/helpers/app_router.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:chat/ui/profile.dart';
import 'package:chat/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProvider user = Provider.of<UserProvider>(context, listen: false);
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: UserAccountsDrawerHeader(
                currentAccountPicture: Center(
                  child: user.dataUser['photoPath'] == null
                      ? GestureDetector(
                          onTap: () =>
                              AppRouter.route.pushNamed(Profile.routeName, {}),
                          child: Image.asset(
                            'assets/images/blackUser.png',
                            alignment: Alignment.center,
                          ),
                        )
                      : Image.network(
                          user.dataUser['photoPath'],
                          fit: BoxFit.contain,
                        ),
                ),
                accountName: user.dataUser['firstName'] == null
                    ? GestureDetector(
                        onTap: () =>
                            AppRouter.route.pushNamed(Profile.routeName, {}),
                        child: Text(
                          "Fill your profile from here",
                          style: TextStyle(color: Colors.white),
                        ))
                    : Text('Welcome Back ${user.dataUser['firstName']}'),
                accountEmail: Text(user.dataUser['email'] ?? ""),
              ),
            ),
            CustomListTile("Profile", Icons.person,
                () => AppRouter.route.pushNamed(Profile.routeName, {})),
          ],
        ),
      ),
    );
  }
}
