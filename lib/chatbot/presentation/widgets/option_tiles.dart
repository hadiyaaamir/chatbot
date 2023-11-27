import 'package:chatbot/chatbot/chatbot.dart';
import 'package:chatbot/events/events.dart';
import 'package:chatbot/payment/data/models/models.dart';
import 'package:chatbot/payment/presentation/widgets/widgets.dart';
import 'package:chatbot/tickets/tickets.dart';
import 'package:flutter/material.dart';

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
  });

  factory OptionTile.create({
    Key? key,
    required Option option,
    required bool usernameRequired,
  }) {
    if (option is Event) {
      return EventOptionTile(event: option, usernameRequired: usernameRequired);
    }
    if (option is TicketOption) {
      return TicketOptionTile(ticket: option);
    }
    if (option is PaymentButtonOption) {
      return PaymentButtonOptionTile(paymentOption: option);
    }

    throw UnimplementedError('Tile not implemented for $option');
  }

  final Option option;
}
