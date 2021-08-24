import 'package:chat/provider/user_provider.dart';
import 'package:chat/ui/auth/modals/country_modal.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final UserProvider? user;
  final String type;
  CustomDropDown(this.user, this.type);

  @override
  Widget build(BuildContext context) {
    if (type == "String") {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(5),
          color: const Color(0xfff3f3f4),
          child: DropdownButton<String>(
            isExpanded: true,
            underline: Container(),
            onChanged: (value) => user!.selectCity(value!),
            items: user!.cities!.map((e) {
              return DropdownMenuItem<String>(
                child: Text(e),
                value: e,
              );
            }).toList(),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(5),
          color: const Color(0xfff3f3f4),
          child: DropdownButton<CountryModal>(
            isExpanded: true,
            underline: Container(),
            onChanged: (value) {
              user!.selectCountry(value!);
            },
            items: user!.countries.map((CountryModal? e) {
              return DropdownMenuItem<CountryModal>(
                child: Text(
                  e!.name!,
                  style: TextStyle(color: Colors.black),
                ),
                value: e,
              );
            }).toList(),
          ),
        ),
      );
    }
  }
}
