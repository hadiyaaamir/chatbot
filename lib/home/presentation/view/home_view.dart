part of 'view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              _SearchTextField(),
              SizedBox(height: 20),
              EventsFilterButtons(),
              SizedBox(height: 10),
              EventsList(),
              SizedBox(height: 20),
              SuggestionMessages(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchTextField extends StatelessWidget {
  const _SearchTextField();

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.titleSmall,
      decoration: const InputDecoration(
        hintText: 'Search events',
        prefixIcon: Icon(Icons.search),
      ),
    );
  }
}
