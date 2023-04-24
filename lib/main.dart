import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twitter_clone/app/presentation/screens/create_account_screen/create_account.dart';
import 'package:twitter_clone/app/presentation/screens/introduction_screen/introduction_screen.dart';

void main() {
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
            textTheme: TextTheme(bodyMedium: TextStyle(fontSize: 30.sp))
          ),
          debugShowCheckedModeBanner: false,
          home: child,
          routes: {
            '/createAccount': (context) => const CreateAccountScreen()
          },
        );
      },
      designSize: Size(1080, 2280),
      child: const IntroductionScreen(),
    );
  }
}
