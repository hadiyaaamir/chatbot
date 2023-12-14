part of 'profile_bloc.dart';


class ProfileState extends Equatable {

  const ProfileState({
    this.customProperty = 'Default Value',
  });

  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  ProfileState copyWith({
    String? customProperty,
  }) {
    return ProfileState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}


class ProfileInitial extends ProfileState {
  const ProfileInitial() : super();
}
