part of 'view.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key, required this.ticket});

  final TicketOption ticket;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Complete Payment'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
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
