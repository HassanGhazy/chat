import 'package:chat/helpers/app_router.dart';
import 'package:chat/helpers/custom_dialoug.dart';
import 'package:chat/helpers/firestore_helper.dart';
import 'package:chat/helpers/shared.dart';
import 'package:chat/ui/auth/loginPage.dart';
import 'package:chat/ui/auth/modals/user.dart';
import 'package:chat/ui/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../helpers/auth_helper.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController country = TextEditingController();
  // TextEditingController phoneNumber = TextEditingController();
  // TextEditingController smsCode = TextEditingController();
  // String uid = "";
  bool loading = false;
  resetControllers() {
    email.clear();
    password.clear();
  }

  register() async {
    try {
      loading = true;
      notifyListeners();

      UserCredential userCredential =
          await AuthHelper.authHelper.signup(email.text, password.text);
      UserModal user = UserModal(
        id: userCredential.user!.uid,
        email: email.text,
        firstName: firstName.text,
        lastName: lastName.text,
        country: country.text,
      );
      print('firstName ${firstName.text}');
      await FireStoreHelper.fireStoreHelper.addUserToFirestore(user);
      await AuthHelper.authHelper.verifyEmail();
      await AuthHelper.authHelper.logoutEmail();
      AppRouter.route.removeUntilScreen(LoginPage());
    } on Exception catch (e) {
      print(e);
    } finally {
      loading = false;
      notifyListeners();
    }
    resetControllers();
  }

  Future<void> login() async {
    if (email.text == "" || password.text == "") {
      CustomDialoug.customDialoug.showCustomDialoug('some of fields is empty');
    } else {
      loading = true;
      notifyListeners();
      UserCredential user =
          await AuthHelper.authHelper.signin(email.text, password.text);

      // uid = user.user!.uid;
      bool isVerifiedEmail = AuthHelper.authHelper.checkEmailVerification();
      // if (isVerifiedEmail) {
      await FireStoreHelper.fireStoreHelper
          .getUserFromFirestore(user.user!.uid);
      SpHelper.spHelper.saveData("userId", user.user!.uid);
      AppRouter.route.removeUntilScreen(HomePage("Email"));
      // } else {
      //   CustomDialoug.customDialoug.showCustomDialoug(
      //       'You have to verify your email, press ok to send another email',
      //       sendVericiafion);
      // }
    }
    loading = false;
    notifyListeners();
    resetControllers();
  }

  // Future<void> loginWithPhone() async {
  //   bool success =
  //       await AuthHelper.authHelper.signinWithPhone(phoneNumber.text);
  //   if (success) {
  //     AppRouter.route.removeUntilNamed(HomePage.routeName);
  //   }

  //   resetControllers();
  // }

  Future<void> sendVericiafion() async {
    await AuthHelper.authHelper.verifyEmail();
    await AuthHelper.authHelper.logoutEmail();
  }

  Future<void> signInGoogle() async {
    bool success = await AuthHelper.authHelper.signInWithGoogle();
    if (success) {
      AppRouter.route.removeUntilScreen(HomePage("Google"));
    } else {
      CustomDialoug.customDialoug.showCustomDialoug('Failed to sign In');
    }
  }

  Future<void> signInFacebook() async {
    bool success = await AuthHelper.authHelper.signInWithFacebook();
    if (success) {
      AppRouter.route.removeUntilScreen(HomePage("Facebook"));
    } else {
      CustomDialoug.customDialoug.showCustomDialoug('Failed to sign In');
    }
  }

  resetPassword() async {
    loading = true;
    notifyListeners();
    AuthHelper.authHelper.resetPassword(email.text);
    loading = false;
    notifyListeners();
    AppRouter.route.removeUntilNamed(LoginPage.routeName);

    resetControllers();
  }

  logoutEmail() async {
    await AuthHelper.authHelper.logoutEmail();
    await SpHelper.spHelper.removeKey("userId");
    AppRouter.route.removeUntilNamed(LoginPage.routeName);
  }

  logoutGoogle() async {
    await AuthHelper.authHelper.logoutGoogle();
    AppRouter.route.removeUntilNamed(LoginPage.routeName);
  }

  logoutFacebook() async {
    await AuthHelper.authHelper.logoutFacebook();
    AppRouter.route.removeUntilNamed(LoginPage.routeName);
  }
}
