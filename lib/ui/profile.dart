import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat/helpers/app_router.dart';
import 'package:chat/helpers/custom_dialoug.dart';
import 'package:chat/helpers/custom_progress.dart';
import 'package:chat/helpers/firebase_storage.dart';
import 'package:chat/provider/auth_provider.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:chat/ui/auth/modals/country_modal.dart';
import 'package:chat/ui/auth/modals/user_modal.dart';
import 'package:chat/ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat/widgets/custom_text_field.dart';

class Profile extends StatelessWidget {
  static const routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    final UserProvider user = Provider.of<UserProvider>(context, listen: false);
    final AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);

    final TextEditingController _email =
        TextEditingController(text: user.dataUser['email'] ?? auth.email.text);
    final TextEditingController _firstName =
        TextEditingController(text: user.dataUser['firstName'] ?? "");
    final TextEditingController _lastName =
        TextEditingController(text: user.dataUser['lastName'] ?? "");

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: Consumer<UserProvider>(
        builder: (context, user, child) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // _showSelectionDialog();
                    user.uploadImage();
                  },
                  child: Container(
                      height: 150,
                      width: 150,
                      child: user.dataUser['photoPath'] == null &&
                              user.file == null
                          ? Image.asset(
                              'assets/images/user.png') // set a placeholder image when no photo is set
                          : user.file == null
                              ? Image.network(user.dataUser['photoPath'])
                              : Image.file(user.file!, fit: BoxFit.cover)),
                ),
                CustomTextField("Email",
                    textEditingController: _email, isEnable: false),
                CustomTextField("First Name",
                    textEditingController: _firstName),
                CustomTextField("Last Name", textEditingController: _lastName),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    color: const Color(0xfff3f3f4),
                    child: DropdownButton<CountryModal>(
                      value: user.currentCountry,
                      isExpanded: true,
                      underline: Container(),
                      onChanged: (value) {
                        user.selectCountry(value!);
                      },
                      items: user.countries.map((CountryModal? e) {
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
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    color: const Color(0xfff3f3f4),
                    child: DropdownButton<String>(
                      value: user.currentCity,
                      isExpanded: true,
                      underline: Container(),
                      onChanged: (value) {
                        user.selectCity(value!);
                      },
                      items: user.cities!.map((e) {
                        return DropdownMenuItem<String>(
                          child: Text(e),
                          value: e,
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        String? id = auth.getCurrentUid();
                        print(user.file);
                        String imageUrl = await FireBaseStorageHelper
                            .fireBaseStorageHelper
                            .uploadImage(user.file!);
                        print(imageUrl);
                        UserModal userModal = UserModal(
                          id: id,
                          email: _email.text,
                          firstName: _firstName.text,
                          lastName: _lastName.text,
                          country: user.currentCountry!.name,
                          city: user.currentCity,
                          photoPath: user.file == null
                              ? user.dataUser['photoPath']
                              : imageUrl,
                        );
                        user.loading = true;

                        await Provider.of<UserProvider>(context, listen: false)
                            .addUser(userModal);
                        AppRouter.route.replacmentRoute(HomePage.routeName);
                        CustomDialoug.customDialoug.showCustomDialoug(
                            "Successfully Saved", DialogType.SUCCES);
                        // await SpHelper.spHelper.saveData('filledProfile', 'yes');
                      } on Exception catch (_) {
                        CustomDialoug.customDialoug.showCustomDialoug(
                            "Something is wrong", DialogType.ERROR);
                      } finally {
                        user.loading = false;
                      }
                    },
                    child: user.loading
                        ? CustomProgress.customProgress.showProgressIndicator()
                        : Text("Save")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
