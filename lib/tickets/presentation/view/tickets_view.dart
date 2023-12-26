part of 'view.dart';

class TicketsView extends StatelessWidget {
  const TicketsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _BookedTicketsTitle(),
              SizedBox(height: 10),
              TicketsSearchTextField(),
              SizedBox(height: 15),
              _TicketsFilters(),
              TicketsList(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TicketsFilters extends StatelessWidget {
  const _TicketsFilters();

  @override
  Widget build(BuildContext context) {
    final List<TicketsFilter> filters = TicketsFilter.values.toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: List.generate(
          filters.length,
          (index) => BlocBuilder<TicketsBloc, TicketsState>(
            buildWhen: (previous, current) => previous.filter != current.filter,
            builder: (context, state) {
              return Expanded(
                child: FilterButton(
                  isSelected: state.filter == filters[index],
                  label: filters[index].text,
                  onPressed: () => context
                      .read<TicketsBloc>()
                      .add(TicketsFilterChanged(filter: filters[index])),
                ),
              );
            },
          ),
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Text(
        'Booked Tickets',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
