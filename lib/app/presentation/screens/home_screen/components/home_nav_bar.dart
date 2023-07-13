import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twitter_clone/app/presentation/screens/home_screen/components/tweet_screen.dart';
import '../../../../../core/utils/constants.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            heroTag: null,
            onPressed: () {},
            elevation: 20,
            child: SvgPicture.asset(
              Constants.search,
              height: 32,
              width: 32,
            ),
          ),
          FloatingActionButton.large(
            heroTag: null,
            onPressed: () {},
            elevation: 20,
            child: SvgPicture.asset(
              Constants.home,
              height: 44,
              width: 44,
            ),
          ),
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              Navigator.push(context, PageTransition(child: TweetScreen(), type: PageTransitionType.size,childCurrent: this, curve: Curves.easeInOutExpo,alignment: Alignment.bottomCenter));
            },
            elevation: 20,
            child: SvgPicture.asset(
              Constants.tweet,
              height: 32,
              width: 32,
            ),
          )
        ],
      ),
    );
  }
}
