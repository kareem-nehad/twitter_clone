import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:twitter_clone/app/domain/entities/tweet.dart';
import 'package:twitter_clone/app/presentation/controller/profile_bloc/profile_bloc.dart';
import 'package:twitter_clone/app/presentation/screens/profile_screen/components/loaded_profile_screen.dart';

import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  final String uID;

  ProfileScreen(this.uID, {super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String> userImage = ValueNotifier('');
    final ValueNotifier<String> userName = ValueNotifier('');
    final ValueNotifier<String> uid = ValueNotifier('');
    final ValueNotifier<List<TweetObject>> tweets = ValueNotifier([]);

    return BlocProvider(
      create: (BuildContext context) => sl<ProfileBloc>()..add(GetFullUserDataEvent(uID)),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          switch (state.status) {
            case ProfileStatus.success:

              userImage.value = state.userImage;
              userName.value = state.username;
              uid.value = state.uid;
              tweets.value = state.tweets;
              return LoadedProfileScreen(userImage: userImage, username: userName, uid: uid,tweets: tweets,);
              break;
            case ProfileStatus.failure:
              // TODO: Handle this case.
              break;
            case ProfileStatus.loading:
              return SafeArea(
                child: Scaffold(
                  backgroundColor: Color(0xFF262C4C),
                  body: Center(
                    child: Lottie.asset(
                      Constants.loading,
                      height: 500.sp,
                      width: 500.sp,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              );
          }
          return Container();
        },
      ),
    );
  }
}
