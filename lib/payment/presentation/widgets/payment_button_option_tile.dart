part of 'widgets.dart';

class PaymentButtonOptionTile extends OptionTile {
  const PaymentButtonOptionTile({super.key, required this.paymentOption})
      : super(option: paymentOption);

  final PaymentButtonOption paymentOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primaryContainer,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
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
    );
  }
}
