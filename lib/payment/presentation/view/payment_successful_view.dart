part of 'view.dart';

class PaymentSuccessfulView extends StatelessWidget {
  const PaymentSuccessfulView({super.key, required this.ticket});

  final TicketOption ticket;

  static Route<dynamic> route({required TicketOption ticket}) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => PaymentSuccessfulView(ticket: ticket),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ChatbotBloc chatbotBloc = context.read<ChatbotBloc>();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/payment_completed.png', height: 180),
              const SizedBox(height: 40),
              Text('Order Complete', style: textTheme.headlineMedium),
              const SizedBox(height: 10),
              Text(
                'Your payment was successful. \nSee you at the event!',
                style: textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ViewTicketButton(ticket: ticket, chatbotBloc: chatbotBloc),
            const SizedBox(height: 5),
            const _ResumeExploringButton(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _ViewTicketButton extends StatelessWidget {
  const _ViewTicketButton({required this.ticket, required this.chatbotBloc});

  final TicketOption ticket;
  final ChatbotBloc chatbotBloc;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('View Ticket'),
      onPressed: () {
        chatbotBloc.add(
          ChatbotMessageSent(
            message: ChatMessage(
              message: MessagePayload(
                text: 'Give me the card of ticket ${ticket.id}',
                displayText: 'Show me my recently paid ticket',
              ),
            ),
          ),
        );
        context.read<NavigationBloc>().add(
              NavigationIndexChanged(selectedIndex: NavigablePages.chat.index),
            );
        Navigator.pop(context);
      },
    );
  }
}

class _ResumeExploringButton extends StatelessWidget {
  const _ResumeExploringButton();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        context.read<NavigationBloc>().add(
              NavigationIndexChanged(selectedIndex: NavigablePages.home.index),
            );
        Navigator.pop(context);
      },
      child: const Text('Resume Exploring'),
    );
  }
}
