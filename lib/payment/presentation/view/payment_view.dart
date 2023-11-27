part of 'view.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key, required this.ticket});

  final TicketOption ticket;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complete Payment')),
      body: Column(children: [
        Text('Ticket ID: ${ticket.id}'),
        Text('Quantity: ${ticket.quantity}'),
        Text(
          'Total: ${ticket.quantity} multiplied by event cost. gotto get event arghh',
        ),
      ]),
    );
  }
}
