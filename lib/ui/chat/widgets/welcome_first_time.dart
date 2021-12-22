import 'package:chat/provider/user_provider.dart';
import 'package:chat/ui/chat/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class WelcomeFirstTime extends StatelessWidget {
  const WelcomeFirstTime({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserProvider user;

  @override
  Widget build(BuildContext context) {
    final bool nameOfMembersExist =
        user.dataUser['firstName'] != null && user.friend['firstName'] != "";
    final bool myProfile = user.friend['id'] == user.getUid;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 100,
          width: 100,
          child: Image.asset(
            'assets/images/welcome.png',
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 20),
        nameOfMembersExist
            ? myProfile
                ? Padding(
                    padding: const EdgeInsets.all(15),
                    child: CustomText(
                        'This is your space. Draft messages, list your to-dos, or keep links and files handy. You can also talk to yourself here, but please bear in mind you’ll have to supply both sides of the conversation.'),
                  )
                : CustomText(
                    '${user.dataUser['firstName']} and ${user.friend['firstName']}',
                  )
            : Container(),
        const SizedBox(height: 20),
        myProfile ? Container() : CustomText('Start chating now')
      ],
    );
  }
}
