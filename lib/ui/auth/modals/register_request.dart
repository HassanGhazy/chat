import 'package:flutter/cupertino.dart';

class RegisterRequest {
  String? id;
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? country;
  RegisterRequest({
    @required this.id,
    @required this.email,
    @required this.password,
    @required this.firstName,
    @required this.lastName,
    @required this.country,
  });

  toMap() {
    return {
      'id': this.id,
      'email': this.email,
      'password': this.password,
      'firstNam': this.firstName,
      'lastName': this.lastName,
      'country': this.country,
    };
  }
}
