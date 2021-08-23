// import 'dart:io';

import 'package:flutter/cupertino.dart';

class UserModal {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? country;
  String? photoPath;
  UserModal({
    @required this.id,
    @required this.email,
    @required this.firstName,
    @required this.lastName,
    @required this.country,
    @required this.photoPath,
  });

  toMap() {
    return {
      'id': this.id,
      'email': this.email,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'country': this.country,
      'photoPath': this.photoPath,
    };
  }

  UserModal.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.email = map['email'];
    this.firstName = map['firstName'];
    this.lastName = map['lastName'];
    this.country = map['country'];
    this.photoPath = map['photoPath'];
  }
}