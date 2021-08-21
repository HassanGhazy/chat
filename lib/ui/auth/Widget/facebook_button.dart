// import 'package:flutter/material.dart';

// class FaceookButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       margin: EdgeInsets.symmetric(vertical: 20),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(10)),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Container(
//             width: 50,
//             decoration: BoxDecoration(
//               color: Color(0xff1959a9),
//               borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(5), topLeft: Radius.circular(5)),
//             ),
//             alignment: Alignment.center,
//             child: Image(
//               image: AssetImage("assets/images/Facebook_logo.png"),
//               height: 35.0,
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(
//               color: Color(0xff2872ba),
//               borderRadius: BorderRadius.only(
//                   bottomRight: Radius.circular(5),
//                   topRight: Radius.circular(5)),
//             ),
//             alignment: Alignment.center,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text('Log in with Facebook',
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w400)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
