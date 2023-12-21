import 'dart:async';

import 'package:chatbot/profile/profile.dart';
import 'package:equatable/equatable.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const ProfileInitial()) {
    on<ProfileSetUserEvent>(_onSetUser);
  }

  final UserRepository _userRepository;

  Future<void> _onSetUser(
    ProfileSetUserEvent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ProfileStatus.loading));
      final User user = await _userRepository.getCurrentUser(event.username);
      emit(state.copyWith(currentUser: user, status: ProfileStatus.success));
    } catch (e) {
      emit(state.copyWith(status: ProfileStatus.failure));
    }
  }
}
