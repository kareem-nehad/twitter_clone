import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/core/utils/constants.dart';

import '../home_screen/components/home_nav_bar.dart';

class TweetDetailsScreen extends StatelessWidget {
  const TweetDetailsScreen({super.key});

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
                    Padding(
                      padding: EdgeInsets.all(30.sp),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Constants.whiteColor,
                            radius: 100.sp,
                            child: Image.asset(
                              'assets/images/user_image.png',
                              height: 120.sp,
                              width: 120.sp,
                            ),
                          ),
                          SizedBox(width: 30.sp),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Kareem Mohamed',
                                style: TextStyle(
                                  color: Constants.whiteColor,
                                  fontFamily: Constants.fontFamily,
                                  fontWeight: Constants.mediumFont,
                                  fontSize: 50.sp,
                                ),
                              ),
                              Text(
                                '@kareemMohamed',
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
                    SizedBox(height: 30.sp),
                    Padding(
                      padding: EdgeInsets.only(left: 35.sp, right: 10.sp),
                      child: Text(
                        'This is a string to demonstrate the tweet details content, the aim is to see how it would look in the end.',
                        style: TextStyle(color: Constants.whiteColor, fontFamily: Constants.fontFamily, fontWeight: Constants.lightFont, fontSize: 50.sp),
                      ),
                    ),
                    SizedBox(height: 40.sp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(Constants.retweet),
                        SvgPicture.asset(
                          Constants.like,
                          height: 60.sp,
                          width: 60.sp,
                        ),
                      ],
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
}
