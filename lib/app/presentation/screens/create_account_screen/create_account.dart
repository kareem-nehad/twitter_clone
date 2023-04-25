import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/app/domain/usecases/create_account_usecase.dart';
import 'package:twitter_clone/core/utils/constants.dart';

import '../../../data/models/auth_request_status_model.dart';
import '../../../data/repository/auth_repository.dart';
import '../../../data/source/auth_remote_data_source.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String username = '';
    String email = '';
    String password = '';

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF262C4C),
        body: LayoutBuilder(
          builder: (context, constraints) => Stack(
            children: [
              Positioned(
                child: SvgPicture.asset(
                  Constants.twitter,
                  colorFilter:
                      ColorFilter.mode(Color(0xFF1D2847), BlendMode.srcIn),
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
                                    width: 3, color: Constants.whiteColor))),
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
                                    width: 3, color: Constants.whiteColor))),
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
                                    width: 3, color: Constants.whiteColor))),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (username == '' || email == '' || password == '') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.redAccent,
                            behavior: SnackBarBehavior.floating,
                            showCloseIcon: true,
                            margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height * 0.8,
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
                          final BaseAuthenticationDataSource
                              baseAuthenticationDataSource =
                              AuthenticationDataSource();
                          final AuthenticationRepository
                              authenticationRepository =
                              AuthenticationRepository(
                                  baseAuthenticationDataSource:
                                      baseAuthenticationDataSource);
                          final CreateAccountUsecase createAccountUsecase =
                              CreateAccountUsecase(authenticationRepository);
                          final Future<AuthRequestStatus> request;
                          request =
                              createAccountUsecase.execute(email, password);
                          request.then((value) {
                            if (value.code == 0) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                backgroundColor: Constants.successColor,
                                behavior: SnackBarBehavior.floating,
                                showCloseIcon: true,
                                closeIconColor: Constants.whiteColor,
                                margin: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.height * 0.8,
                                  left: 20,
                                  right: 20,
                                ),
                                content: Container(
                                  child: Text(
                                    value.status,
                                  ),
                                ),
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                backgroundColor: Constants.errorColor,
                                behavior: SnackBarBehavior.floating,
                                showCloseIcon: true,
                                closeIconColor: Constants.whiteColor,
                                margin: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.height * 0.8,
                                  left: 20,
                                  right: 20,
                                ),
                                content: Container(
                                  child: Text(
                                    value.status,
                                  ),
                                ),
                              ));
                            }
                          });
                        }
                      },
                      child: Text('Register'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(150, 50),
                        backgroundColor: Constants.primaryColor,
                        textStyle: TextStyle(fontFamily: Constants.fontFamily),
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
  }
}
