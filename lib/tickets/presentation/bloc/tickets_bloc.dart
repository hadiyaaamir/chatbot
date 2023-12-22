import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chatbot/tickets/tickets.dart';
import 'package:equatable/equatable.dart';

part 'tickets_event.dart';
part 'tickets_state.dart';

class TicketsBloc extends Bloc<TicketsEvent, TicketsState> {
  TicketsBloc({required TicketsRepository ticketsRepository})
      : _ticketsRepository = ticketsRepository,
        super(const TicketsInitial()) {
    on<TicketsFetchTicketsEvent>(_fetchTickets);
  }

  final TicketsRepository _ticketsRepository;

  Future<void> _fetchTickets(
    TicketsFetchTicketsEvent event,
    Emitter<TicketsState> emit,
  ) async {
    try {
      emit(state.copyWith(status: TicketsStatus.loading));
      final tickets = await _ticketsRepository.fetchTickets();
      emit(state.copyWith(tickets: tickets, status: TicketsStatus.success));
    } on Exception catch (_) {
      emit(state.copyWith(status: TicketsStatus.failure));
    }
  }
}
