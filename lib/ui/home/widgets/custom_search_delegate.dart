import 'package:chat/helpers/app_router.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:chat/ui/auth/modals/user_modal.dart';
import 'package:chat/ui/home/widgets/listview_users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomSearchDelegate extends SearchDelegate {
  final UserProvider user = Provider.of<UserProvider>(
      AppRouter.route.navKey.currentContext!,
      listen: false);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<UserModal> usersRes = <UserModal>[...user.users];
    bool existFirstName = usersRes.any((UserModal element) =>
        element.firstName!.toLowerCase().contains(query.toLowerCase()));
    bool existLastName = usersRes.any((UserModal element) =>
        element.lastName!.toLowerCase().contains(query.toLowerCase()));
    bool existFirstAnsLastName = usersRes.any((UserModal element) =>
        (element.firstName! + " " + element.lastName!)
            .toLowerCase()
            .contains(query.toLowerCase()));
    if (existFirstName || existLastName || existFirstAnsLastName) {
      print(query);
      usersRes.removeWhere((UserModal element) =>
          !element.firstName!
              .toLowerCase()
              .contains(query.toLowerCase().trim()) &&
          !element.lastName!.toLowerCase().contains(query.toLowerCase()) &&
          !(element.firstName! + " " + element.lastName!)
              .toLowerCase()
              .contains(query.toLowerCase()));
    }

    return ListViewUsers(user, usersRes);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListViewUsers(user);
  }
}
