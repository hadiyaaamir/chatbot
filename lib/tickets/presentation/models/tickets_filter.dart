part of 'models.dart';

enum TicketsFilter { upcoming, past }

extension TicketsFilterX on TicketsFilter {
  bool apply(Ticket ticket) {
    switch (this) {
      case TicketsFilter.upcoming:
        return ticket.slot.date.isAfter(DateTime.now()) ||
            ticket.slot.date.isAtSameMomentAs(DateTime.now());
      case TicketsFilter.past:
        return ticket.slot.date.isBefore(DateTime.now());
    }
  }

  String get text {
    switch (this) {
      case TicketsFilter.upcoming:
        return 'Upcoming';
      case TicketsFilter.past:
        return 'Past Tickets';
    }
  }

  Iterable<Ticket> applyAll(Iterable<Ticket> tickets) => tickets.where(apply);
}
