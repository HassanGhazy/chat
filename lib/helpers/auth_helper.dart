import 'package:chat/helpers/custom_dialoug.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthHelper {
  AuthHelper._();
  static AuthHelper authHelper = AuthHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential>? get userCredential => null;
  Future<UserCredential> signup(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomDialoug.customDialoug
            .showCustomDialoug('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        CustomDialoug.customDialoug
            .showCustomDialoug('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return userCredential!;
  }

  Future<bool> signin(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomDialoug.customDialoug
            .showCustomDialoug('No user found for that email.');
        return false;
      } else if (e.code == 'wrong-password') {
        CustomDialoug.customDialoug
            .showCustomDialoug('Wrong password provided for that user.');
        return false;
      }
    }
    return true;
  }

  Future<bool> signinWithPhone(String phoneNumber) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async =>
            await firebaseAuth.signInWithCredential(credential),
        verificationFailed: (FirebaseAuthException e) {
          print(e);
          print(e.credential);
          if (e.code == 'invalid-phone-number') {
            CustomDialoug.customDialoug
                .showCustomDialoug('The provided phone number is not valid.');
          }
        },
        timeout: const Duration(seconds: 60),
        codeSent: (String verificationId, int? resendToken) async {
          String smsCode = '123456';
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode);
          await firebaseAuth.signInWithCredential(credential);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed ou,
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      print(e.credential);
      print(e.code);
      return false;
    }
    return true;
  }

  Future<void> resetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
    CustomDialoug.customDialoug.showCustomDialoug(
        'we have sent email for reset password, please check your email');
  }

  Future<void> verifyEmail() async {
    if (firebaseAuth.currentUser != null) {
      await firebaseAuth.currentUser!.sendEmailVerification();
      CustomDialoug.customDialoug.showCustomDialoug(
          'verification email has been sent, please check your email');
    }
  }

  Future<void> logoutEmail() async {
    try {
      firebaseAuth.signOut();
    } catch (_) {}
  }

  Future<void> logoutGoogle() async => await GoogleSignIn().disconnect();
  bool checkEmailVerification() {
    return firebaseAuth.currentUser?.emailVerified ?? false;
  }

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
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential user =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return user.user != null;
    } on Exception catch (_) {}

    return false;
  }
}
