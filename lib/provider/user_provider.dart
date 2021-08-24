import 'package:chat/helpers/firestore_helper.dart';
import 'package:chat/helpers/shared.dart';
import 'package:chat/ui/auth/modals/country_modal.dart';
import 'package:chat/ui/auth/modals/user_modal.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  List<UserModal> users = <UserModal>[];
  List<CountryModal> countries = <CountryModal>[];
  List<dynamic>? cities = <dynamic>[];
  Map<String, dynamic> dataUser = <String, dynamic>{};
  CountryModal? selectedCountry;
  dynamic selectedCity;

  void selectCountry(CountryModal country) {
    this.selectedCountry = country;
    this.cities = country.cistis;
    notifyListeners();
  }

  void selectCity(dynamic city) {
    this.selectedCity = city;
    notifyListeners();
  }

  String email = "";
  UserProvider() {
    getAllUers();
    getAllCountries();
    // getCurrentUser();
  }

  Future<List<UserModal>> getAllUers() async {
    users = await FireStoreHelper.fireStoreHelper.getAllUsersFromFirestore();
    return users;
// check notify
  }

  Future<Map<String, dynamic>> getCurrentUser() async {
    final String? uid = SpHelper.spHelper.getData('uid');
    return await FireStoreHelper.fireStoreHelper.getUserFromFirestore(uid!);
  }

  Future<void> addUser(UserModal userModal) async {
    await FireStoreHelper.fireStoreHelper.addUserToFirestore(userModal);
  }

  Future<void> getAllCountries() async {
    countries = await FireStoreHelper.fireStoreHelper.getAllCountries();
    selectCountry(countries.first);
    selectCity(countries.first.cistis!.first);
    notifyListeners();
    // return countries;
  }
}
