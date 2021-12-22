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
    Future.delayed(Duration(milliseconds: 100)).then((value) =>
        (_controller.hasClients)
            ? _controller.animateTo(_controller.position.maxScrollExtent,
                duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn)
            : false);

    return Consumer<UserProvider>(
        builder: (BuildContext context, UserProvider user, Widget? child) {
      return Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          title: Text(user.friend['firstName'] ?? "Chat"),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: user.getFromFirstore(user.uidOfUserAndFriend),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    QuerySnapshot<Map<dynamic, dynamic>>? querySnapshot;
                    List<Map<dynamic, dynamic>>? messages;
                    if (snapshot.hasData) {
                      querySnapshot = snapshot.data;
                      messages = querySnapshot!.docs
                          .map((QueryDocumentSnapshot<Map<dynamic, dynamic>>
                                  e) =>
                              e.data())
                          .toList();
                    }

                    return querySnapshot == null
                        ? CustomProgress.customProgress.spinKitHourGlass()
                        : messages!.length == 0
                            ? WelcomeFirstTime(user: user)
                            : ListViewMessages(
                                controller: _controller,
                                messages: messages,
                                uid: user.getUid,
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
      );
    });
  }
}
