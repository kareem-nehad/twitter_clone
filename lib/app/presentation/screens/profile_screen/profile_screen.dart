import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twitter_clone/app/domain/entities/tweet.dart';
import 'package:twitter_clone/app/presentation/controller/profile_bloc/profile_bloc.dart';

import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  final String uID;

  ProfileScreen(this.uID, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<ProfileBloc>()..add(GetFullUserDataEvent(uID)),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          switch (state.status) {
            case ProfileStatus.success:
              print('SUCCESS');
              break;
            case ProfileStatus.failure:
              // TODO: Handle this case.
              break;
            case ProfileStatus.loading:
              // TODO: Handle this case.
              break;
          }
          return SafeArea(
            child: Scaffold(
              backgroundColor: Color(0xFF262C4C),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 80.sp),
                  CircleAvatar(
                    backgroundColor: Constants.whiteColor,
                    radius: 100.sp,
                    child: ClipOval(
                      child: Image.network(
                        state.userImage,
                        height: 200.sp,
                        width: 200.sp,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.sp),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        state.username,
                        style: TextStyle(
                          color: Constants.whiteColor,
                          fontFamily: Constants.fontFamily,
                          fontWeight: Constants.mediumFont,
                          fontSize: 50.sp,
                        ),
                      ),
                      Text(
                        state.uid,
                        style: TextStyle(
                          color: Constants.whiteColor,
                          fontFamily: Constants.fontFamily,
                          fontWeight: Constants.regularFont,
                          fontSize: 35.sp,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
