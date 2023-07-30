import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:twitter_clone/app/presentation/screens/profile_screen/components/retweets_segment.dart';
import 'package:twitter_clone/app/presentation/screens/profile_screen/components/tweets_segment.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../domain/entities/tweet.dart';

class LoadedProfileScreen extends StatelessWidget {
  const LoadedProfileScreen({super.key, required this.userImage, required this.username, required this.uid, required this.tweets});

  final ValueNotifier<String> userImage, username, uid;
  final ValueNotifier<List<TweetObject>> tweets;

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> currentSelection = ValueNotifier(0);

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
                  userImage.value,
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
                  username.value,
                  style: TextStyle(
                    color: Constants.whiteColor,
                    fontFamily: Constants.fontFamily,
                    fontWeight: Constants.mediumFont,
                    fontSize: 50.sp,
                  ),
                ),
                Text(
                  uid.value,
                  style: TextStyle(
                    color: Constants.whiteColor,
                    fontFamily: Constants.fontFamily,
                    fontWeight: Constants.regularFont,
                    fontSize: 35.sp,
                  ),
                )
              ],
            ),
            SizedBox(height: 50.sp),
            ValueListenableBuilder(
              valueListenable: currentSelection,
              builder: (context, value, child) {
                return MaterialSegmentedControl(
                  children: {0: Text('Tweets'), 1: Text('Retweets'), 2: Text('Likes')},
                  selectionIndex: value,
                  borderColor: Colors.transparent,
                  unselectedColor: Colors.transparent,
                  selectedColor: Colors.transparent,
                  selectedTextStyle: TextStyle(
                    color: Constants.primaryColor,
                    fontFamily: Constants.fontFamily,
                    fontSize: 40.sp,
                  ),
                  unselectedTextStyle: TextStyle(
                    color: Constants.whiteColor,
                      fontFamily: Constants.fontFamily,
                      fontSize: 40.sp,
                  ),
                  disabledChildren: [3],
                  onSegmentTapped: (index) {
                    currentSelection.value = index;
                  },
                );
              },
            ),
            Divider(
              color: Constants.whiteColor,
              thickness: 0.25,
              indent: 100.sp,
              endIndent: 100.sp,
            ),
            SizedBox(height: 30.sp),
            ValueListenableBuilder(
              valueListenable: currentSelection,
              builder: (context, value, child) {
                switch (value) {
                  case 0:
                    return TweetsSegment(tweets: tweets,);
                  case 1:
                    return RetweetsSegment();
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
