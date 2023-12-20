part of 'widgets.dart';

class PaymentOverviewTile extends StatelessWidget {
  const PaymentOverviewTile({super.key, required this.ticket});

  final TicketOption ticket;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                ticket.event.image,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
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
