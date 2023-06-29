import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_clone/app/presentation/controller/home_bloc/home_bloc.dart';
import 'package:twitter_clone/app/presentation/controller/home_bloc/home_state.dart';
import 'package:twitter_clone/app/presentation/screens/home_screen/components/loading_home.dart';
import '../../../../core/services/service_locator.dart';
import '../../../domain/entities/tweet.dart';
import '../../controller/home_bloc/home_event.dart';
import 'components/loaded_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ValueNotifier<String> username = ValueNotifier('');
    ValueNotifier<List<TweetObject>> tweets = ValueNotifier([]);
    return BlocProvider(
      create: (BuildContext context) => sl<HomeBloc>()..add(GetUserDataEvent())..add(GetFeedEvent()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          switch (state.status) {
            case HomeStatus.success:
              print('SUCCESS');
              username.value = state.userName;
              tweets.value = state.tweets;
              return LoadedHome(username: username, tweets: tweets,);

            case HomeStatus.failure:
              print('FAILURE');
              break;
            case HomeStatus.loading:
              print('LOADING');
              return LoadingHome();

            default:
              break;
          }
          return Container();
        },
      ),
    );
  }
}


