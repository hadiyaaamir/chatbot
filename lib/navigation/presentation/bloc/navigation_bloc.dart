import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationInitial()) {
    on<NavigationCustomEvent>(_onNavigationEvent);
  }

  FutureOr<void> _onNavigationEvent(
    NavigationCustomEvent event,
    Emitter<NavigationState> emit,
  ) {
    // TODO: Add Logic
  }
}
