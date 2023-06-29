import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twitter_clone/app/presentation/controller/login_bloc/login_bloc.dart';
import 'package:twitter_clone/app/presentation/screens/home_screen/home_screen.dart';
import 'package:twitter_clone/core/utils/constants.dart';
import 'package:twitter_clone/core/utils/user_preferences.dart';

import '../../../../core/services/service_locator.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String email = '';
    String password = '';
    ValueNotifier<bool> rememberMe = ValueNotifier(false);
    return OfflineBuilder(
      connectivityBuilder: (context, connectivity, child) {
        final bool connected = connectivity != ConnectivityResult.none;
        if (connected) {
          return BlocProvider(
            create: (BuildContext context) => sl<LoginBloc>(),
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                switch (state.status) {
                  case LoginStatus.success:
                  // Go to home screen.
                    if (rememberMe.value) {
                      UserPreferences.setUserEmail(email);
                      UserPreferences.setUserPassword(password);
                    }
                    WidgetsBinding.instance.addPostFrameCallback(
                          (timeStamp) {
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                            child: HomeScreen(),
                            type: PageTransitionType.rightToLeftPop,
                            childCurrent: this,
                            curve: Curves.easeInExpo,
                          ),
                        );
                      },
                    );
                    break;
                  case LoginStatus.failure:
                    WidgetsBinding.instance.addPostFrameCallback(
                          (timeStamp) {
                        ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                          SnackBar(
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
                          ),
                        );
                      },
                    );
                    break;
                  case LoginStatus.loading:
                    WidgetsBinding.instance.addPostFrameCallback(
                          (timeStamp) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: Lottie.asset(
                                Constants.loading,
                                height: 500.sp,
                                width: 500.sp,
                                fit: BoxFit.fill,
                              ),
                            );
                          },
                        );
                      },
                    );
                    break;
                  case LoginStatus.awaiting:
                  // Do nothing.
                    break;
                }

                return SafeArea(
                  child: Scaffold(
                    backgroundColor: Constants.authBackgroundColor,
                    body: LayoutBuilder(
                      builder: (context, constraints) {
                        return Stack(
                          children: [
                            Positioned(
                              child: SvgPicture.asset(
                                Constants.twitter,
                                colorFilter: ColorFilter.mode(
                                  Constants.authForegroundColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                              right: constraints.maxWidth * 0.3,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Log in',
                                    style: TextStyle(
                                      fontFamily: Constants.fontFamily,
                                      fontWeight: Constants.mediumFont,
                                      fontSize: 75.sp,
                                      color: Constants.whiteColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 70.sp,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 55.sp),
                                    child: TextFormField(
                                      onChanged: (value) {
                                        email = value;
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Constants.whiteColor,
                                        hintText: 'Email address',
                                        prefixIcon: Icon(Icons.email),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 3,
                                            color: Constants.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 55.sp),
                                    child: TextFormField(
                                      onChanged: (value) {
                                        password = value;
                                      },
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Constants.whiteColor,
                                        hintText: 'Password',
                                        prefixIcon: Icon(Icons.lock),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 3,
                                            color: Constants.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 55.sp),
                                    child: Row(
                                      children: [
                                        ValueListenableBuilder(
                                            valueListenable: rememberMe,
                                            builder: (context, value, child) {
                                              return Checkbox(
                                                value: rememberMe.value,
                                                onChanged: (value) => rememberMe.value = value!,
                                              );
                                            }),
                                        Text(
                                          'Remember me',
                                          style: TextStyle(
                                            fontFamily: Constants.fontFamily,
                                            fontWeight: Constants.regularFont,
                                            color: Constants.whiteColor,
                                            fontSize: 40.sp,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 140.sp,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      FocusScope.of(context).requestFocus(new FocusNode());
                                      if (email == '' || password == '') {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            backgroundColor: Constants.errorColor,
                                            behavior: SnackBarBehavior.floating,
                                            showCloseIcon: true,
                                            margin: EdgeInsets.only(
                                              bottom: MediaQuery.of(context).size.height * 0.8,
                                              left: 20,
                                              right: 20,
                                            ),
                                            content: Container(
                                              child: Text(
                                                'Credentials can\'t be empty.',
                                                style: TextStyle(
                                                  fontFamily: Constants.fontFamily,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        context.read<LoginBloc>().add(Login(email: email, password: password));
                                      }
                                    },
                                    child: Text('Log in'),
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(400.sp, 120.sp),
                                      backgroundColor: Constants.primaryColor,
                                      textStyle: TextStyle(fontFamily: Constants.fontFamily),
                                      shape: StadiumBorder(),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 55.sp),
                                    child: GestureDetector(
                                      onTap: () {
                                        // Go to forgot password screen
                                      },
                                      child: Text(
                                        'Forgot password?',
                                        style: TextStyle(
                                          fontFamily: Constants.fontFamily,
                                          fontWeight: Constants.regularFont,
                                          color: Constants.whiteColor,
                                          fontSize: 45.sp,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Constants.authBackgroundColor,
              body: LayoutBuilder(
                builder: (context, constraints) => Stack(
                  children: [
                    Positioned(
                      child: SvgPicture.asset(
                        Constants.twitter,
                        colorFilter: ColorFilter.mode(
                          Constants.authForegroundColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      right: constraints.maxWidth * 0.3,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
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
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      },
      child: Center(
        child: Lottie.asset(
          Constants.loading,
          height: 500.sp,
          width: 500.sp,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
