import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/app/presentation/controller/login_bloc/login_bloc.dart';
import 'package:twitter_clone/app/presentation/screens/home_screen/home_screen.dart';
import 'package:twitter_clone/core/utils/constants.dart';

import '../../../../core/services/service_locator.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String email = '';
    String password = '';
    ValueNotifier<bool> rememberMe = ValueNotifier(false);
    return BlocProvider(
      create: (BuildContext context) => sl<LoginBloc>(),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          switch (state.status) {
            case LoginStatus.success:
              // Go to home screen.
            Navigator.pop(context);
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              });

              break;
            case LoginStatus.failure:
              // Navigator.pop(context);
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                ScaffoldMessenger.maybeOf(context)?.showSnackBar(SnackBar(
                  backgroundColor: Colors.redAccent,
                  behavior: SnackBarBehavior.floating,
                  showCloseIcon: true,
                  closeIconColor: Constants.whiteColor,
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.8,
                    left: 20,
                    right: 20,
                  ),
                  content: Container(
                    child: Text(state.message),
                  ),
                ));
              });
              break;
            case LoginStatus.loading:
              WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: Constants.primaryColor,
                      ));
                    });
              });
              break;
            case LoginStatus.awaiting:
              // Do nothing.
              break;
          }

          return SafeArea(
            child: Scaffold(
              backgroundColor: Color(0xFF262C4C),
              body: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      Positioned(
                        child: SvgPicture.asset(
                          Constants.twitter,
                          colorFilter: ColorFilter.mode(
                            Color(0xFF1D2847),
                            BlendMode.srcIn,
                          ),
                        ),
                        right: constraints.maxWidth * 0.3,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Log in',
                              style: TextStyle(
                                  fontFamily: Constants.fontFamily,
                                  fontWeight: Constants.mediumFont,
                                  fontSize: 30,
                                  color: Constants.whiteColor),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                onChanged: (value) {
                                  email = value;
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Constants.whiteColor,
                                    hintText: 'Email address',
                                    prefixIcon: Icon(Icons.email),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3,
                                            color: Constants.whiteColor))),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                onChanged: (value) {
                                  password = value;
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Constants.whiteColor,
                                    hintText: 'Password',
                                    prefixIcon: Icon(Icons.lock),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3,
                                            color: Constants.whiteColor))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  ValueListenableBuilder(
                                      valueListenable: rememberMe,
                                      builder: (context, value, child) {
                                        return Checkbox(
                                            value: rememberMe.value,
                                            onChanged: (value) =>
                                                rememberMe.value = value!);
                                      }),
                                  Text(
                                    'Remember me',
                                    style: TextStyle(
                                        fontFamily: Constants.fontFamily,
                                        fontWeight: Constants.regularFont,
                                        color: Constants.whiteColor,
                                        fontSize: 14),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                if (email == '' || password == '') {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor: Colors.redAccent,
                                    behavior: SnackBarBehavior.floating,
                                    showCloseIcon: true,
                                    margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                      left: 20,
                                      right: 20,
                                    ),
                                    content: Container(
                                      child: Text(
                                        'Credentials can\'t be empty.',
                                      ),
                                    ),
                                  ));
                                } else {
                                  context.read<LoginBloc>().add(
                                      Login(email: email, password: password));
                                }
                              },
                              child: Text('Log in'),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(150, 50),
                                backgroundColor: Constants.primaryColor,
                                textStyle:
                                    TextStyle(fontFamily: Constants.fontFamily),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: GestureDetector(
                                onTap: () {
                                  // Go to forgot password screen
                                },
                                child: Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                      fontFamily: Constants.fontFamily,
                                      fontWeight: Constants.regularFont,
                                      color: Constants.whiteColor,
                                      fontSize: 16),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
