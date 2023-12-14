part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigationIndexChanged extends NavigationEvent {
  const NavigationIndexChanged({required this.selectedIndex});
  final int selectedIndex;

  @override
  List<Object> get props => [selectedIndex];
}
