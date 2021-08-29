import 'dart:io';

import 'package:chat/helpers/auth_helper.dart';
import 'package:chat/helpers/firebase_storage.dart';
import 'package:chat/helpers/firestore_helper.dart';
import 'package:chat/ui/auth/modals/country_modal.dart';
import 'package:chat/ui/auth/modals/user_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class UserProvider with ChangeNotifier {
  UserProvider() {
    // getAllUers();
    getAllCountries();
    // getCurrentUser();
  }
  Map<String, dynamic> friend = <String, dynamic>{
    'photoPath': "",
    'firstName': "",
    'lastName': "",
    'id': "",
  };
  bool loading = false;
  bool loadingPhoto = false;
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

  void busy() {
    loading = !loading;
    notifyListeners();
  }

  void selectCity(String city) {
    this.currentCity = city;
    notifyListeners();
  }

  Future<List<UserModal>> getAllUers() async {
    users = await FireStoreHelper.fireStoreHelper.getAllUsersFromFirestore();
    users.removeWhere((element) => element.id == getUid);
    notifyListeners();
    return users;
  }

  get getUid {
    return AuthHelper.authHelper.getUid();
  }

  Future<Map<String, dynamic>> getCurrentUser() async {
    dataUser = await FireStoreHelper.fireStoreHelper.getUserFromFirestore();
    return dataUser;
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

  Future<void> uploadImage() async {
    XFile? imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile != null) this.file = File(imageFile.path);
    notifyListeners();
  }

  Future<void> uploadImageToChat() async {
    XFile? imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      this.file = File(imageFile.path);
      FireBaseStorageHelper.fireBaseStorageHelper.uploadImageToChat(file!);
    }

    notifyListeners();
  }

  Future<void> sendtoFirstore(String message) async {
    await FireStoreHelper.fireStoreHelper.addMessage({
      'message': message,
      'time': DateTime.now(),
      'userId': AuthHelper.authHelper.getUid()
    });
  }

  Future<String> getImageFromUid(String uid) async {
    return await FireStoreHelper.fireStoreHelper.getImageFromFirestore(uid);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getFromFirstore() {
    return FireStoreHelper.fireStoreHelper.getFirestoreStream();
  }
}
