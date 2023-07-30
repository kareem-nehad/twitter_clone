import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twitter_clone/app/presentation/screens/create_account_screen/create_account.dart';
import 'package:twitter_clone/app/presentation/screens/home_screen/home_screen.dart';
import 'package:twitter_clone/app/presentation/screens/introduction_screen/introduction_screen.dart';
import 'package:twitter_clone/core/services/service_locator.dart';
import 'package:twitter_clone/core/utils/user_preferences.dart';

Widget startingScreen = IntroductionScreen();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ServiceLocator().init();
  await UserPreferences.init();
  if (UserPreferences.getUserEmail() != null && UserPreferences.getUserPassword() != null) {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: UserPreferences.getUserEmail()!, password: UserPreferences.getUserPassword()!);
    startingScreen = HomeScreen();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, child) {
        return MaterialApp(
          title: 'Twitter Clone',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: TextTheme(bodyMedium: TextStyle(fontSize: 30.sp)),
          ),
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      designSize: Size(1080, 2280),
      child: startingScreen,
    );
  }
}
