part of 'widgets.dart';

class TicketsSearchTextField extends StatefulWidget {
  const TicketsSearchTextField({super.key});

  @override
  State<TicketsSearchTextField> createState() => _TicketsSearchTextFieldState();
}

class _TicketsSearchTextFieldState extends State<TicketsSearchTextField> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<TicketsBloc, TicketsState>(
      listenWhen: (previous, current) =>
          previous.searchText != current.searchText,
      listener: (context, state) {
        if (state.searchText.isEmpty) searchController.clear();
      },
      child: TextField(
        controller: searchController,
        style: Theme.of(context).textTheme.titleSmall,
        decoration: const InputDecoration(
          hintText: 'Search tickets',
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (searchText) => context.read<TicketsBloc>().add(
              TicketsSearchTextChanged(searchText: searchText),
            ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
