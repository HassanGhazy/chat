import 'package:chat/ui/auth/modals/user_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelper {
  FireStoreHelper._();
  static FireStoreHelper fireStoreHelper = FireStoreHelper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<void> addUserToFirestore(UserModal userModal) async {
    await firebaseFirestore
        .collection('User')
        .doc(userModal.id)
        .set(userModal.toMap());
  }

  Future<Map<String, dynamic>> getUserFromFirestore(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> currentUser =
        await firebaseFirestore.collection('User').doc(uid).get();
    return currentUser.data()!;
  }

  Future<List<UserModal>> getAllUsersFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firebaseFirestore.collection('User').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<UserModal> users =
        docs.map((e) => UserModal.fromMap(e.data())).toList();

    return users;
  }
}
