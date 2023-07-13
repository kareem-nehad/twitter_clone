import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/utils/constants.dart';
import '../../../controller/create_account_bloc/create_account_bloc.dart';

class CreateAccountScreenComponents {

  static Widget LoadingIndicator() {
    return Center(
      child: Lottie.asset(
        Constants.loading,
        width: 500.sp,
        height: 500.sp,
        fit: BoxFit.fill,
      ),
    );
  }

  static SnackBar SuccessSnackbar(BuildContext context) {
    return SnackBar(
      backgroundColor: Constants.successColor,
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Constants.whiteColor,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * 0.8,
        left: 20,
        right: 20,
      ),
      content: Container(
        child: Text(
          'Account Created Successfully',
          style: TextStyle(
            fontFamily: Constants.fontFamily,
          ),
        ),
      ),
    );
  }

  static SnackBar ErrorSnackbar(BuildContext context, CreateAccountState state) {
    return SnackBar(
      backgroundColor: Constants.errorColor,
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Constants.whiteColor,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * 0.8,
        left: 20,
        right: 20,
      ),
      content: Container(
        child: Text(
          state.message,
          style: TextStyle(
            fontFamily: Constants.fontFamily,
          ),
        ),
      ),
    );
  }

  static Widget NoInternet() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Sorry for the inconvenience...',
          style: TextStyle(fontFamily: Constants.fontFamily, fontWeight: Constants.lightFont, fontSize: 50.sp, color: Constants.whiteColor),
        ),
        SvgPicture.asset(
          Constants.noInternet,
          height: 800.sp,
          width: 800.sp,
          fit: BoxFit.fill,
        ),
        Text(
          'Please turn on Wi-Fi or mobile data to continue.',
          style: TextStyle(fontFamily: Constants.fontFamily, fontWeight: Constants.lightFont, fontSize: 50.sp, color: Constants.whiteColor),
        ),
      ],
    );
  }

  static Widget AppLogo() {
    return SvgPicture.asset(
      Constants.twitter,
      colorFilter: ColorFilter.mode(Constants.authForegroundColor, BlendMode.srcIn),
    );
  }
}