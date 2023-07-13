import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/app/data/source/feed_data_source.dart';
import 'package:twitter_clone/app/presentation/screens/home_screen/components/side_nav.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/user_preferences.dart';
import '../../../../domain/entities/tweet.dart';
import 'home_nav_bar.dart';

class LoadedHome extends StatelessWidget {
  const LoadedHome({super.key, required this.username, required this.tweets});

  final ValueNotifier<String> username;
  final ValueNotifier<List<TweetObject>> tweets;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF262C4C),
        drawer: SideNav(),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Row(
                        children: [
                          InkWell(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 80.sp,
                              child: Image.network(
                                UserPreferences.getUserImage()!,
                                height: 100.sp,
                                width: 100.sp,
                              ),
                            ),
                            onTap: () {
                              Scaffold.of(context).openDrawer();
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                ValueListenableBuilder(
                                  valueListenable: username,
                                  builder: (context, value, child) {
                                    return Text(
                                      value,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: Constants.fontFamily,
                                        fontWeight: Constants.regularFont,
                                        color: Colors.white,
                                      ),
                                    );
                                  },
                                ),
                                Text(
                                  '@${UserPreferences.getUserUID()!.substring(0, 8)}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: Constants.fontFamily,
                                    fontWeight: Constants.regularFont,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    tweets.value.isNotEmpty
                        ? Expanded(
                          child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: tweets.value.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    ClipOval(
                                                      child: CircleAvatar(
                                                        backgroundColor: Colors.grey,
                                                        radius: 25,
                                                        child: Image.network(
                                                          tweets.value[index].profilePicture,
                                                          color: Colors.white,
                                                          height: 30,
                                                          width: 30,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 10),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                tweets.value[index].userName,
                                                                style: TextStyle(
                                                                  color: Colors.black,
                                                                  fontFamily: Constants.fontFamily,
                                                                  fontWeight: Constants.boldFont,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                tweets.value[index].handle,
                                                                style: TextStyle(
                                                                  color: Colors.grey[600],
                                                                  fontFamily: Constants.fontFamily,
                                                                  fontWeight: Constants.mediumFont,
                                                                  fontSize: 10,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            tweets.value[index].content,
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                              fontFamily: Constants.fontFamily,
                                                              fontWeight: Constants.regularFont,
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  SvgPicture.asset(
                                                    Constants.reply,
                                                    height: 19,
                                                    width: 19,
                                                  ),
                                                  SvgPicture.asset(
                                                    Constants.retweet,
                                                    height: 19,
                                                    width: 19,
                                                  ),
                                                  SvgPicture.asset(
                                                    Constants.like,
                                                    height: 19,
                                                    width: 19,
                                                  ),
                                                  SvgPicture.asset(
                                                    Constants.share,
                                                    height: 19,
                                                    width: 19,
                                                  ),
                                                ],
                                              ),
                                              Divider(
                                                thickness: 1,
                                                indent: 50,
                                                endIndent: 50,
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ),
                        )
                        : Text(
                            'No data to show at the moment.\nTry again later.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Constants.whiteColor,
                        fontFamily: Constants.fontFamily,
                        fontWeight: Constants.lightFont,
                        fontSize: 45.sp
                      ),
                          ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: NavBar(),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
