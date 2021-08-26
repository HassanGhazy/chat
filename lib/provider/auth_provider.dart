import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat/helpers/firestore_helper.dart';
import 'package:chat/ui/auth/welcomePage.dart';
import '../helpers/app_router.dart';
import '../helpers/custom_dialoug.dart';
import '../helpers/shared.dart';
import '../ui/auth/loginPage.dart';
import '../ui/home/home_page.dart';
import '../helpers/auth_helper.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  // TextEditingController firstName = TextEditingController();
  // TextEditingController lastName = TextEditingController();
  // TextEditingController country = TextEditingController();

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

      await AuthHelper.authHelper.signup(email.text, password.text);
      await AuthHelper.authHelper.verifyEmail();
      await AuthHelper.authHelper.logoutEmail();

      AppRouter.route.removeUntilScreen(LoginPage());
      CustomDialoug.customDialoug.showCustomDialoug(
          "Successfully Register\nWe sent an email to your account to verify from your account\nPlease check your mail",
          DialogType.SUCCES);
    } on Exception catch (e) {
      print(e);
    } finally {
      loading = false;
      notifyListeners();
    }
    resetControllers();
  }

  String getCurrentUid() {
    return AuthHelper.authHelper.getUid();
  }

  Future<void> login() async {
    if (email.text == "" || password.text == "") {
      CustomDialoug.customDialoug
          .showCustomDialoug('some of fields is empty', DialogType.ERROR);
    } else {
      loading = true;
      notifyListeners();

      bool exist =
          await AuthHelper.authHelper.signin(email.text, password.text);

      // uid = user.user!.uid;
      bool isVerifiedEmail = AuthHelper.authHelper.checkEmailVerification();
      if (isVerifiedEmail) {
        await FireStoreHelper.fireStoreHelper.getUserFromFirestore();
        // Provider.of<UserProvider>(context, listen: false).email = email.text;
        AppRouter.route.removeUntilScreen(HomePage("Email"));
      } else {
        if (exist) {
          CustomDialoug.customDialoug.showCustomDialoug(
              'You have to verify your email, press ok to send another email',
              DialogType.INFO,
              sendVericiafion);
        }
      }
    }
    loading = false;
    notifyListeners();
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
      CustomDialoug.customDialoug
          .showCustomDialoug('Failed to sign In', DialogType.ERROR);
    }
  }

  Future<void> signInFacebook() async {
    bool success = await AuthHelper.authHelper.signInWithFacebook();
    if (success) {
      AppRouter.route.removeUntilScreen(HomePage("Facebook"));
    } else {
      CustomDialoug.customDialoug
          .showCustomDialoug('Failed to sign In', DialogType.ERROR);
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

  logout(String type) async {
    switch (type) {
      case "Email":
        await AuthHelper.authHelper.logoutEmail();
        await SpHelper.spHelper.removeKey("uid");
        break;
      case "Google":
        await AuthHelper.authHelper.logoutGoogle();
        break;
      case "Facebook":
        await AuthHelper.authHelper.logoutFacebook();
        break;
      default:
    }
    AppRouter.route.removeUntilNamed(LoginPage.routeName);
  }

  void checkLoggin() {
    bool isLog = AuthHelper.authHelper.checkUserLoggin();
    if (isLog) {
      AppRouter.route.removeUntilNamed(HomePage.routeName);
    }
    AppRouter.route.removeUntilNamed(WelcomePage.routeName);
  }
}
