part of 'view.dart';

class TicketsView extends StatelessWidget {
  const TicketsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: BlocBuilder<TicketsBloc, TicketsState>(
          builder: (context, state) {
            return Center(
              child: state.status == TicketsStatus.loading
                  ? const CustomProgessIndicator()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const _BookedTicketsTitle(),
                        _TicketsList(tickets: state.tickets),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}

class _BookedTicketsTitle extends StatelessWidget {
  const _BookedTicketsTitle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
      child: Text(
        'Booked Tickets',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}

class _TicketsList extends StatelessWidget {
  const _TicketsList({required this.tickets});

  final List<Ticket> tickets;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) => TicketOptionTile(
          ticket: tickets[index],
        ),
        itemCount: tickets.length,
      ),
    );
  }
}
