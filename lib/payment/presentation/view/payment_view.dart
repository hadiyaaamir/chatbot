part of 'view.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key, required this.ticket});

  final TicketOption ticket;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(),
    );
  }
}

class PaymentViewOld extends StatelessWidget {
  const PaymentViewOld({super.key, required this.ticket});

  final TicketOption ticket;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complete Payment'), centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const DottedDivider(),
                _PaymentTicketHeader(ticket: ticket),
                const DottedDivider(spaceBelow: 15),
                _UserDetails(ticket: ticket),
                const SizedBox(height: 30),
                TicketDetailsBlock(ticket: ticket, smallerPrice: true),
                const DottedDivider(spaceAbove: 15),
                _QuantityTotalBlock(ticket: ticket),
                const DottedDivider(spaceBelow: 20),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 40),
                  child: CustomButton(label: 'Pay Now', onPressed: () {}),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PaymentTicketHeader extends StatelessWidget {
  const _PaymentTicketHeader({required this.ticket});

  final TicketOption ticket;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(2),
      child: Column(
        children: [
          Text('Ticket ID: ${ticket.id}', style: textTheme.titleSmall),
          const SizedBox(height: 5),
          Text(
            'Issued on ${DateFormat('dd MMM yyyy').format(ticket.createdAt)}',
            style: textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }
}

class _UserDetails extends StatelessWidget {
  const _UserDetails({required this.ticket});

  final TicketOption ticket;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _LabelTextPair(label: 'Username', text: ticket.username),
          const SizedBox(height: 5),
          _LabelTextPair(label: 'Phone', text: ticket.phone),
        ],
      ),
    );
  }
}

class _LabelTextPair extends StatelessWidget {
  const _LabelTextPair({
    required this.label,
    required this.text,
  });

  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Text('$label: ', style: textTheme.labelLarge),
        Text(text, style: textTheme.bodyMedium),
      ],
    );
  }
}

class _QuantityTotalBlock extends StatelessWidget {
  const _QuantityTotalBlock({required this.ticket});

  final TicketOption ticket;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('Quantity: ${ticket.quantity}'),
          const SizedBox(height: 5),
          Text(
            'Total: \$${ticket.event.price * ticket.quantity}',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
