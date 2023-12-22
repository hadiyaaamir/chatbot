part of 'tickets_bloc.dart';

enum TicketsStatus { initial, loading, success, failure }

class TicketsState extends Equatable {
  const TicketsState({required this.tickets, required this.status});

  final List<Ticket> tickets;
  final TicketsStatus status;

  @override
  List<Object> get props => [tickets, status];
}

final class TicketsInitial extends TicketsState {
  const TicketsInitial({
    super.tickets = const [],
    super.status = TicketsStatus.initial,
  });
}
