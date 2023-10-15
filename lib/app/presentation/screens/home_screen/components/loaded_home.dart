import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twitter_clone/app/data/source/feed_data_source.dart';
import 'package:twitter_clone/app/data/source/like_data_source.dart';
import 'package:twitter_clone/app/presentation/controller/like_bloc/like_bloc.dart';
import 'package:twitter_clone/app/presentation/screens/home_screen/components/side_nav.dart';
import 'package:twitter_clone/app/presentation/screens/tweet_details_screen/tweet_details_screen.dart';
import 'package:twitter_clone/core/services/like_mixin.dart';

import '../../../../../core/services/service_locator.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/user_preferences.dart';
import '../../../../domain/entities/tweet.dart';
import 'home_nav_bar.dart';

class LoadedHome extends StatelessWidget with LikeTweet {
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
                              child: ClipOval(
                                child: Image.network(
                                  UserPreferences.getUserImage()!,
                                  height: 160.sp,
                                  width: 160.sp,
                                ),
                              ),
                            ),
                            onTap: () {
                              Scaffold.of(context).openDrawer();
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: Constants.fontFamily,
                                    fontWeight: Constants.regularFont,
                                    color: Constants.greyColor,
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
                                  child: Column(
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        itemCount: tweets.value.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      child: TweetDetailsScreen(
                                                        TweetObject(
                                                          tweets.value[index].userName,
                                                          tweets.value[index].uID,
                                                          tweets.value[index].handle,
                                                          tweets.value[index].content,
                                                          tweets.value[index].profilePicture,
                                                          tweets.value[index].date,
                                                        ),
                                                      ),
                                                      type: PageTransitionType.rightToLeftWithFade,
                                                      childCurrent: this,
                                                      curve: Curves.easeInExpo,
                                                    ),
                                                  );
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                                            SizedBox(height: 3),
                                                            Container(
                                                              width: 850.sp,
                                                              child: Text(
                                                                tweets.value[index].content,
                                                                style: TextStyle(
                                                                  color: Colors.black,
                                                                  fontFamily: Constants.fontFamily,
                                                                  fontWeight: Constants.regularFont,
                                                                  fontSize: 15,
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
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          PageTransition(
                                                              child: TweetDetailsScreen(
                                                                TweetObject(
                                                                  tweets.value[index].userName,
                                                                  tweets.value[index].uID,
                                                                  tweets.value[index].handle,
                                                                  tweets.value[index].content,
                                                                  tweets.value[index].profilePicture,
                                                                  tweets.value[index].date,
                                                                ),
                                                              ),
                                                              type: PageTransitionType.rightToLeftWithFade,
                                                              childCurrent: this,
                                                              curve: Curves.easeInExpo));
                                                    },
                                                    child: SvgPicture.asset(
                                                      Constants.reply,
                                                      height: 19,
                                                      width: 19,
                                                    ),
                                                  ),
                                                  SvgPicture.asset(
                                                    Constants.retweet,
                                                    height: 19,
                                                    width: 19,
                                                  ),
                                                  BlocProvider(
                                                    lazy: false,
                                                    create: (context) => sl<LikeBloc>()..add(getLikedEvent()),
                                                    child: BlocBuilder<LikeBloc, LikeState>(
                                                      builder: (context, state) {
                                                        switch (state.status) {
                                                          case LikeStatus.success:
                                                            return GestureDetector(
                                                              onTap: () {
                                                                try {
                                                                  context.read<LikeBloc>().add(isLiked(tweet: tweets.value[index]));
                                                                } on Exception catch (e) {
                                                                  print(e);
                                                                }
                                                              },
                                                              child: SvgPicture.asset(
                                                                Constants.like,
                                                                height: 19,
                                                                width: 19,
                                                                colorFilter: ColorFilter.mode(Constants.errorColor, BlendMode.srcIn),
                                                              ),
                                                            );
                                                          case LikeStatus.failure:
                                                            return GestureDetector(
                                                              onTap: () {
                                                                try {
                                                                  context.read<LikeBloc>().add(isLiked(tweet: tweets.value[index]));
                                                                } on Exception catch (e) {
                                                                  print(e);
                                                                }
                                                              },
                                                              child: SvgPicture.asset(
                                                                Constants.like,
                                                                height: 19,
                                                                width: 19,
                                                                colorFilter: ColorFilter.mode(Constants.primaryColor, BlendMode.srcIn),
                                                              ),
                                                            );
                                                        }
                                                        return GestureDetector(
                                                          onTap: () {
                                                            try {
                                                              context.read<LikeBloc>().add(isLiked(tweet: tweets.value[index]));
                                                            } on Exception catch (e) {
                                                              print(e);
                                                            }
                                                          },
                                                          child: SvgPicture.asset(
                                                            Constants.like,
                                                            height: 19,
                                                            width: 19,
                                                            colorFilter: foundInLiked(tweets.value[index], state.likedTweets)
                                                                ? ColorFilter.mode(Constants.errorColor, BlendMode.srcIn)
                                                                : ColorFilter.mode(Constants.primaryColor, BlendMode.srcIn),
                                                          ),
                                                        );
                                                      },
                                                    ),
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
                                          );
                                        },
                                      ),
                                      SizedBox(height: 20.sp),
                                      Image.asset(
                                        Constants.appIcon,
                                        height: 50.sp,
                                        width: 50.sp,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                          child: Center(
                            child: Text(
                                'No data to show at the moment.\nTry again later.',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Constants.whiteColor, fontFamily: Constants.fontFamily, fontWeight: Constants.lightFont, fontSize: 45.sp),
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

  bool foundInLiked(TweetObject tweet, List<TweetObject> list) {
    for (var object in list) {
      if (tweet.content == object.content) {
        return true;
      } else {
        continue;
      }
    }
    return false;
  }
}
