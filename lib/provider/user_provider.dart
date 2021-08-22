import 'package:chat/helpers/firestore_helper.dart';
import 'package:chat/ui/auth/modals/user.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  List<UserModal> users = <UserModal>[];
  UserProvider() {
    getAllUers();
  }
  Future<List<UserModal>> getAllUers() async {
    users = await FireStoreHelper.fireStoreHelper.getAllUsersFromFirestore();
    return users;
// check notify
  }
}
