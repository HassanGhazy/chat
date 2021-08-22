import 'package:chat/ui/auth/modals/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelper {
  FireStoreHelper._();
  static FireStoreHelper fireStoreHelper = FireStoreHelper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<void> addUserToFirestore(UserModal registerRequest) async {
    await firebaseFirestore
        .collection('User')
        .doc(registerRequest.id)
        .set(registerRequest.toMap());
  }

  Future<void> getUserFromFirestore(String uid) async {
    await firebaseFirestore.collection('User').doc(uid).get();
  }

  Future<List<UserModal>> getAllUsersFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firebaseFirestore.collection('User').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<UserModal> users =
        docs.map((e) => UserModal.fromMap(e.data())).toList();
    print(users);
    return users;
  }
}
