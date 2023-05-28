import 'package:flutter/material.dart';
import 'package:twitter_clone/app/data/source/feed_data_source.dart';
import 'package:twitter_clone/app/presentation/screens/home_screen/components/side_nav.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/user_preferences.dart';
import '../../../../domain/entities/tweet.dart';
import 'home_nav_bar.dart';

class LoadedHome extends StatelessWidget {
  const LoadedHome({super.key, required this.username, required this.tweets});

  final ValueNotifier<String> username;
  final ValueNotifier<List<Tweet>> tweets;

  @override
  Widget build(BuildContext context) {
    FeedDataSource dataSource = FeedDataSource();
    dataSource.getFeed();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF262C4C),
        drawer: SideNav(),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Row(
                          children: [
                            InkWell(
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 30,
                                child: Image.asset(
                                  'assets/images/user_image.png',
                                  height: 30,
                                  width: 30,
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
                                            color: Colors.white),
                                      );
                                    },
                                  ),
                                  Text(
                                    '@${UserPreferences.getUserUID()!.substring(0, 8)}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: Constants.fontFamily,
                                        fontWeight: Constants.regularFont,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          color: Colors.white,
                          child: ListView.builder(
                            shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: tweets.value.length,
                              itemBuilder: (context, index) {
                                return Text(
                                  '${tweets.value[index].content}',
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
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
