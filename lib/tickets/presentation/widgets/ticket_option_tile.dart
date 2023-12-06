part of 'widgets.dart';

class TicketOptionTile extends OptionTile {
  const TicketOptionTile({super.key, required this.ticket})
      : super(option: ticket);

  final TicketOption ticket;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TicketDetailsBlock(ticket: ticket),
                  const DottedDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _PaidTag(paid: ticket.paymentCompleted),
                      _QuantityAndTotal(
                        price: ticket.event.price,
                        quantity: ticket.quantity,
                      ),
                    ],
                  ),
                  if (!ticket.paymentCompleted) ...[
                    const SizedBox(height: 15),
                    PaymentButton(ticket: ticket),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _QuantityAndTotal extends StatelessWidget {
  const _QuantityAndTotal({required this.quantity, required this.price});

  final int quantity;
  final int price;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text('Quantity: $quantity', style: textTheme.bodySmall),
        const SizedBox(height: 2),
        Text('Total: \$${quantity * price}', style: textTheme.labelMedium),
      ],
    );
  }
}

class _PaidTag extends StatelessWidget {
  const _PaidTag({required this.paid});

  final bool paid;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: paid ? colorScheme.primary : colorScheme.error,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: paid ? colorScheme.primaryContainer : colorScheme.errorContainer,
      ),
      child: Text(
        paid ? 'Paid' : 'Payment Pending',
        style: textTheme.labelSmall,
      ),
    );
  }
}
