import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twitter_clone/app/domain/entities/tweet.dart';
import 'package:twitter_clone/app/presentation/controller/tweet_bloc/tweet_bloc.dart';
import 'package:twitter_clone/app/presentation/screens/home_screen/home_screen.dart';
import 'package:twitter_clone/core/utils/constants.dart';
import 'package:twitter_clone/core/utils/user_preferences.dart';

import '../../../../../core/services/service_locator.dart';

class TweetScreen extends StatelessWidget {
  const TweetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> charCount = ValueNotifier(0);
    ValueNotifier<String> tweetContent = ValueNotifier('');
    return BlocProvider(
      create: (BuildContext context) => sl<TweetBloc>(),
      child: BlocBuilder<TweetBloc, TweetState>(builder: (context, state) {
        switch (state.status) {
          case TweetStatus.success:
            print('Success');
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(context, PageTransition(child: HomeScreen(), type: PageTransitionType.topToBottom, curve: Curves.easeIn));
            });
            break;
          case TweetStatus.failure:
            // TODO: Handle this case.
            break;
          case TweetStatus.loading:
            // TODO: Handle this case.
            break;
          case TweetStatus.awaiting:
            // TODO: Handle this case.
            break;
        }
        return SafeArea(
          child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Row(
                    children: [
                      InkWell(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: Constants.fontFamily,
                            fontWeight: Constants.regularFont,
                            fontSize: 16,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () async {
                          context.read<TweetBloc>().add(
                                Tweet(
                                  tweet: TweetObject(
                                    UserPreferences.getUserName()!,
                                    UserPreferences.getUserUID()!,
                                    UserPreferences.getUserUID()!,
                                    tweetContent.value,
                                    UserPreferences.getUserImage()!,
                                    getDate()
                                  ),
                                ),
                              );
                        },
                        child: Text(
                          'Tweet',
                          style: TextStyle(
                            fontFamily: Constants.fontFamily,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: ValueListenableBuilder(
                      valueListenable: charCount,
                      builder: (BuildContext context, value, Widget? child) {
                        return SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            value: charCount.value / 360,
                            backgroundColor: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Scrollbar(
                      controller: ScrollController(),
                      child: TextFormField(
                        controller: TextEditingController(),
                        keyboardType: TextInputType.multiline,
                        scrollPhysics: BouncingScrollPhysics(),
                        autofocus: true,
                        onChanged: (value) {
                          charCount.value = value.length;
                          tweetContent.value = value;
                        },
                        maxLines: 30,
                        decoration: InputDecoration(
                          hintText: 'What\'s happening?',
                          hintStyle: TextStyle(fontFamily: Constants.fontFamily),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  String getDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  }

}
