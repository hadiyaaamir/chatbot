part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];

}

class NavigationCustomEvent extends NavigationEvent {
  const NavigationCustomEvent({required this.property});
  final String property;

  @override
  List<Object> get props => [property];
}