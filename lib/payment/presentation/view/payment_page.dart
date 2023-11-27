part of 'view.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key, required this.ticket});

  final TicketOption ticket;

  static Route<dynamic> route({required TicketOption ticket}) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => PaymentPage(ticket: ticket),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PaymentView(ticket: ticket);
  }
}
