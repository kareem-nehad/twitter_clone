import 'package:flutter/material.dart';
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
                          child: Icon(Icons.abc),
                          width: double.infinity,
                          height: 2000,
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
}
