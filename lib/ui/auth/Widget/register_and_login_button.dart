import 'package:chat/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterAndLoginButton extends StatelessWidget {
  const RegisterAndLoginButton({
    Key? key,
    required TextEditingController email,
    required TextEditingController password,
    // required TextEditingController phoneNumber,
    required String title,
    required int action,
  })  : _email = email,
        _password = password,
        // _phoneNumber = phoneNumber,
        _title = title,
        _action = action,
        super(key: key);

  final TextEditingController _email;
  final TextEditingController _password;
  // final TextEditingController _phoneNumber;
  final String _title;
  final int _action; //1 => login - 2 => register
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, child) => GestureDetector(
        onTap: () {
          provider.email = _email;
          provider.password = _password;
          // provider.phoneNumber = _phoneNumber;
          if (_action == 1) {
            provider.login();
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
                  colors: [Color(0xfffbb448), Color(0xfff7892b)])),
          child: provider.loading
              ? CircularProgressIndicator()
              : Text(
                  '$_title',
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
        ),
      ),
    );
  }
}
