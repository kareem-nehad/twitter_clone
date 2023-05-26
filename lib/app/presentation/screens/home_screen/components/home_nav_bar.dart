import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
            onPressed: () {},
            elevation: 20,
            child: SvgPicture.asset(
              Constants.search,
              height: 32,
              width: 32,
            ),
          ),
          FloatingActionButton.large(
            onPressed: () {},
            elevation: 20,
            child: SvgPicture.asset(
              Constants.home,
              height: 44,
              width: 44,
            ),
          ),
          FloatingActionButton(
            onPressed: () {},
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