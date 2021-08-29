import 'package:chat/helpers/custom_progress.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:chat/ui/chat/widgets/listview_messages.dart';
import 'package:chat/ui/chat/widgets/send_message_widget.dart';
import 'package:chat/ui/chat/widgets/welcome_first_time.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  static const String routeName = '/chat-page';
  final TextEditingController message = TextEditingController();
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (_controller.hasClients) {
        _controller.animateTo(_controller.position.maxScrollExtent,
            duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      }
    });

    return Consumer<UserProvider>(
      builder: (context, user, child) => Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          title: Text(user.friend['firstName'] ?? "Chat"),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: user.getFromFirstore(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    QuerySnapshot<Map<dynamic, dynamic>>? querySnapshot;
                    List<Map>? messages;
                    if (snapshot.hasData) {
                      querySnapshot = snapshot.data;
                      messages =
                          querySnapshot!.docs.map((e) => e.data()).toList();
                    }
                    String uid = user.getUid;

                    return querySnapshot == null
                        ? CustomProgress.customProgress.spinKitHourGlass()
                        : messages!.length == 0
                            ? WelcomeFirstTime(user: user)
                            : ListViewMessages(
                                controller: _controller,
                                messages: messages,
                                uid: uid,
                                user: user,
                              );
                  },
                ),
              ),
            ),
            SendMessageWidget(
              message: message,
              controller: _controller,
              user: user,
            )
          ],
        ),
      ),
    );
  }
}
