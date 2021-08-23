import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat/helpers/app_router.dart';
import 'package:chat/helpers/custom_dialoug.dart';
import 'package:chat/helpers/custom_progress.dart';
import 'package:chat/helpers/shared.dart';
import 'package:chat/provider/auth_provider.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:chat/ui/auth/modals/user_modal.dart';
import 'package:chat/ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:chat/widgets/custom_text_field.dart';

class Profile extends StatefulWidget {
  static const routeName = "/profile";

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _image;
  final ImagePicker picker = ImagePicker();
  Future selectOrTakePhoto(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        // AppRouter.route.pushNamed(PhotoProfile.routeName, {"photo": _image});
      }
    });
  }

  Future _showSelectionDialog() async {
    showDialog(
        context: context,
        builder: (context) {
          int val = 0;
          return AlertDialog(
            title: Text("Please select your profile photo"),
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text("From gallery"),
                    onTap: () => setState(() => val = 0),
                    leading: Radio<int>(
                      value: 0,
                      groupValue: val,
                      onChanged: (int? value) => setState(() => val = value!),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text("Take a photo"),
                    onTap: () => setState(() => val = 1),
                    leading: Radio<int>(
                      value: 1,
                      groupValue: val,
                      onChanged: (int? value) => setState(() => val = value!),
                    ),
                  ),
                  const Divider(),
                ],
              );
            }),
            actions: [
              TextButton(
                onPressed: () {
                  switch (val) {
                    case 0:
                      selectOrTakePhoto(ImageSource.gallery);
                      break;
                    case 1:
                      selectOrTakePhoto(ImageSource.camera);
                      break;
                    default:
                  }
                  AppRouter.route.back();
                },
                child: Text('ok'),
              )
            ],
          );
        });
  }

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
    final TextEditingController _country =
        TextEditingController(text: user.dataUser['country'] ?? "");
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _showSelectionDialog();
                },
                child: Container(
                  height: 150,
                  width: 150,
                  child: user.dataUser['photoPath'] == null && _image == null
                      ? Image.asset(
                          'assets/images/user.png') // set a placeholder image when no photo is set
                      : _image == null
                          ? Image.memory(
                              base64Decode(user.dataUser['photoPath']),
                              fit: BoxFit.contain,
                            )
                          : Image.file(
                              _image!,
                              fit: BoxFit.contain,
                            ),
                ),
              ),
              CustomTextField("Email",
                  textEditingController: _email, isEnable: false),
              CustomTextField("First Name", textEditingController: _firstName),
              CustomTextField("Last Name", textEditingController: _lastName),
              CustomTextField("Country", textEditingController: _country),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      String? id = SpHelper.spHelper.getData('uid');
                      Uint8List bytes;
                      String? encodeImage;
                      if (_image != null) {
                        bytes = await File(_image!.path).readAsBytes();
                        encodeImage = base64.encode(bytes);
                      }
                      UserModal userModal = UserModal(
                        id: id,
                        email: _email.text,
                        firstName: _firstName.text,
                        lastName: _lastName.text,
                        country: _country.text,
                        photoPath: encodeImage,
                      );
                      auth.loading = true;

                      await Provider.of<UserProvider>(context, listen: false)
                          .addUser(userModal);
                      CustomDialoug.customDialoug.showCustomDialoug(
                          "Successfully Saved", DialogType.SUCCES);
                      await SpHelper.spHelper.saveData('filledProfile', 'yes');
                      AppRouter.route.replacmentRoute(HomePage.routeName);
                    } on Exception catch (_) {
                      CustomDialoug.customDialoug.showCustomDialoug(
                          "Something is wrong", DialogType.ERROR);
                    } finally {
                      auth.loading = false;
                    }
                  },
                  child: auth.loading
                      ? CustomProgress.customProgress.showProgressIndicator()
                      : Text("Save")),
            ],
          ),
        ),
      ),
    );
  }
}
