part of 'widgets.dart';

class PaymentOverviewTile extends StatelessWidget {
  const PaymentOverviewTile({super.key, required this.ticket});

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            _EventImage(ticket: ticket),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    ticket.event.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  _IconTextPair(
                    icon: Icons.calendar_month_rounded,
                    text: formatDate(ticket.slot.date),
                  ),
                  const SizedBox(height: 3),
                  _IconTextPair(
                    icon: Icons.schedule_rounded,
                    text: ticket.slot.timeSlot.toString(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EventImage extends StatelessWidget {
  const _EventImage({required this.ticket});

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: ticket.event.images.isNotEmpty
          ? Image.network(
              ticket.event.images.first,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            )
          : const SizedBox(height: 100, width: 100),
    );
  }
}

class _IconTextPair extends StatelessWidget {
  const _IconTextPair({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18),
        const SizedBox(width: 5),
        Text(
          text,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
