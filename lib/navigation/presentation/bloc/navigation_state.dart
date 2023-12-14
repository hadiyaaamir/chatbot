part of 'navigation_bloc.dart';


class NavigationState extends Equatable {

  const NavigationState({
    this.customProperty = 'Default Value',
  });

  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  NavigationState copyWith({
    String? customProperty,
  }) {
    return NavigationState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}


class NavigationInitial extends NavigationState {
  const NavigationInitial() : super();
}
