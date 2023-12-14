part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];

}

class HomeCustomEvent extends HomeEvent {
  const HomeCustomEvent({required this.property});
  final String property;

  @override
  List<Object> get props => [property];
}