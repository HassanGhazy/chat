import 'package:chat/ui/auth/modals/register_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelper {
  FireStoreHelper._();
  static FireStoreHelper fireStoreHelper = FireStoreHelper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<void> addUserToFirestore(RegisterRequest registerRequest) async {
    await firebaseFirestore.collection('User').add(registerRequest.toMap());
  }
}
