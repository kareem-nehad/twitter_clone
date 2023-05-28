import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twitter_clone/app/presentation/screens/introduction_screen/introduction_screen.dart';
import 'package:twitter_clone/core/utils/constants.dart';
import 'package:twitter_clone/core/utils/user_preferences.dart';

class SideNav extends StatefulWidget {
  const SideNav({Key? key}) : super(key: key);

  @override
  State<SideNav> createState() => _SideNavState();
}

class _SideNavState extends State<SideNav> {
  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      children: [
        InkWell(
          child: ListTile(
            leading: Icon(Icons.logout, color: Colors.red,),
            title: Text(
              'Log Out',
              style: TextStyle(
                fontFamily: Constants.fontFamily,
                fontWeight: Constants.regularFont,
                color: Colors.red,
              ),
            ),
          ),
          onTap: () async {
            UserPreferences.clearUserEmail();
            UserPreferences.clearUserPassword();
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(context, PageTransition(child: IntroductionScreen(), type: PageTransitionType.leftToRight, curve: Curves.easeIn));

          },
        )
      ],
    );
  }
}
