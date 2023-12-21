part of 'profile_bloc.dart';

enum ProfileStatus { initial, loading, success, failure }

class ProfileState extends Equatable {
  const ProfileState({this.currentUser, required this.status});

  final User? currentUser;
  final ProfileStatus status;

  @override
  List<Object?> get props => [currentUser, status];

  ProfileState copyWith({User? currentUser, ProfileStatus? status}) {
    return ProfileState(
      currentUser: currentUser ?? this.currentUser,
      status: status ?? this.status,
    );
  }
}

class ProfileInitial extends ProfileState {
  const ProfileInitial({super.status = ProfileStatus.initial}) : super();
}
