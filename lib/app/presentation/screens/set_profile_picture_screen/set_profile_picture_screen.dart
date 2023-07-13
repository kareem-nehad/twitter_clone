import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:twitter_clone/app/domain/entities/auth_arguments.dart';
import 'package:twitter_clone/app/presentation/controller/create_account_bloc/create_account_bloc.dart';
import 'package:twitter_clone/app/presentation/screens/home_screen/home_screen.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/constants.dart';

class SetProfilePictureScreen extends StatelessWidget {
  const SetProfilePictureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as AuthArguments;
    ValueNotifier<String> imageName = ValueNotifier('');
    ValueNotifier<String> imagePath = ValueNotifier('');
    return BlocProvider(
      create: (context) => sl<CreateAccountBloc>(),
      child: BlocBuilder<CreateAccountBloc, CreateAccountState>(
        builder: (context, state) {
          switch(state.status) {

            case AuthStatus.success:
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    child: HomeScreen(),
                    type: PageTransitionType.rightToLeftPop,
                    childCurrent: this,
                    curve: Curves.easeInExpo,
                  ),
                );
              });
              break;
            case AuthStatus.failure:
              print('FAILURE');
              break;
            case AuthStatus.loading:
              // TODO: Handle this case.
              break;
            case AuthStatus.unauthenticated:
              // TODO: Handle this case.
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
                          Padding(
                            padding: EdgeInsets.only(bottom: 55.sp),
                            child: Text(
                              'Set Profile Picture',
                              style: TextStyle(
                                color: Constants.whiteColor,
                                fontFamily: Constants.fontFamily,
                                fontWeight: Constants.mediumFont,
                                fontSize: 70.sp,
                              ),
                            ),
                          ),
                          GestureDetector(
                            child: ValueListenableBuilder(
                              valueListenable: imagePath,
                              builder: (BuildContext context, String value, Widget? child) {
                                return CircleAvatar(
                                  backgroundColor: Constants.whiteColor,
                                  radius: 300.sp,
                                  child: ClipOval(
                                    child: imagePath.value == ''
                                        ? Image.asset(
                                            'assets/images/user_image.png',
                                            height: 300.sp,
                                            width: 300.sp,
                                          )
                                        : Image.file(File(imagePath.value)),
                                  ),
                                );
                              },
                            ),
                            onTap: () async {
                              XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                              imageName.value = pickedImage!.name;
                              imagePath.value = pickedImage.path;
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 55.sp, bottom: 55.sp),
                            child: ElevatedButton(
                              onPressed: () async {
                                print(imageName.value);
                                context.read<CreateAccountBloc>().add(CreateAccountWithImage(email: args.email, password: args.password, username: args.username, imageName: imagePath.value));
                              },
                              child: Text('Continue'),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(400.sp, 120.sp),
                                backgroundColor: Constants.primaryColor,
                                textStyle: TextStyle(fontFamily: Constants.fontFamily),
                                shape: StadiumBorder(),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.read<CreateAccountBloc>().add(CreateAccount(email: args.email, password: args.password, username: args.username));
                            },
                            child: Text(
                              'Skip',
                              style: TextStyle(color: Constants.whiteColor, fontFamily: Constants.fontFamily, fontSize: 40.sp),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}