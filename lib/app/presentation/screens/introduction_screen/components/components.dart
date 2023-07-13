import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../../core/utils/constants.dart';
import '../../log_in_screen/log_in_screen.dart';

class IntroductionScreenComponents {

  static Widget IntroLogo() {
    return SvgPicture.asset(
      Constants.twitter,
      height: 1000.0.sp,
      width: 1000.0.sp,
    );
  }

  static Widget LogIn(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Have an account already?',
          style: TextStyle(
              fontFamily: Constants.fontFamily,
              fontWeight: Constants.regularFont,
              fontSize: 35.sp,
              color: Constants.greyColor),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, PageTransition(child: LogInScreen(), type: PageTransitionType.rightToLeftPop, childCurrent: context.widget, curve: Curves.easeInExpo));
          },
          child: Text(
            ' Log in',
            style: TextStyle(
              fontFamily: Constants.fontFamily,
              fontWeight: Constants.regularFont,
              fontSize: 35.sp,
              color: Constants.primaryColor,
            ),
          ),
        )
      ],
    );
  }

}