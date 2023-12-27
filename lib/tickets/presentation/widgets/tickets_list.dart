part of 'widgets.dart';

class TicketsList extends StatelessWidget {
  const TicketsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketsBloc, TicketsState>(
      builder: (context, state) {
        final tickets = state.filteredTickets.toList();

        return Expanded(
          child: state.status == TicketsStatus.loading
              ? const Center(child: CustomProgessIndicator())
              : tickets.isEmpty
                  ? _EmptyList(
                      currentFilter: state.filter.name,
                      searchText: state.searchText,
                    )
                  : _NonEmptyList(
                      tickets: tickets,
                      searchText: state.searchText,
                    ),
        );
      },
    );
  }
}

class _NonEmptyList extends StatelessWidget {
  const _NonEmptyList({required this.tickets, required this.searchText});

  final List<Ticket> tickets;
  final String searchText;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => TicketOptionTile(
        ticket: tickets[index],
        searchText: searchText,
      ),
      itemCount: tickets.length,
    );
  }
}

class _EmptyList extends StatelessWidget {
  const _EmptyList({required this.currentFilter, required this.searchText});

  final String searchText;
  final String currentFilter;

  @override
  Widget build(BuildContext context) {
    return searchText.isEmpty
        ? EmptyTextAndButtonList(
            text: 'No $currentFilter tickets found',
            button: const _BookTicketsButton(),
          )
        : EmptyTextAndButtonList(
            text: 'No results found for \'$searchText\'',
            button: OutlinedButton(
              child: const Text('Clear Search'),
              onPressed: () => context
                  .read<TicketsBloc>()
                  .add(const TicketsSearchTextChanged(searchText: '')),
            ),
          );
  }
}

class _BookTicketsButton extends StatelessWidget {
  const _BookTicketsButton();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: const Text('Book Tickets'),
      onPressed: () {
        context.read<ChatbotBloc>().add(
              const ChatbotMessageSent(
                message: ChatMessage(
                  message: MessagePayload(text: 'Book tickets for an event'),
                ),
              ),
            );
        context.read<NavigationBloc>().add(
              NavigationIndexChanged(selectedIndex: NavigablePages.chat.index),
            );
      },
    );
  }
}
