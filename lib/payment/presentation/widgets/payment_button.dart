part of 'widgets.dart';

class PaymentButton extends StatelessWidget {
  const PaymentButton({super.key, required this.ticket});

  final TicketOption ticket;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      label: 'Pay Now',
      onPressed: () {
        Navigator.push(context, PaymentPage.route(ticket: ticket));
      },
    );
  }
}
