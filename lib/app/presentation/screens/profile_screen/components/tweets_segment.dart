import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../domain/entities/tweet.dart';

class TweetsSegment extends StatelessWidget {
  const TweetsSegment({super.key, required this.tweets});

  final ValueNotifier<List<TweetObject>> tweets;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: tweets.value.length,
      separatorBuilder: (context, index) => Divider(color: Constants.greyColor, thickness: 1, indent: 20.sp, endIndent: 20.sp),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.sp),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 68.sp,
                child: ClipOval(
                  child: Image.network(
                    tweets.value[index].profilePicture,
                    height: 135.sp,
                    width: 135.sp,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          tweets.value[index].userName,
                          style: TextStyle(
                            color: Constants.whiteColor,
                            fontFamily: Constants.fontFamily,
                            fontWeight: Constants.boldFont,
                            fontSize: 40.sp,
                          ),
                        ),
                        SizedBox(
                          width: 30.sp,
                        ),
                        Text(
                          tweets.value[index].handle,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontFamily: Constants.fontFamily,
                            fontWeight: Constants.mediumFont,
                            fontSize: 30.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.sp),
                    Container(
                      width: 860.sp,
                      child: Text(
                        tweets.value[index].content,
                        style: TextStyle(
                          color: Constants.whiteColor,
                          fontFamily: Constants.fontFamily,
                          fontWeight: Constants.regularFont,
                          fontSize: 43.sp,
                        ),
                        textAlign: TextAlign.start,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
