import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/utils/constants.dart';
import 'home_nav_bar.dart';

class LoadingHome extends StatelessWidget {
  const LoadingHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF262C4C),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 30,
                              child: Shimmer.fromColors(
                                enabled: true,
                                baseColor: Colors.grey,
                                highlightColor: Colors.white,
                                child: Image.asset(
                                  'assets/images/user_image.png',
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Shimmer.fromColors(
                                enabled: true,
                                baseColor: Colors.grey,
                                highlightColor: Colors.white,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 100,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 20,
                                      width: 100,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          child: Column(
                            children: [
                              LoadingTweet(),
                              LoadingTweet(),
                              LoadingTweet(),
                              LoadingTweet(),
                              LoadingTweet(),
                            ],
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
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

  Widget LoadingTweet() {
    return Padding(
      padding: const EdgeInsets.only(top: 20,left: 10),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[350],
                radius: 30,
                child: Shimmer.fromColors(
                  enabled: true,
                  baseColor: Colors.grey,
                  highlightColor: Colors.white,
                  child: Image.asset(
                    'assets/images/user_image.png',
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    enabled: true,
                    baseColor: Colors.grey,
                    highlightColor: Colors.white,
                    child: Container(
                      width: 100,
                      height: 20,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Shimmer.fromColors(
                    enabled: true,
                    baseColor: Colors.grey,
                    highlightColor: Colors.white,
                    child: Container(
                      width: 300,
                      height: 20,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Shimmer.fromColors(
                    enabled: true,
                    baseColor: Colors.grey,
                    highlightColor: Colors.white,
                    child: Container(
                      width: 300,
                      height: 20,
                      color: Colors.grey,
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 10,),
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
  }
}
