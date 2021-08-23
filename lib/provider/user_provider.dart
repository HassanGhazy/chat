import 'package:chat/helpers/firestore_helper.dart';
import 'package:chat/helpers/shared.dart';
import 'package:chat/ui/auth/modals/user_modal.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  List<UserModal> users = <UserModal>[];
  Map<String, dynamic> dataUser = <String, dynamic>{};
  String email = "";
  UserProvider() {
    getAllUers();
    // getCurrentUser();
  }
  Future<List<UserModal>> getAllUers() async {
    users = await FireStoreHelper.fireStoreHelper.getAllUsersFromFirestore();
    return users;
// check notify
  }

  Future<Map<String, dynamic>> getCurrentUser() async {
    final String? uid = SpHelper.spHelper.getData('uid');
    return await FireStoreHelper.fireStoreHelper.getUserFromFirestore(uid!);
  }

  Future<void> addUser(UserModal userModal) async {
    await FireStoreHelper.fireStoreHelper.addUserToFirestore(userModal);
  }
}
