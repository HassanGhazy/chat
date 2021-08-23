import 'package:chat/helpers/app_router.dart';
import 'package:chat/provider/auth_provider.dart';
import 'package:chat/ui/auth/Widget/back_button_widget.dart';
import 'package:chat/ui/auth/Widget/bezierContainer.dart';
import 'package:chat/ui/auth/Widget/button_social.dart';
import 'package:chat/ui/auth/Widget/custom_divider.dart';
import 'package:chat/widgets/custom_text_field.dart';
import 'package:chat/ui/auth/Widget/register_and_login_button.dart';
import 'package:chat/ui/auth/Widget/toggle_account.dart';
import 'package:chat/ui/auth/Widget/welcome_widget.dart';
import 'package:chat/ui/auth/reset_password_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "/login";
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  // final TextEditingController _phone = TextEditingController();
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    // _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .2),
                  const WelcomeTextWidget(Color(0xffe46b10)),

                  const SizedBox(height: 50),
                  CustomTextField("Email", textEditingController: _email),
                  CustomTextField("Password",
                      isPassword: true, textEditingController: _password),
                  const SizedBox(height: 20),
                  // _divider(),
                  // CustomTextField("Login with your Phone",
                  //     textEditingController: _phone),
                  RegisterAndLoginButton(
                    email: _email,
                    password: _password,
                    // firstName: TextEditingController(),
                    // lastName: TextEditingController(),
                    // country: TextEditingController(),
                    // phoneNumber: _phone,
                    title: 'Login',
                    action: 1,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        AppRouter.route.pushNamed(ResetPassword.routeName, {});
                      },
                      child: const Text('Forgot Password ?',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff000000))),
                    ),
                  ),
                  const CustomDivider(),
                  GestureDetector(
                    child: ButtonSocail(
                      text: "Sign in with Google",
                      path: "assets/images/google_logo.png",
                    ),
                    onTap: () async {
                      await Provider.of<AuthProvider>(context, listen: false)
                          .signInGoogle();
                    },
                  ),
                  GestureDetector(
                    onTap: () async {
                      await Provider.of<AuthProvider>(context, listen: false)
                          .signInFacebook();
                    },
                    child: ButtonSocail(
                      text: "Sign in with Facebook",
                      path: "assets/images/Facebook_logo.png",
                    ),
                  ),
                  const ToggleAccount(
                      'Don\'t have an account ?', 'Register', 2),
                ],
              ),
            ),
          ),
          Navigator.canPop(context)
              ? Positioned(top: 40, left: 0, child: BackButtonWidget())
              : Container(),
        ],
      ),
    ));
  }
}
