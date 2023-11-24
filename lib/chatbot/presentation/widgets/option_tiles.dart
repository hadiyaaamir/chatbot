import 'package:chatbot/chatbot/chatbot.dart';
import 'package:chatbot/chatbot/utils/widgets/button.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OptionTiles extends StatelessWidget {
  const OptionTiles({super.key, this.options, required this.usernameRequired});

  final List<Option>? options;
  final bool usernameRequired;

  @override
  Widget build(BuildContext context) {
    return options != null
        ? Column(
            children: List.generate(
              options!.length,
              (index) => OptionTile.create(
                option: options![index],
                usernameRequired: usernameRequired,
              ),
            ),
          )
        : Container();
  }
}

abstract class OptionTile extends StatelessWidget {
  const OptionTile({
    super.key,
    required this.option,
    required this.usernameRequired,
  });

  final bool usernameRequired;

  factory OptionTile.create({
    Key? key,
    required Option option,
    required bool usernameRequired,
  }) {
    if (option is EventOption) {
      return EventTile(
        event: option,
        usernameRequired: usernameRequired,
      );
    }
    if (option is TicketOption) {
      return TicketTile(
        ticket: option,
        usernameRequired: usernameRequired,
      );
    }

    throw UnimplementedError('Tile not implemented for $option');
  }

  final Option option;
}

class EventTile extends OptionTile {
  const EventTile(
      {super.key, required this.event, required super.usernameRequired})
      : super(option: event);

  final EventOption event;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(event.image, height: 150, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _EventDetailsBlock(event: event),
                const SizedBox(height: 10),
                CustomButton(
                  label: 'Book Tickets',
                  onPressed: () => context.read<ChatbotBloc>().add(
                        ChatbotMessageSent(
                          attachUsername: usernameRequired,
                          message: ChatMessage(
                            message: MessagePayload(
                              'I want to book tickets for event ${event.id}',
                              displayText:
                                  'I want to book tickets for ${event.title}',
                            ),
                          ),
                        ),
                      ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TicketTile extends OptionTile {
  const TicketTile(
      {super.key, required this.ticket, required super.usernameRequired})
      : super(option: ticket);

  final TicketOption ticket;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

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
                  _EventDetailsBlock(event: ticket.event),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: DottedLine(
                      dashColor: colorScheme.outlineVariant,
                      dashGapLength: 5,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ticket.paymentCompleted
                                ? colorScheme.primary
                                : colorScheme.error,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          color: ticket.paymentCompleted
                              ? colorScheme.primaryContainer
                              : colorScheme.errorContainer,
                        ),
                        child: Text(
                          ticket.paymentCompleted ? 'Paid' : 'Payment Pending',
                          style: textTheme.labelSmall,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            'Quantity: ${ticket.quantity}',
                            style: textTheme.bodySmall,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Total: \$${ticket.quantity * ticket.event.price}',
                            style: textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _EventDetailsBlock extends StatelessWidget {
  const _EventDetailsBlock({required this.event});

  final EventOption event;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.title, style: textTheme.titleMedium),
                  Text(
                    DateFormat('dd MMM yyyy').format(event.date),
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
              Text('\$${event.price}', style: textTheme.titleLarge),
            ],
          ),
        ),
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: textTheme.bodyLarge?.fontSize,
            ),
            Expanded(child: Text('${event.city}, ${event.country}')),
          ],
        ),
      ],
    );
  }
}
