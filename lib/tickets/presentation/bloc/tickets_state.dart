part of 'tickets_bloc.dart';

enum TicketsStatus { initial, loading, success, failure }

class TicketsState extends Equatable {
  const TicketsState({
    required this.tickets,
    required this.status,
    required this.filter,
    required this.searchText,
  });

  final List<Ticket> tickets;
  final TicketsStatus status;
  final TicketsFilter filter;
  final String searchText;

  TicketsState copyWith({
    List<Ticket>? tickets,
    TicketsStatus? status,
    TicketsFilter? filter,
    String? searchText,
  }) {
    return TicketsState(
      tickets: tickets ?? this.tickets,
      status: status ?? this.status,
      filter: filter ?? this.filter,
      searchText: searchText ?? this.searchText,
    );
  }

  Iterable<Ticket> get filteredTickets => filter
      .applyAll(tickets)
      .where((ticket) => ticket.matchesSearch(searchText))
      .toList();

  @override
  List<Object> get props => [tickets, status, filter, searchText];
}

final class TicketsInitial extends TicketsState {
  const TicketsInitial()
      : super(
          tickets: const [],
          status: TicketsStatus.initial,
          filter: TicketsFilter.upcoming,
          searchText: '',
        );
}
