part of 'profile_bloc.dart';

enum ProfileStatus { success, failure, loading }

class ProfileState extends Equatable {
  final String username;
  final String uid;
  final String userImage;
  final List<TweetObject> tweets;
  final ProfileStatus status;

  ProfileState({
    this.username = '',
    this.uid = '',
    this.userImage = '',
    required this.tweets,
    this.status = ProfileStatus.loading,
  });

  ProfileState copyWith({String? username, String? uid, String? userImage, List<TweetObject>? tweets, ProfileStatus? status}) {
    return ProfileState(
      username: username ?? this.username,
      uid: uid ?? this.uid,
      userImage: userImage ?? this.userImage,
      tweets: tweets ?? this.tweets,
      status: status ?? this.status

    );
  }

  @override
  List<Object> get props => [username, uid, userImage, tweets];
}
