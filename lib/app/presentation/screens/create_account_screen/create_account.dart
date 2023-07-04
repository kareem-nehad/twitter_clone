import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twitter_clone/app/domain/entities/auth_arguments.dart';
import 'package:twitter_clone/app/presentation/controller/create_account_bloc/create_account_bloc.dart';
import 'package:twitter_clone/app/presentation/screens/introduction_screen/introduction_screen.dart';
import 'package:twitter_clone/app/presentation/screens/set_profile_picture_screen/set_profile_picture_screen.dart';
import 'package:twitter_clone/core/utils/constants.dart';

import '../../../../core/services/service_locator.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String username = '';
    String email = '';
    String password = '';
    ValueNotifier<bool> charLimit = ValueNotifier(false);
    ValueNotifier<bool> containsNumbers = ValueNotifier(false);
    ValueNotifier<bool> containsUppercase = ValueNotifier(false);

    return OfflineBuilder(
      connectivityBuilder: (context, connectivity, child) {
        final bool connected = connectivity != ConnectivityResult.none;
        if (connected) {
          return BlocProvider(
            create: (BuildContext context) => sl<CreateAccountBloc>(),
            child: BlocBuilder<CreateAccountBloc, CreateAccountState>(
              builder: (context, state) {
                switch (state.status) {
                  case AuthStatus.unauthenticated:
                    break;
                  case AuthStatus.loading:
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Center(
                            child: Lottie.asset(
                              Constants.loading,
                              width: 500.sp,
                              height: 500.sp,
                              fit: BoxFit.fill,
                            ),
                          );
                        },
                      );
                    });
                    break;
                  case AuthStatus.success:
                    Navigator.pop(context);
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                      ));
                    });
                    // Navigator.push(
                    //   context,
                    //   PageTransition(
                    //     child: SetProfilePictureScreen(),
                    //     type: PageTransitionType.rightToLeftPop,
                    //     childCurrent: this,
                    //     curve: Curves.easeInExpo,
                    //   ),
                    // );
                    break;
                  case AuthStatus.failure:
                    Navigator.pop(context);
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      ScaffoldMessenger.maybeOf(context)?.showSnackBar(SnackBar(
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
                      ));
                    });
                    break;
                }

                return SafeArea(
                  child: Scaffold(
                    backgroundColor: Constants.authBackgroundColor,
                    body: LayoutBuilder(
                      builder: (context, constraints) => Stack(
                        children: [
                          Positioned(
                            child: SvgPicture.asset(
                              Constants.twitter,
                              colorFilter: ColorFilter.mode(Constants.authForegroundColor, BlendMode.srcIn),
                            ),
                            right: constraints.maxWidth * 0.3,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Create your account',
                                  style: TextStyle(
                                    fontFamily: Constants.fontFamily,
                                    fontWeight: Constants.mediumFont,
                                    fontSize: 70.sp,
                                    color: Constants.whiteColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 80.sp,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 55.sp,
                                  ),
                                  child: TextFormField(
                                    onChanged: (value) {
                                      username = value;
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Constants.whiteColor,
                                      hintText: 'Username',
                                      prefixIcon: Icon(Icons.person),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 3.sp,
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
                                      email = value;
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Constants.whiteColor,
                                      hintText: 'Email address',
                                      prefixIcon: Icon(Icons.email),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 3.sp, color: Constants.whiteColor),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 55.sp),
                                  child: TextFormField(
                                    onChanged: (value) {
                                      password = value;
                                      print(value);

                                      if (password.length >= 8) {
                                        charLimit.value = true;
                                      } else {
                                        charLimit.value = false;
                                      }

                                      if (password.contains(new RegExp(r'[0-9]'))) {
                                        containsNumbers.value = true;
                                      } else {
                                        containsNumbers.value = false;
                                      }

                                      if (value.contains(new RegExp(r'[A-Z]'))) {
                                        containsUppercase.value = true;
                                      } else {
                                        containsUppercase.value = false;
                                      }
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
                                SizedBox(
                                  height: 120.sp,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    FocusScope.of(context).requestFocus(new FocusNode());
                                    if (username == '' || email == '' || password == '') {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                                          ),
                                        ),
                                      ));
                                    } else {
                                      if (charLimit.value && containsNumbers.value && containsUppercase.value) {
                                        // context.read<CreateAccountBloc>().add(CreateAccount(email: email, password: password, username: username));
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            child: SetProfilePictureScreen(),
                                            type: PageTransitionType.rightToLeftPop,
                                            childCurrent: this,
                                            curve: Curves.easeInExpo,
                                            settings: RouteSettings(
                                              arguments: AuthArguments(email: email, password: password, username: username),
                                            ),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          backgroundColor: Colors.redAccent,
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
                                              'Password must satisfy all constraints.',
                                            ),
                                          ),
                                        ));
                                      }
                                    }
                                  },
                                  child: Text('Register'),
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(400.sp, 120.sp),
                                    backgroundColor: Constants.primaryColor,
                                    textStyle: TextStyle(fontFamily: Constants.fontFamily),
                                    shape: StadiumBorder(),
                                  ),
                                ),
                                SizedBox(
                                  height: 160.sp,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 55.sp),
                                  child: Row(
                                    children: [
                                      ValueListenableBuilder(
                                          valueListenable: charLimit,
                                          builder: (context, value, child) {
                                            return Icon(
                                              value ? Icons.check : Icons.close,
                                              color: value ? Constants.successColor : Constants.errorColor,
                                            );
                                          }),
                                      ValueListenableBuilder(
                                          valueListenable: charLimit,
                                          builder: (context, value, child) {
                                            return Text(
                                              'Contains at least 8 characters.',
                                              style: TextStyle(
                                                fontFamily: Constants.fontFamily,
                                                fontWeight: Constants.regularFont,
                                                fontSize: 45.sp,
                                                color: value ? Constants.successColor : Constants.errorColor,
                                              ),
                                            );
                                          })
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 55.sp),
                                  child: Row(
                                    children: [
                                      ValueListenableBuilder(
                                          valueListenable: containsNumbers,
                                          builder: (context, value, child) {
                                            return Icon(
                                              value ? Icons.check : Icons.close,
                                              color: value ? Constants.successColor : Constants.errorColor,
                                            );
                                          }),
                                      ValueListenableBuilder(
                                          valueListenable: containsNumbers,
                                          builder: (context, value, child) {
                                            return Text(
                                              'Contains numbers.',
                                              style: TextStyle(
                                                fontFamily: Constants.fontFamily,
                                                fontWeight: Constants.regularFont,
                                                fontSize: 45.sp,
                                                color: value ? Constants.successColor : Constants.errorColor,
                                              ),
                                            );
                                          })
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 55.sp),
                                  child: Row(
                                    children: [
                                      ValueListenableBuilder(
                                          valueListenable: containsUppercase,
                                          builder: (context, value, child) {
                                            return Icon(
                                              value ? Icons.check : Icons.close,
                                              color: value ? Constants.successColor : Constants.errorColor,
                                            );
                                          }),
                                      ValueListenableBuilder(
                                          valueListenable: containsUppercase,
                                          builder: (context, value, child) {
                                            return Text(
                                              'Contains uppercase characters.',
                                              style: TextStyle(
                                                fontFamily: Constants.fontFamily,
                                                fontWeight: Constants.regularFont,
                                                fontSize: 45.sp,
                                                color: value ? Constants.successColor : Constants.errorColor,
                                              ),
                                            );
                                          })
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
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
