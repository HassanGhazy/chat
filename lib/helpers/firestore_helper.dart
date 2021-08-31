import 'package:chat/helpers/auth_helper.dart';
import 'package:chat/ui/auth/modals/country_modal.dart';
import 'package:chat/ui/auth/modals/user_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelper {
  FireStoreHelper._();
  static FireStoreHelper fireStoreHelper = FireStoreHelper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  addMessage(Map<String, dynamic> map, String uid) async {
    firebaseFirestore.collection('$uid').add(map);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getFirestoreStream(String uid) {
    return firebaseFirestore.collection('$uid').orderBy('time').snapshots();
  }

  Future<void> addUserToFirestore(UserModal userModal) async {
    await firebaseFirestore
        .collection('User')
        .doc(userModal.id)
        .set(userModal.toMap());
  }

  Future<Map<String, dynamic>> getUserFromFirestore() async {
    String uid = AuthHelper.authHelper.getUid();
    DocumentSnapshot<Map<String, dynamic>> currentUser =
        await firebaseFirestore.collection('User').doc(uid).get();
    return currentUser.data() ?? <String, dynamic>{};
  }

  Future<String> getImageFromFirestore(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> currentUser =
        await firebaseFirestore.collection('User').doc(uid).get();
    return currentUser.data()!['photoPath'];
  }

  Future<List<UserModal>> getAllUsersFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firebaseFirestore.collection('User').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<UserModal> users = docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> e) =>
            UserModal.fromMap(e.data()))
        .toList();

    return users;
  }

  Future<List<CountryModal>> getAllCountries() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firebaseFirestore.collection('Countries').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<CountryModal> countries =
        docs.map((QueryDocumentSnapshot<Map<String, dynamic>> e) {
      Map<String, dynamic> map = e.data();
      map['id'] = e.id;
      return CountryModal.fromMap(map);
    }).toList();

    return countries;
  }
}
