part of 'view.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key, required this.ticket});

  final TicketOption ticket;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<PaymentBloc, PaymentState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == PaymentStatus.failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Unexpected error occured')),
              );
          }
          if (state.status == PaymentStatus.success) {
            Navigator.pushReplacement(
              context,
              PaymentSuccessfulView.route(ticket: ticket),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PaymentOverviewTile(ticket: ticket),
                const SizedBox(height: 25),
                const _PaymentViewHeading(text: 'Order Summary'),
                const SizedBox(height: 8),
                OrderDetailsTile(ticket: ticket),
                const SizedBox(height: 25),
                const _PaymentViewHeading(text: 'Personal Information'),
                const SizedBox(height: 8),
                PersonalInformationTile(ticket: ticket),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _CompletePaymentButton(ticket: ticket),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _CompletePaymentButton extends StatelessWidget {
  const _CompletePaymentButton({required this.ticket});

  final TicketOption ticket;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ElevatedButton(
          onPressed: state.status != PaymentStatus.loading
              ? () => context
                  .read<PaymentBloc>()
                  .add(PaymentAttemptCompletionEvent(ticketId: ticket.id))
              : null,
          child: state.status == PaymentStatus.loading
              ? const SizedBox(height: 20, child: CustomProgessIndicator())
              : const Text('Complete Payment'),
        ),
      );
    });
  }
}

class _PaymentViewHeading extends StatelessWidget {
  const _PaymentViewHeading({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(text, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}
