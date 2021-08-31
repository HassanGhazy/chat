import 'package:chat/helpers/custom_progress.dart';
import 'package:chat/provider/auth_provider.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterAndLoginButton extends StatelessWidget {
  const RegisterAndLoginButton({
    Key? key,
    required TextEditingController email,
    required TextEditingController password,
    // required TextEditingController firstName,
    // required TextEditingController lastName,
    // required TextEditingController country,
    required String title,
    required int action,
  })  : _email = email,
        _password = password,
        // _phoneNumber = phoneNumber,
        _title = title,
        // _firstName = firstName,
        // _lastName = lastName,
        // _country = country,
        _action = action,
        super(key: key);

  final TextEditingController _email;
  // final TextEditingController _firstName;
  // final TextEditingController _lastName;
  // final TextEditingController _country;
  final TextEditingController _password;
  // final TextEditingController _phoneNumber;
  final String _title;
  final int _action; //1 => login - 2 => register
  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, UserProvider>(
      builder: (BuildContext context, AuthProvider provider, UserProvider user,
              Widget? child) =>
          GestureDetector(
        onTap: () async {
          provider.email = _email;
          provider.password = _password;
          // provider.firstName = _firstName;
          // provider.lastName = _lastName;
          // provider.country = _country;
          // provider.phoneNumber = _phoneNumber;
          if (_action == 1) {
            provider.login();
            await user.getAllUers();
          } else if (_action == 2) {
            provider.register();
          } else if (_action == 3) {
            provider.resetPassword();
          }
          //  else {
          //   provider.loginWithPhone();
          // }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: const <Color>[Color(0xfffbb448), Color(0xfff7892b)])),
          child: provider.loading
              ? CustomProgress.customProgress.showProgressIndicator()
              : Text(
                  '$_title',
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
        ),
      ),
    );
  }
}
