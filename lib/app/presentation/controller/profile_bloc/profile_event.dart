part of 'profile_bloc.dart';


abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetFullUserDataEvent extends ProfileEvent {
  final String uid;

  GetFullUserDataEvent(this.uid);
}
