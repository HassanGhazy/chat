import 'dart:io';

import 'package:chat/helpers/firestore_helper.dart';
import 'package:chat/ui/auth/modals/country_modal.dart';
import 'package:chat/ui/auth/modals/user_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class UserProvider with ChangeNotifier {
  UserProvider() {
    getAllUers();
    getAllCountries();
  }
  bool loading = false;
  List<UserModal> users = <UserModal>[];
  List<CountryModal> countries = <CountryModal>[];
  List<dynamic>? cities = <dynamic>[];
  Map<String, dynamic> dataUser = <String, dynamic>{};
  CountryModal? currentCountry;
  String? currentCity;
  File? file;
  void selectCountry(CountryModal country) {
    this.currentCountry = country;
    this.cities = country.cistis;
    this.currentCity = cities!.first;

    notifyListeners();
  }

  void selectCity(String city) {
    this.currentCity = city;
    notifyListeners();
  }

  Future<List<UserModal>> getAllUers() async {
    users = await FireStoreHelper.fireStoreHelper.getAllUsersFromFirestore();
    return users;
// check notify
  }

  Future<Map<String, dynamic>> getCurrentUser() async {
    return await FireStoreHelper.fireStoreHelper.getUserFromFirestore();
  }

  Future<void> addUser(UserModal userModal) async {
    await FireStoreHelper.fireStoreHelper.addUserToFirestore(userModal);
  }

  Future<void> getAllCountries() async {
    countries = await FireStoreHelper.fireStoreHelper.getAllCountries();
    selectCountry(countries.first);
    selectCity(countries.first.cistis!.first);
    notifyListeners();
  }

  uploadImage() async {
    XFile? imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    this.file = File(imageFile!.path);
    notifyListeners();
  }
}
