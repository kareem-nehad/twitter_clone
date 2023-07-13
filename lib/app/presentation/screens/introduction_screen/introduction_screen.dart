import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twitter_clone/app/presentation/screens/create_account_screen/create_account.dart';
import 'package:twitter_clone/app/presentation/screens/introduction_screen/components/components.dart';
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
              child: IntroductionScreenComponents.IntroLogo(),
            ),
            SizedBox(
              height: 30.sp,
            ),
            Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 100.sp,
                fontFamily: Constants.fontFamily,
                fontWeight: Constants.regularFont,
              ),
            ),
            SizedBox(
              height: 60.sp,
            ),
            Padding(
              padding: EdgeInsets.only(left: 90.sp, right: 90.sp),
              child: Text(
                'See what\'s happening in the world right now.',
                style: TextStyle(
                  fontSize: 50.sp,
                  fontFamily: Constants.fontFamily,
                  fontWeight: Constants.regularFont,
                  color: Constants.greyColor,
                ),
              ),
            ),
            SizedBox(
              height: 90.sp,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, PageTransition(child: CreateAccountScreen(), type: PageTransitionType.rightToLeftPop, childCurrent: this, curve: Curves.easeInExpo));
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
              padding: EdgeInsets.only(bottom: 70.sp),
              child: IntroductionScreenComponents.LogIn(context),
            )
          ],
        ),
      ),
    );
  }
}
