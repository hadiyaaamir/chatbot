part of 'widgets.dart';

class TicketDetailsBlock extends StatelessWidget {
  const TicketDetailsBlock({
    super.key,
    required this.ticket,
    this.smallerPrice = false,
  });

  final Ticket ticket;
  final bool smallerPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _NameAndDateBlock(ticket: ticket),
              _Price(price: ticket.event.price, smallerPrice: smallerPrice),
            ],
          ),
        ),
        const SizedBox(height: 2),
      ],
    );
  }
}

class _NameAndDateBlock extends StatelessWidget {
  const _NameAndDateBlock({required this.ticket});

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(ticket.event.title, style: textTheme.titleMedium),
        const SizedBox(height: 5),
        Text(
          '${DateFormat('dd MMM yyyy').format(ticket.slot.date)} | '
          '${ticket.slot.timeSlot}',
          style: textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _Price extends StatelessWidget {
  const _Price({required this.price, required this.smallerPrice});

  final int price;
  final bool smallerPrice;

  @override
  Widget build(BuildContext context) {
    return Text(
      '\$$price',
      style: smallerPrice
          ? Theme.of(context).textTheme.titleMedium
          : Theme.of(context).textTheme.titleLarge,
    );
  }
}
