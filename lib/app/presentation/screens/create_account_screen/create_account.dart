import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twitter_clone/app/presentation/controller/create_account_bloc/create_account_bloc.dart';
import 'package:twitter_clone/app/presentation/screens/introduction_screen/introduction_screen.dart';
import 'package:twitter_clone/core/utils/constants.dart';

import '../../../../core/services/service_locator.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String username = '';
    String email = '';
    String password = '';

    return BlocProvider(
      create: (BuildContext context) => sl<CreateAccountBloc>(),
      child: BlocBuilder<CreateAccountBloc, CreateAccountState>(
        builder: (context, state) {
          print(state.status);
          switch (state.status) {
            case AuthStatus.unauthenticated:
              break;
            case AuthStatus.loading:
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
               showDialog(context: context, builder: (context) {
                 return Center(child: CircularProgressIndicator(color: Constants.primaryColor,));
               });
              });
              break;
            case AuthStatus.success:
              Navigator.pop(context);
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Constants.successColor,
                  behavior: SnackBarBehavior.floating,
                  showCloseIcon: true,
                  closeIconColor: Constants.whiteColor,
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.8,
                    left: 20,
                    right: 20,
                  ),
                  content: Container(
                    child: Text(
                      'Account Created Successfully',
                    ),
                  ),
                ));
              });
              Navigator.maybePop(context, PageTransition(child: IntroductionScreen() , type: PageTransitionType.leftToRightPop, childCurrent: this));
              break;
            case AuthStatus.failure:
              Navigator.pop(context);
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
          }

          return SafeArea(
            child: Scaffold(
              backgroundColor: Color(0xFF262C4C),
              body: LayoutBuilder(
                builder: (context, constraints) => Stack(
                  children: [
                    Positioned(
                      child: SvgPicture.asset(
                        Constants.twitter,
                        colorFilter: ColorFilter.mode(
                            Color(0xFF1D2847), BlendMode.srcIn),
                      ),
                      right: constraints.maxWidth * 0.3,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Create your account',
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
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              onChanged: (value) {
                                username = value;
                              },
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Constants.whiteColor,
                                  hintText: 'Username',
                                  prefixIcon: Icon(Icons.person),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3,
                                          color: Constants.whiteColor))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                          SizedBox(
                            height: 50,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              FocusScope.of(context).requestFocus(new FocusNode());
                              if (username == '' ||
                                  email == '' ||
                                  password == '') {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor: Colors.redAccent,
                                  behavior: SnackBarBehavior.floating,
                                  showCloseIcon: true,
                                  margin: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height *
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
                                print('email -> $email');
                                context.read<CreateAccountBloc>()
                                  .add(CreateAccount(email: email, password: password));
                              }
                            },
                            child: Text('Register'),
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
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
