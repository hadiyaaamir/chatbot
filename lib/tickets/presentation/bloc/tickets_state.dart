part of 'tickets_bloc.dart';

enum TicketsStatus { initial, loading, success, failure }

class TicketsState extends Equatable {
  const TicketsState({
    required this.tickets,
    required this.status,
    required this.filter,
    required this.searchText,
    required this.showPending,
  });

  final List<Ticket> tickets;
  final TicketsStatus status;
  final TicketsFilter filter;
  final String searchText;
  final bool showPending;

  TicketsState copyWith({
    List<Ticket>? tickets,
    TicketsStatus? status,
    TicketsFilter? filter,
    String? searchText,
    bool? showPending,
  }) {
    return TicketsState(
      tickets: tickets ?? this.tickets,
      status: status ?? this.status,
      filter: filter ?? this.filter,
      searchText: searchText ?? this.searchText,
      showPending: showPending ?? this.showPending,
    );
  }

  Iterable<Ticket> get filteredTickets {
    final filtered = filter
        .applyAll(tickets)
        .where((ticket) => ticket.matchesSearch(searchText))
        .toList();

    return showPending
        ? filtered
        : filtered.where((ticket) => ticket.paymentCompleted);
  }

  @override
  List<Object> get props => [tickets, status, filter, searchText, showPending];
}

final class TicketsInitial extends TicketsState {
  const TicketsInitial()
      : super(
          tickets: const [],
          status: TicketsStatus.initial,
          filter: TicketsFilter.upcoming,
          searchText: '',
          showPending: false,
        );
}
