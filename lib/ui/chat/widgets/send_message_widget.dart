import 'package:chat/helpers/firebase_storage.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:flutter/material.dart';

class SendMessageWidget extends StatelessWidget {
  const SendMessageWidget({
    Key? key,
    required this.message,
    required this.user,
    required ScrollController controller,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController message;
  final UserProvider user;
  final ScrollController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: message,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: IconButton(
              onPressed: () async {
                user.loadingPhoto = true;
                await user.uploadImageToChat();
                if (user.file != null) {
                  String? imageUrl;
                  if (user.file != null) {
                    imageUrl = await FireBaseStorageHelper.fireBaseStorageHelper
                        .uploadImageToChat(user.file!);
                    await user.sendtoFirstore(imageUrl);
                    user.loadingPhoto = false;
                  }
                }
              },
              icon: const Icon(Icons.image),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: IconButton(
              onPressed: () async {
                if (message.text.trim().isNotEmpty) {
                  await user.sendtoFirstore(message.text.trim());
                  if (_controller.hasClients)
                    _controller.animateTo(
                        _controller.position.maxScrollExtent + 100,
                        duration: Duration(seconds: 1),
                        curve: Curves.ease);
                  message.clear();
                }
              },
              icon: const Icon(Icons.send),
            ),
          )
        ],
      ),
    );
  }
}
