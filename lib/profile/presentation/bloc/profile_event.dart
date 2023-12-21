part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileSetUserEvent extends ProfileEvent {
  const ProfileSetUserEvent({required this.username});
  final String username;

  @override
  List<Object> get props => [username];
}
