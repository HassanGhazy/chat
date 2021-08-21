// import 'package:chat/ui/auth/Widget/back_button_widget.dart';
// import 'package:chat/ui/auth/Widget/bezierContainer.dart';
// // import 'package:chat/ui/auth/Widget/custom_text_field.dart';
// import 'package:chat/ui/auth/Widget/register_and_login_button.dart';
// import 'package:flutter/material.dart';

// class PhoneSignInPage extends StatefulWidget {
//   static const String routeName = "/phone-signin";

//   @override
//   _PhoneSignInPageState createState() => _PhoneSignInPageState();
// }

// class _PhoneSignInPageState extends State<PhoneSignInPage> {
//   // final TextEditingController _phone = TextEditingController();

//   // final TextEditingController _smscode = TextEditingController();
//   // bool _toggleToSms = false;
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     return Scaffold(
//         body: Container(
//       height: height,
//       child: Stack(
//         children: <Widget>[
//           Positioned(
//               top: -height * .15,
//               right: -MediaQuery.of(context).size.width * .4,
//               child: BezierContainer()),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   SizedBox(height: height * .2),
//                   // const SizedBox(height: 80),
//                   // CustomTextField("Phone", textEditingController: _phone),
//                   const SizedBox(height: 20),
//                   RegisterAndLoginButton(
//                     email: TextEditingController(),
//                     password: TextEditingController(),
//                     // phoneNumber: _phone,
//                     title: 'Register with your Phone Number',
//                     action: 4,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Navigator.canPop(context)
//               ? Positioned(top: 40, left: 0, child: BackButtonWidget())
//               : Container(),
//         ],
//       ),
//     ));
//   }
// }
