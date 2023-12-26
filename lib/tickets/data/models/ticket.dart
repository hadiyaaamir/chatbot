part of 'models.dart';

class Ticket extends Option {
  const Ticket({
    required this.id,
    required this.event,
    required this.username,
    required this.phone,
    required this.quantity,
    required this.paymentCompleted,
    required this.createdAt,
    required this.slot,
  });

  final String id;
  final Event event;
  final String username;
  final String phone;
  final int quantity;
  final bool paymentCompleted;
  final DateTime createdAt;
  final TicketSlot slot;

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'] as String? ?? '',
      event: Event.fromJson(json['event'] as Map<String, dynamic>? ?? {}),
      username: json['username'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      quantity: json['quantity'] as int? ?? 0,
      paymentCompleted: json['paymentCompleted'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      slot: TicketSlot.fromJson(json['slot'] as Map<String, dynamic>? ?? {}),
    );
  }

  Ticket copyWith({
    String? id,
    Event? event,
    String? username,
    String? phone,
    int? quantity,
    bool? paymentCompleted,
    DateTime? createdAt,
    TicketSlot? slot,
  }) {
    return Ticket(
      id: id ?? this.id,
      event: event ?? this.event,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      quantity: quantity ?? this.quantity,
      paymentCompleted: paymentCompleted ?? this.paymentCompleted,
      createdAt: createdAt ?? this.createdAt,
      slot: slot ?? this.slot,
    );
  }

  bool matchesSearch(String searchText) {
    searchText = searchText.toLowerCase();
    return event.title.toLowerCase().contains(searchText) ||
        event.city.toLowerCase().contains(searchText) ||
        event.country.toLowerCase().contains(searchText) ||
        formatDate(slot.date).toLowerCase().contains(searchText) ||
        getFullMonth(slot.date).toLowerCase().contains(searchText) ||
        slot.timeSlot.startingTimeString.toLowerCase().contains(searchText) ||
        slot.timeSlot.endingTimeString.toLowerCase().contains(searchText);
  }

  @override
  List<Object> get props => [
        id,
        event,
        username,
        phone,
        quantity,
        paymentCompleted,
        createdAt,
        slot,
      ];
}
