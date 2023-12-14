import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileInitial()) {
    on<ProfileCustomEvent>(_onProfileEvent);
  }

  FutureOr<void> _onProfileEvent(
    ProfileCustomEvent event,
    Emitter<ProfileState> emit,
  ) {
    // TODO: Add Logic
  }
}
