import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_clone/app/presentation/controller/home_bloc/home_bloc.dart';
import 'package:twitter_clone/app/presentation/controller/home_bloc/home_state.dart';
import 'package:twitter_clone/core/utils/constants.dart';
import '../../../../core/services/service_locator.dart';
import '../../controller/home_bloc/home_event.dart';
import 'components/home_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ValueNotifier<String> username = ValueNotifier('');
    return BlocProvider(
      create: (BuildContext context) => sl<HomeBloc>()..add(GetUserDataEvent()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          switch (state.status) {
            case HomeStatus.success:
              print('SUCCESS');
              username.value = state.userName;
              print(username.value);
              break;
            case HomeStatus.failure:
              print('FAILURE');
              break;
            case HomeStatus.loading:
              print('LOADING');
              break;

            default:
              break;
          }

          return SafeArea(
            child: Scaffold(
              backgroundColor: Color(0xFF262C4C),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            child: Image.asset(
                              'assets/images/user_image.png',
                              height: 30,
                              width: 30,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                ValueListenableBuilder(
                                  valueListenable: username,
                                  builder: (context, value, child) {
                                    return Text(
                                      value,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: Constants.fontFamily,
                                          fontWeight: Constants.lightFont,
                                          color: Colors.white),
                                    );
                                  },
                                ),
                                Text(
                                  '@kareem',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: Constants.fontFamily,
                                      fontWeight: Constants.lightFont,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      child: Icon(Icons.abc),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: NavBar(),
            ),
          );
        },
      ),
    );
  }
}
