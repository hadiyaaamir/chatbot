import 'package:chatbot/navigation/navigation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationInitial()) {
    on<NavigationIndexChanged>(_onNavigationIndexChanged);
  }

  void _onNavigationIndexChanged(
    NavigationIndexChanged event,
    Emitter<NavigationState> emit,
  ) {
    emit(state.copyWith(currentIndex: event.selectedIndex));
  }
}
