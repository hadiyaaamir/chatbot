part of 'widgets.dart';

class TicketOptionTile extends OptionTile {
  const TicketOptionTile({super.key, required this.ticket})
      : super(option: ticket);

  final TicketOption ticket;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TicketClipper(holeRadius: 40, top: 75),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _TicketHeader(ticket: ticket),
              const DottedDivider(spaceAbove: 8, spaceBelow: 12),
              _TicketFooter(ticket: ticket),
              const SizedBox(height: 10),
              if (!ticket.paymentCompleted) ...[
                const DottedDivider(spaceBelow: 5),
                _PaymentRow(ticket: ticket),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  final double holeRadius;
  final double top;

  TicketClipper({required this.holeRadius, required this.top});

  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(0.0, top)
      ..arcToPoint(
        Offset(0, top + holeRadius),
        clockwise: true,
        radius: const Radius.circular(1),
      )
      ..lineTo(0.0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, top + holeRadius)
      ..arcToPoint(
        Offset(size.width, top),
        clockwise: true,
        radius: const Radius.circular(1),
      );
    path.lineTo(size.width, 0.0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(TicketClipper oldClipper) => true;
}

class _PaymentRow extends StatelessWidget {
  const _PaymentRow({required this.ticket});

  final TicketOption ticket;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ColoredTextTag(
          text: 'Payment Pending',
          backgroundColor: colorScheme.primaryContainer,
          foregroundColor: colorScheme.onPrimaryContainer,
        ),
        const SizedBox(width: 20),
        Flexible(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                PaymentPage.route(
                  ticket: ticket,
                  chatbotBloc: context.read<ChatbotBloc>(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 35),
            ),
            child: const Text('Pay Now'),
          ),
        ),
      ],
    );
  }
}

class _TicketFooter extends StatelessWidget {
  const _TicketFooter({required this.ticket});

  final TicketOption ticket;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _TitleAndDetailPair(
            title: 'Date',
            detail: formatDate(ticket.slot.date),
          ),
          _TitleAndDetailPair(
            title: 'Starting Time',
            detail: ticket.slot.timeSlot.startingTimeString,
          ),
          _TitleAndDetailPair(
            title: 'Ending Time',
            detail: ticket.slot.timeSlot.endingTimeString,
          ),
        ],
      ),
    );
  }
}

class _TicketHeader extends StatelessWidget {
  const _TicketHeader({required this.ticket});

  final TicketOption ticket;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            ticket.event.image,
            height: 60,
            width: 60,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _TitleAndQuantity(ticket: ticket),
              const SizedBox(height: 5),
              LocationDetails(event: ticket.event),
            ],
          ),
        ),
      ],
    );
  }
}

class _TitleAndQuantity extends StatelessWidget {
  const _TitleAndQuantity({required this.ticket});

  final TicketOption ticket;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(ticket.event.title, style: textTheme.titleLarge),
        ),
        ColoredTextTag(text: '×${ticket.quantity}'),
      ],
    );
  }
}

class _TitleAndDetailPair extends StatelessWidget {
  const _TitleAndDetailPair({required this.title, required this.detail});

  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: textTheme.labelLarge),
        Text(detail, style: textTheme.titleSmall),
      ],
    );
  }
}
