import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twitter_clone/app/presentation/screens/create_account_screen/create_account.dart';
import 'package:twitter_clone/app/presentation/screens/log_in_screen/log_in_screen.dart';
import 'package:twitter_clone/core/utils/constants.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.whiteColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Hero(
                tag: 'Intro Picture',
                child: SvgPicture.asset(
                  Constants.twitter,
                  height: 1000.0.sp,
                  width: 1000.0.sp,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 30,
                fontFamily: Constants.fontFamily,
                fontWeight: Constants.regularFont,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(
                'See what\'s happening in the world right now.',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: Constants.fontFamily,
                  fontWeight: Constants.regularFont,
                  color: Constants.greyColor,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, PageTransition(child: CreateAccountScreen(), type: PageTransitionType.rightToLeftPop, childCurrent: this, curve: Curves.easeIn));
              },
              child: Text('Create account'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants.primaryColor,
                textStyle: TextStyle(fontFamily: Constants.fontFamily),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Have an account already?',
                    style: TextStyle(
                        fontFamily: Constants.fontFamily,
                        fontWeight: Constants.regularFont,
                        fontSize: 13,
                        color: Constants.greyColor),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, PageTransition(child: LogInScreen(), type: PageTransitionType.rightToLeftPop, childCurrent: this, curve: Curves.easeIn));
                    },
                    child: Text(
                      ' Log in',
                      style: TextStyle(
                        fontFamily: Constants.fontFamily,
                        fontWeight: Constants.regularFont,
                        fontSize: 13,
                        color: Constants.primaryColor,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
