part of 'widgets.dart';

class PaymentButtonOptionTile extends OptionTile {
  const PaymentButtonOptionTile({super.key, required this.paymentOption})
      : super(option: paymentOption);

  final PaymentButtonOption paymentOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TicketOptionTile(ticket: paymentOption.ticket),
            PaymentOptionButton(paymentOption: paymentOption),
          ],
        ),
      ),
    );
  }
}

class PaymentOptionButton extends StatelessWidget {
  const PaymentOptionButton({super.key, required this.paymentOption});

  final PaymentButtonOption paymentOption;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      label: 'Pay Now',
      onPressed: () => Navigator.push(
        context,
        PaymentPage.route(ticket: paymentOption.ticket),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
    );
  }
}
