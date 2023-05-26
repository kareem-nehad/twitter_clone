import 'package:equatable/equatable.dart';

import '../../../domain/entities/user.dart';

enum HomeStatus { success, failure, loading }

class HomeState extends Equatable {
  final String userName;
  final HomeStatus status;

  HomeState({
    this.userName = '',
    this.status = HomeStatus.loading,
  });

  HomeState copyWith({
    String? userName,
    HomeStatus? status
}) {
    return HomeState(
      userName: userName ?? this.userName,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [userName, status];
}
