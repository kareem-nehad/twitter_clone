import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twitter_clone/app/domain/entities/tweet.dart';
import 'package:twitter_clone/app/presentation/screens/profile_screen/profile_screen.dart';
import 'package:twitter_clone/core/utils/constants.dart';
import 'package:intl/intl.dart';

import '../home_screen/components/home_nav_bar.dart';

class TweetDetailsScreen extends StatelessWidget {
  final TweetObject tweet;
  TweetDetailsScreen(this.tweet, {super.key,});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF262C4C),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: ProfileScreen(tweet.uID),
                            type: PageTransitionType.topToBottomPop,
                            childCurrent: this,
                            curve: Curves.easeInExpo,
                            settings: RouteSettings(arguments: tweet)
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(30.sp),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Constants.whiteColor,
                              radius: 100.sp,
                              child: ClipOval(
                                child: Image.network(
                                  tweet.profilePicture,
                                  height: 200.sp,
                                  width: 200.sp,
                                ),
                              ),
                            ),
                            SizedBox(width: 30.sp),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  tweet.userName,
                                  style: TextStyle(
                                    color: Constants.whiteColor,
                                    fontFamily: Constants.fontFamily,
                                    fontWeight: Constants.mediumFont,
                                    fontSize: 50.sp,
                                  ),
                                ),
                                Text(
                                  tweet.handle,
                                  style: TextStyle(
                                    color: Constants.whiteColor,
                                    fontFamily: Constants.fontFamily,
                                    fontWeight: Constants.regularFont,
                                    fontSize: 35.sp,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30.sp),
                    Padding(
                      padding: EdgeInsets.only(left: 35.sp, right: 10.sp),
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          tweet.content,
                          style: TextStyle(
                            color: Constants.whiteColor,
                            fontFamily: Constants.fontFamily,
                            fontWeight: Constants.lightFont,
                            fontSize: 50.sp,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.sp),
                    Divider(
                      endIndent: 60.sp,
                      indent: 60.sp,
                      thickness: 6.sp,
                    ),
                    SizedBox(
                      height: 40.sp,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          Constants.retweet,
                          height: 57.sp,
                          width: 57.sp,
                        ),
                        SvgPicture.asset(
                          Constants.like,
                          height: 57.sp,
                          width: 57.sp,
                        ),
                        SvgPicture.asset(
                          Constants.share,
                          height: 57.sp,
                          width: 57.sp,
                        ),
                      ],
                    ),
                    SizedBox(height: 30.sp),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 55.sp),
                      child: Container(
                        width: double.infinity,
                        height: 90.sp,
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(20.sp),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.sp),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Published: ',
                                style: TextStyle(
                                  color: Constants.whiteColor,
                                  fontFamily: Constants.fontFamily,
                                  fontWeight: Constants.regularFont,
                                  fontSize: 40.sp,
                                ),
                              ),
                              SizedBox(width: 20.sp),
                              Text(
                                Date(tweet.date),
                                style: TextStyle(
                                  color: Constants.whiteColor,
                                  fontFamily: Constants.fontFamily,
                                  fontWeight: Constants.regularFont,
                                  fontSize: 40.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Hero(
                  tag: 'bottomNav',
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: NavBar(),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  String Date(String date) {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String today = formatter.format(now);
    if (date == today) {
      return 'Today';
    } else {
      return date;
    }
  }
}
