part of 'home_bloc.dart';


class HomeState extends Equatable {

  const HomeState({
    this.customProperty = 'Default Value',
  });

  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  HomeState copyWith({
    String? customProperty,
  }) {
    return HomeState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}


class HomeInitial extends HomeState {
  const HomeInitial() : super();
}
