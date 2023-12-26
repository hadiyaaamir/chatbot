part of 'widgets.dart';

class OrderDetailsTile extends StatelessWidget {
  const OrderDetailsTile({super.key, required this.ticket});

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 25,
          horizontal: kPageHorizontalPadding,
        ),
        child: Column(
          children: [
            LabelTextRow(
              label: 'Price per ticket',
              text: '\$${ticket.event.price}',
            ),
            LabelTextRow(
              label: 'Quantity',
              text: '×${ticket.quantity}',
            ),
            const DottedDivider(spaceAbove: 5, spaceBelow: 5),
            LabelTextRow(
              label: 'Total',
              text: '\$${ticket.quantity * ticket.event.price}',
              largerText: true,
            ),
          ],
        ),
      ),
    );
  }
}

class LabelTextRow extends StatelessWidget {
  const LabelTextRow({
    super.key,
    required this.label,
    required this.text,
    this.largerText = false,
  });

  final String label;
  final String text;

  final bool largerText;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label ',
            style: largerText ? textTheme.bodyLarge : textTheme.bodyMedium,
          ),
          Text(
            text,
            style: largerText ? textTheme.headlineSmall : textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
