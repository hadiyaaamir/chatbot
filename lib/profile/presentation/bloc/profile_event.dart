part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];

}

class ProfileCustomEvent extends ProfileEvent {
  const ProfileCustomEvent({required this.property});
  final String property;

  @override
  List<Object> get props => [property];
}