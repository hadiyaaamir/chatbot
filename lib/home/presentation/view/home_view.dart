part of 'view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kPageHorizontalPadding),
          child: Column(
            children: [
              EventsSearchTextField(),
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
