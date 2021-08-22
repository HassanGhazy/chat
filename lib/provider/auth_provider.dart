import 'package:chat/helpers/app_router.dart';
import 'package:chat/helpers/custom_dialoug.dart';
import 'package:chat/helpers/firestore_helper.dart';
import 'package:chat/ui/auth/loginPage.dart';
import 'package:chat/ui/auth/modals/register_request.dart';
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
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController smsCode = TextEditingController();
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
      RegisterRequest registerRequest = RegisterRequest(
        id: userCredential.user!.uid,
        email: email.text,
        password: password.text,
        firstName: firstName.text,
        lastName: lastName.text,
        country: country.text,
      );
      await FireStoreHelper.fireStoreHelper.addUserToFirestore(registerRequest);
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
    // if (phoneNumber.text != "" && email.text == "" && password.text == "") {
    //   await loginWithPhone();
    // } else {
    if (email.text == "" || password.text == "") {
      CustomDialoug.customDialoug.showCustomDialoug('some of fields is empty');
    } else {
      loading = true;
      notifyListeners();
      bool exist =
          await AuthHelper.authHelper.signin(email.text, password.text);
      bool isVerifiedEmail = AuthHelper.authHelper.checkEmailVerification();
      if (isVerifiedEmail) {
        AppRouter.route.removeUntilScreen(HomePage("Email"));
      } else {
        if (exist)
          CustomDialoug.customDialoug.showCustomDialoug(
              'You have to verify your email, press ok to send another email',
              sendVericiafion);
      }
    }
    loading = false;
    notifyListeners();
    resetControllers();
    // }
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
    AuthHelper.authHelper.logoutEmail();
    AppRouter.route.removeUntilNamed(LoginPage.routeName);
  }

  logoutGoogle() async {
    AuthHelper.authHelper.logoutGoogle();
    AppRouter.route.removeUntilNamed(LoginPage.routeName);
  }

  logoutFacebook() async {
    AuthHelper.authHelper.logoutFacebook();
    AppRouter.route.removeUntilNamed(LoginPage.routeName);
  }
}
