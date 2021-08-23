// import 'package:chat/helpers/app_router.dart';
import 'package:chat/ui/auth/Widget/back_button_widget.dart';
import 'package:chat/ui/auth/Widget/bezierContainer.dart';
import 'package:chat/widgets/custom_text_field.dart';
import 'package:chat/ui/auth/Widget/register_and_login_button.dart';
import 'package:chat/ui/auth/Widget/toggle_account.dart';
import 'package:chat/ui/auth/Widget/welcome_widget.dart';
// import 'package:chat/ui/auth/phone_sign_in_page.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = "/sign-up";
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _country = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _country.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    const WelcomeTextWidget(const Color(0xffe46b10)),
                    const SizedBox(height: 50),
                    CustomTextField("Email", textEditingController: _email),
                    // CustomTextField("First Name",
                    // textEditingController: _firstName),
                    // CustomTextField("Last Name",
                    // textEditingController: _lastName),
                    // CustomTextField("Country", textEditingController: _country),
                    CustomTextField("Password",
                        isPassword: true, textEditingController: _password),
                    const SizedBox(height: 20),
                    RegisterAndLoginButton(
                      email: _email,
                      password: _password,
                      // firstName: _firstName,
                      // lastName: _lastName,
                      // country: _country,
                      // phoneNumber: TextEditingController(),
                      title: 'Register Now',
                      action: 2,
                    ),
                    // Container(
                    //   padding: EdgeInsets.symmetric(vertical: 10),
                    //   alignment: Alignment.centerRight,
                    //   child: TextButton(
                    //     onPressed: () {
                    //       AppRouter.route
                    //           .pushNamed(PhoneSignInPage.routeName, {});
                    //     },
                    //     child: const Text('Register with your phone?',
                    //         style: TextStyle(
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.w500,
                    //             color: Color(0xff000000))),
                    //   ),
                    // ),
                    ToggleAccount('Already have an account ?', 'Login', 1),
                  ],
                ),
              ),
            ),
            Navigator.canPop(context)
                ? Positioned(top: 40, left: 0, child: BackButtonWidget())
                : Container(),
          ],
        ),
      ),
    );
  }
}
