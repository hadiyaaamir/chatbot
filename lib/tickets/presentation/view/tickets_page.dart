part of 'view.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const TicketsPage(),
    );
  }

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage>
    with AutomaticKeepAliveClientMixin<TicketsPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
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

  @override
  bool get wantKeepAlive => true;
}
