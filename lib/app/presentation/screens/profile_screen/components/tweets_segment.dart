import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../../core/services/service_locator.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../domain/entities/tweet.dart';
import '../../../controller/like_bloc/like_bloc.dart';
import '../../tweet_details_screen/tweet_details_screen.dart';

class TweetsSegment extends StatelessWidget {
  const TweetsSegment({super.key, required this.tweets});

  final ValueNotifier<List<TweetObject>> tweets;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: tweets.value.length,
      separatorBuilder: (context, index) => Divider(
        color: Constants.greyColor,
        thickness: 0.25,
        indent: 100.sp,
        endIndent: 100.sp,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Constants.greyColor,
                    radius: 80.sp,
                    child: ClipOval(
                      child: Image.network(tweets.value[index].profilePicture),
                    ),
                  ),
                  SizedBox(width: 20.sp),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                      Container(
                        width: 850.sp,
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
                ],
              ),
              SizedBox(height: 20.sp),
              Row(
                mainAxisSize: MainAxisSize.max,
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
                      colorFilter: ColorFilter.mode(Constants.whiteColor, BlendMode.srcIn),
                    ),
                  ),
                  SvgPicture.asset(
                    Constants.retweet,
                    height: 19,
                    width: 19,
                    colorFilter: ColorFilter.mode(Constants.whiteColor, BlendMode.srcIn),
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
                                colorFilter: ColorFilter.mode(Constants.whiteColor, BlendMode.srcIn),
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
                                : ColorFilter.mode(Constants.whiteColor, BlendMode.srcIn),
                          ),
                        );
                      },
                    ),
                  ),
                  SvgPicture.asset(
                    Constants.share,
                    height: 19,
                    width: 19,
                    colorFilter: ColorFilter.mode(Constants.whiteColor, BlendMode.srcIn),
                  ),
                ],
              )
            ],
          ),
        );
      },
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