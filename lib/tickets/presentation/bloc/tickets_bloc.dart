import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chatbot/tickets/tickets.dart';
import 'package:equatable/equatable.dart';

part 'tickets_event.dart';
part 'tickets_state.dart';

class TicketsBloc extends Bloc<TicketsEvent, TicketsState> {
  TicketsBloc({
    required TicketsRepository ticketsRepository,
  })  : _ticketsRepository = ticketsRepository,
        super(const TicketsInitial()) {
    on<TicketsFetchTicketsEvent>(_fetchTickets);
    on<TicketsFilterChanged>(_onFilterChanged);
    on<TicketsSearchTextChanged>(_onSearchTextChanged);
    on<TicketsShowPendingToggled>(_onShowPendingToggled);
  }

  final TicketsRepository _ticketsRepository;

  Future<void> _fetchTickets(
    TicketsFetchTicketsEvent event,
    Emitter<TicketsState> emit,
  ) async {
    try {
      emit(state.copyWith(status: TicketsStatus.loading));
      final tickets = await _ticketsRepository.fetchTickets(
        username: event.username,
      );
      emit(state.copyWith(tickets: tickets, status: TicketsStatus.success));
    } on Exception catch (_) {
      emit(state.copyWith(status: TicketsStatus.failure));
    }
  }

  void _onFilterChanged(
    TicketsFilterChanged event,
    Emitter<TicketsState> emit,
  ) {
    emit(state.copyWith(filter: event.filter));
  }

  void _onSearchTextChanged(
    TicketsSearchTextChanged event,
    Emitter<TicketsState> emit,
  ) {
    emit(state.copyWith(searchText: event.searchText));
  }

  Future<void> _onShowPendingToggled(
    TicketsShowPendingToggled event,
    Emitter<TicketsState> emit,
  ) async {
    emit(state.copyWith(showPending: !state.showPending));
  }
}
