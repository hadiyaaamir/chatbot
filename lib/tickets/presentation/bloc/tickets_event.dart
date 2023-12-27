part of 'tickets_bloc.dart';

abstract class TicketsEvent extends Equatable {
  const TicketsEvent();

  @override
  List<Object> get props => [];
}

class TicketsFetchTicketsEvent extends TicketsEvent {}

class TicketsFilterChanged extends TicketsEvent {
  const TicketsFilterChanged({required this.filter});
  final TicketsFilter filter;

  @override
  List<Object> get props => [filter];
}

class TicketsSearchTextChanged extends TicketsEvent {
  const TicketsSearchTextChanged({required this.searchText});
  final String searchText;

  @override
  List<Object> get props => [searchText];
}

class TicketsShowPendingToggled extends TicketsEvent {}
