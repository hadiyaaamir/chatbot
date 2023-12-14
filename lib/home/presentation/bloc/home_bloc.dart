import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial()) {
    on<HomeCustomEvent>(_onHomeEvent);
  }

  Future<void> _onHomeEvent(
    HomeCustomEvent event,
    Emitter<HomeState> emit,
  ) async {
    // TODO: Add Logic
  }
}
