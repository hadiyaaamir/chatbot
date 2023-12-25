part of 'view.dart';

class TicketsPage extends StatelessWidget {
  const TicketsPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const TicketsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TicketsBloc(
        ticketsRepository: TicketsRepositoryImpl(
          ticketsApi: MockTicketsApi(),
          eventsApi: MockEventsApi(),
        ),
      )..add(TicketsFetchTicketsEvent()),
      child: const TicketsView(),
    );
  }
}
