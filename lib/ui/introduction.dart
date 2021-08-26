import 'package:chat/helpers/app_router.dart';
import 'package:chat/helpers/shared.dart';
import 'package:chat/helpers/sizeConfig.dart';
import 'package:chat/ui/auth/welcomePage.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Introduction extends StatefulWidget {
  @override
  _IntroductionState createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  final GlobalKey<IntroductionScreenState> introKey =
      GlobalKey<IntroductionScreenState>();
  bool isFirst = true;
  void _onIntroEnd() => AppRouter.route.replacmentRoute(WelcomePage.routeName);
  Widget _buildImage(String name, {double width = 350, double? height}) =>
      Image.asset('assets/images/$name', width: width, height: height);

  // Image.asset(
  //   'assets/images/Bg.png',
  //   fit: BoxFit.cover,
  //   height: double.infinity,
  //   width: double.infinity,
  //   alignment: Alignment.center,
  // ),

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor:
          isFirst ? const Color(0xffF6D266) : const Color(0xffffffff),
      showNextButton: false,
      showDoneButton: true,
      showSkipButton: true,
      dotsFlex: 3,
      animationDuration: 600,
      dotsDecorator: DotsDecorator(
          size: Size.square(10.0),
          activeSize: Size.square(15),
          activeColor: isFirst ? const Color(0xffffffff) : Colors.orange),
      scrollPhysics: RangeMaintainingScrollPhysics(),
      onChange: (value) {
        value == 0 ? isFirst = true : isFirst = false;
        setState(() {});
      },
      globalHeader: _buildImage(!isFirst ? 'Logo.png' : 'LogoNoColor.png',
          width: SizeConfig.sizeConfig.width!),
      pages: [
        PageViewModel(
          reverse: true,
          titleWidget: SizedBox(height: 200),
          bodyWidget: _buildImage('Decoration.png',
              width: SizeConfig.sizeConfig.width!),
          decoration: PageDecoration(
            contentMargin: EdgeInsets.zero,
            footerPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            imagePadding: EdgeInsets.zero,
            imageAlignment: Alignment.center,
            boxDecoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xffFDA184),
                  Color(0xffF6D266),
                ],
              ),
            ),
          ),
        ),
        PageViewModel(
          titleWidget: const SizedBox(height: 40),
          body:
              "Download the Stockpile app and master the market with our mini-lesson.",
          image: _buildImage('star.png'),
        ),
        PageViewModel(
          titleWidget: const SizedBox(height: 40),
          body: "Another beautiful body text for this example onboarding",
          image: _buildImage('shield.png'),
        ),
      ],
      skip: ElevatedButton(
          onPressed: () {
            SpHelper.spHelper.saveData('firstTime', 'No');
            _onIntroEnd();
          },
          child: Text("Skip")),
      done: ElevatedButton(
          onPressed: () {
            SpHelper.spHelper.saveData('firstTime', 'No');
            _onIntroEnd();
          },
          child: Text("Done")),
      onSkip: () => _onIntroEnd(),
      onDone: () => _onIntroEnd(),
    );
  }
}
