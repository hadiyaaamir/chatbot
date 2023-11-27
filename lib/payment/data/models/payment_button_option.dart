part of 'models.dart';

class PaymentButtonOption extends Option {
  const PaymentButtonOption({required this.ticket});

  final TicketOption ticket;

  factory PaymentButtonOption.fromJson(Map<String, dynamic> json) {
    return PaymentButtonOption(
      ticket: TicketOption.fromJson(
        json['ticket'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  @override
  List<Object> get props => [ticket];
}
