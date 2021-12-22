import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat/helpers/app_router.dart';
import 'package:chat/helpers/custom_dialoug.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:chat/ui/auth/modals/user_modal.dart';
import 'package:chat/ui/chat/chat_page.dart';
import 'package:chat/ui/profile.dart';
import 'package:flutter/material.dart';

class ListViewUsers extends StatelessWidget {
  final UserProvider user;
  final List<UserModal>? list;
  ListViewUsers(this.user, [this.list]);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: list != null
              ? Text('${list![index].firstName!} ${list![index].lastName!}')
              : Text(
                  '${user.users[index].firstName!} ${user.users[index].lastName!}'),
          leading: CircleAvatar(
            backgroundImage: list != null
                ? list![index].photoPath == null || list![index].photoPath == ""
                    ? null
                    : NetworkImage(list![index].photoPath!)
                : user.users[index].photoPath == null ||
                        user.users[index].photoPath == ""
                    ? null
                    : NetworkImage(user.users[index].photoPath!),
            child: list != null
                ? list![index].photoPath == null || list![index].photoPath == ""
                    ? Image.asset('assets/images/user.png')
                    : null
                : user.users[index].photoPath == null ||
                        user.users[index].photoPath == ""
                    ? Image.asset('assets/images/user.png')
                    : null,
          ),
          onTap: () {
            user.friend.update('photoPath', (value) {
              if (list != null) {
                value = list![index].photoPath ?? "";
              } else
                value = user.users[index].photoPath ?? "";
              return value;
            });
            user.friend.update('firstName', (value) {
              if (list != null) {
                value = list![index].firstName ?? "";
              } else
                value = user.users[index].firstName ?? "";
              return value;
            });
            user.friend.update('lastName', (value) {
              if (list != null) {
                value = list![index].lastName ?? "";
              } else
                value = user.users[index].lastName ?? "";
              return value;
            });
            user.friend.update('id', (value) {
              if (list != null) {
                value = list![index].id ?? "";
              } else
                value = user.users[index].id ?? "";
              return value;
            });

            /// the code below to compute the uid of two users
            /// you can't just say myUid then the uid of my friend
            /// because if you loged the collection will be uid + uidFriend
            /// and if the friend logged the collection will be uidFriend + uid
            /// and that's wrong :) meow
            int p1 = 0;
            int p2 = 0;
            final String myUid = user.getUid;
            final String friendUid = user.friend['id'];
            if (friendUid != myUid) {
              while (p1 < friendUid.length && p2 < myUid.length) {
                if (friendUid.codeUnitAt(p1) > myUid.codeUnitAt(p2)) {
                  user.changeChat(friendUid + myUid);
                  break;
                } else if (friendUid.codeUnitAt(p1) < myUid.codeUnitAt(p2)) {
                  user.changeChat(myUid + friendUid);
                  break;
                }
                p1++;
                p2++;
              }
            } else {
              user.changeChat(myUid + friendUid);
            }

            if (user.dataUser.isEmpty) {
              CustomDialoug.customDialoug.showCustomDialoug(
                'you need to fill your profile at first',
                DialogType.INFO,
                () => AppRouter.route.pushNamed(Profile.routeName, {}),
              );
            } else
              AppRouter.route.pushNamed(ChatPage.routeName, {});
          },
        );
      },
      itemCount: list != null ? list!.length : user.users.length,
    );
  }
}
