part of 'view.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key, required this.ticket});

  final Ticket ticket;

  static Route<dynamic> route({required Ticket ticket}) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => PaymentPage(ticket: ticket),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentBloc(
        paymentRepository: PaymentRepositoryImpl(
          paymentApi: MockPaymentApi(),
        ),
      ),
      child: PaymentView(ticket: ticket),
    );
  }
}
