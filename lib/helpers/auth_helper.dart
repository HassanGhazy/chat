import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat/helpers/custom_dialoug.dart';
import 'package:chat/helpers/shared.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthHelper {
  AuthHelper._();
  static AuthHelper authHelper = AuthHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  String getUid() {
    return firebaseAuth.currentUser == null
        ? ""
        : firebaseAuth.currentUser!.uid;
  }

  Future<UserCredential> signup(String email, String password) async {
    UserCredential? userCredential;
    try {
      userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomDialoug.customDialoug.showCustomDialoug(
            'The password provided is too weak.\nPlease updated',
            DialogType.WARNING);
      } else if (e.code == 'email-already-in-use') {
        CustomDialoug.customDialoug.showCustomDialoug(
            'The account already exists for that email.',
            DialogType.INFO_REVERSED);
      }
    } catch (e) {
      print(e);
    }
    return userCredential!;
  }

  Future<bool> signin(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      await SpHelper.spHelper.saveData("uid", userCredential.user!.uid);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomDialoug.customDialoug.showCustomDialoug(
            '\nNo user found for that email.\n', DialogType.ERROR);
      } else if (e.code == 'wrong-password') {
        CustomDialoug.customDialoug.showCustomDialoug(
            '\nWrong password provided for that user.\n', DialogType.ERROR);
      }
    }
    return false;
  }

  // Future<bool> signinWithPhone(String phoneNumber) async {
  //   try {
  //     await firebaseAuth.verifyPhoneNumber(
  //       phoneNumber: phoneNumber,
  //       verificationCompleted: (PhoneAuthCredential credential) async =>
  //           await firebaseAuth.signInWithCredential(credential),
  //       verificationFailed: (FirebaseAuthException e) {
  //         print(e);
  //         print(e.credential);
  //         if (e.code == 'invalid-phone-number') {
  //           CustomDialoug.customDialoug
  //            .showCustomDialoug('The provided phone number is not valid.');
  //         }
  //       },
  //       timeout: const Duration(seconds: 60),
  //       codeSent: (String verificationId, int? resendToken) async {
  //         String smsCode = '123456';
  //         PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //             verificationId: verificationId, smsCode: smsCode);
  //         await firebaseAuth.signInWithCredential(credential);
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {
  //         // Auto-resolution timed ou,
  //       },
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     print(e);
  //     print(e.credential);
  //     print(e.code);
  //     return false;
  //   }
  //   return true;
  // }

  Future<void> resetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
    CustomDialoug.customDialoug.showCustomDialoug(
        'we have sent email for reset password, please check your email',
        DialogType.INFO);
  }

  Future<void> verifyEmail() async {
    if (firebaseAuth.currentUser != null) {
      await firebaseAuth.currentUser!.sendEmailVerification();
      CustomDialoug.customDialoug.showCustomDialoug(
          'verification email has been sent, please check your email',
          DialogType.INFO);
    }
  }

  Future<void> logoutEmail() async {
    try {
      firebaseAuth.signOut();
    } catch (_) {}
  }

  Future<void> logoutGoogle() async => await GoogleSignIn().disconnect();

  bool checkEmailVerification() =>
      firebaseAuth.currentUser?.emailVerified ?? false;

  Future<bool> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      UserCredential user = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      return user.user != null;
    } on Exception catch (_) {}
    return false;
  }

  Future<void> logoutFacebook() async => await FacebookAuth.instance.logOut();

  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential user =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return user.user != null;
    } on Exception catch (_) {}

    return false;
  }

  bool checkUserLoggin() {
    if (firebaseAuth.currentUser == null) {
      return false;
    }
    return true;
  }
}
