import 'package:chat/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:chat/ui/chat/full_image.dart';

class ListViewMessages extends StatelessWidget {
  const ListViewMessages({
    Key? key,
    required ScrollController controller,
    required this.messages,
    required this.uid,
    required this.user,
  })  : _controller = controller,
        super(key: key);

  final ScrollController _controller;
  final UserProvider user;
  final List<Map>? messages;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      controller: _controller,
      itemBuilder: (context, index) {
        bool photoCurrentAccount = user.dataUser['photoPath'] != null &&
            messages![index]['userId'] == uid &&
            user.dataUser['photoPath'] != "";
        bool photoCurrentTeam = !photoCurrentAccount &&
            user.friend['photoPath'] != "" &&
            user.friend['photoPath'] != null &&
            messages![index]['userId'] != uid;

        return Padding(
          padding: const EdgeInsets.all(4),
          child: Directionality(
            textDirection: messages![index]['userId'] == uid
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      '${timeago.format(messages![index]['time'].toDate(), allowFromNow: true)}',
                      style: TextStyle(color: Colors.white),
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: messages![index]['userId'] == uid
                          ? Theme.of(context).primaryColor
                          : Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Uri.parse(messages![index]['message']).isAbsolute
                        ? GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => FullImage(
                                    src: messages![index]['message'],
                                    tag: 'dash$index',
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'dash$index',
                              transitionOnUserGestures: true,
                              child: Image.network(messages![index]['message']),
                            ),
                          )
                        : ListTile(
                            trailing: photoCurrentAccount
                                ? CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        user.dataUser['photoPath']),
                                  )
                                : photoCurrentTeam
                                    ? CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          user.friend['photoPath'],
                                        ),
                                      )
                                    : CircleAvatar(
                                        child: Image.asset(
                                            'assets/images/user.png'),
                                      ),
                            title: Text(
                              messages![index]['message'],
                              textDirection: TextDirection.ltr,
                              textAlign: messages![index]['userId'] == uid
                                  ? TextAlign.right
                                  : TextAlign.left,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: messages!.length,
    );
  }
}
