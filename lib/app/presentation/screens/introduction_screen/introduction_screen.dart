import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                tag: 'twitterIcon',
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
                Navigator.pushNamed(context, '/createAccount');
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
                    onTap: () {},
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
