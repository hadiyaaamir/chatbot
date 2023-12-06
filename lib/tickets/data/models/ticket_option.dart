part of 'models.dart';

class TicketOption extends Option {
  const TicketOption({
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

  factory TicketOption.fromJson(Map<String, dynamic> json) {
    return TicketOption(
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
