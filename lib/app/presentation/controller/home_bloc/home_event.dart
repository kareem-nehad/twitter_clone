

import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetUserDataEvent extends HomeEvent{}
class GetFeedEvent extends HomeEvent {}

