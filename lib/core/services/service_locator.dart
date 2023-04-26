import 'package:get_it/get_it.dart';
import 'package:twitter_clone/app/data/repository/auth_repository.dart';
import 'package:twitter_clone/app/data/source/auth_remote_data_source.dart';
import 'package:twitter_clone/app/domain/repository/base_authentication_repository.dart';
import 'package:twitter_clone/app/domain/usecases/create_account_usecase.dart';
import 'package:twitter_clone/app/presentation/controller/create_account_bloc/create_account_bloc.dart';

final sl = GetIt.instance;

class ServiceLocator {
  void init() {
    sl.registerLazySingleton<BaseAuthenticationDataSource>(() => AuthenticationDataSource());
    sl.registerLazySingleton<BaseAuthenticationRepository>(() => AuthenticationRepository(baseAuthenticationDataSource: sl()));

    sl.registerLazySingleton(() => CreateAccountUsecase(sl()));

    sl.registerFactory(() => CreateAccountBloc(sl()));
  }
}