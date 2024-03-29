import 'package:get_it/get_it.dart';
import 'package:twitter_clone/app/data/repository/auth_repository.dart';
import 'package:twitter_clone/app/data/repository/feed_repository.dart';
import 'package:twitter_clone/app/data/repository/full_user_repository.dart';
import 'package:twitter_clone/app/data/repository/like_repository.dart';
import 'package:twitter_clone/app/data/repository/login_repository.dart';
import 'package:twitter_clone/app/data/repository/tweet_repository.dart';
import 'package:twitter_clone/app/data/repository/user_repository.dart';
import 'package:twitter_clone/app/data/source/auth_remote_data_source.dart';
import 'package:twitter_clone/app/data/source/feed_data_source.dart';
import 'package:twitter_clone/app/data/source/full_user_data_source.dart';
import 'package:twitter_clone/app/data/source/like_data_source.dart';
import 'package:twitter_clone/app/data/source/login_remote_data_source.dart';
import 'package:twitter_clone/app/data/source/tweet_data_source.dart';
import 'package:twitter_clone/app/data/source/user_data_source.dart';
import 'package:twitter_clone/app/domain/repository/base_authentication_repository.dart';
import 'package:twitter_clone/app/domain/repository/base_feed_repository.dart';
import 'package:twitter_clone/app/domain/repository/base_full_user_repository.dart';
import 'package:twitter_clone/app/domain/repository/base_like_repository.dart';
import 'package:twitter_clone/app/domain/repository/base_login_repository.dart';
import 'package:twitter_clone/app/domain/repository/base_tweet_repository.dart';
import 'package:twitter_clone/app/domain/repository/base_user_repository.dart';
import 'package:twitter_clone/app/domain/usecases/create_account_usecase.dart';
import 'package:twitter_clone/app/domain/usecases/feed_usecase.dart';
import 'package:twitter_clone/app/domain/usecases/full_user_data_usecase.dart';
import 'package:twitter_clone/app/domain/usecases/get_user_data_usecase.dart';
import 'package:twitter_clone/app/domain/usecases/like_usecase.dart';
import 'package:twitter_clone/app/domain/usecases/login_usecase.dart';
import 'package:twitter_clone/app/domain/usecases/tweet_usecase.dart';
import 'package:twitter_clone/app/presentation/controller/create_account_bloc/create_account_bloc.dart';
import 'package:twitter_clone/app/presentation/controller/home_bloc/home_bloc.dart';
import 'package:twitter_clone/app/presentation/controller/like_bloc/like_bloc.dart';
import 'package:twitter_clone/app/presentation/controller/login_bloc/login_bloc.dart';
import 'package:twitter_clone/app/presentation/controller/profile_bloc/profile_bloc.dart';
import 'package:twitter_clone/app/presentation/controller/tweet_bloc/tweet_bloc.dart';

final sl = GetIt.instance;

class ServiceLocator {
  void init() {
    // Authentication
    sl.registerLazySingleton<BaseAuthenticationDataSource>(() => AuthenticationDataSource());
    sl.registerLazySingleton<BaseAuthenticationRepository>(() => AuthenticationRepository(baseAuthenticationDataSource: sl()));

    sl.registerLazySingleton(() => CreateAccountUsecase(sl()));

    sl.registerFactory(() => CreateAccountBloc(sl()));

    // Login
    sl.registerLazySingleton<BaseLoginDataSource>(() => LoginDataSource());
    sl.registerLazySingleton<BaseLoginRepository>(() => LoginRepository(baseLoginDataSource: sl()));

    sl.registerLazySingleton(() => LoginUsecase(sl()));

    sl.registerFactory(() => LoginBloc(sl()));

    // Home
    sl.registerLazySingleton<BaseUserRemoteDataSource>(() => UserRemoteDataSource());
    sl.registerLazySingleton<BaseUserRepository>(() => UserRepository(baseUserRemoteDataSource: sl()));


    sl.registerLazySingleton(() => GetUserData(sl()));

    sl.registerLazySingleton<BaseFeedDataSource>(() => FeedDataSource());
    sl.registerLazySingleton<BaseFeedRepository>(() => FeedRepository(baseFeedDataSource: sl()));

    sl.registerLazySingleton(() => GetFeed(baseFeedRepository: sl()));

    sl.registerFactory(() => HomeBloc(sl(), sl()));

    // Tweet Action
    sl.registerLazySingleton<BaseTweetDataSource>(() => TweetDataSource());
    sl.registerLazySingleton<BaseTweetRepository>(() => TweetRepository(baseTweetDataSource: sl()));

    sl.registerLazySingleton(() => TweetUsecase(sl()));

    sl.registerFactory(() => TweetBloc(sl()));

    // User Profile
    sl.registerLazySingleton<BaseFullUserDataSource>(() => FullUserDataSource());
    sl.registerLazySingleton<BaseFullUserRepository>(() => FullUserRepository(baseFullUserDataSource: sl()));

    sl.registerLazySingleton(() => GetFullUserData(sl()));

    sl.registerFactory(() => ProfileBloc(sl()));

    // Like Action
    sl.registerLazySingleton<BaseLikeDataSource>(() => LikeDataSource());
    sl.registerLazySingleton<BaseLikeRepository>(() => LikeRepository(baseLikeDataSource: sl()));

    sl.registerLazySingleton(() => LikeUsecase(sl()));

    sl.registerFactory(() => LikeBloc(sl()));

  }
}