part of 'view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const HomePage());
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => EventsBloc(
        eventsRepository: EventsRepositoryImpl(eventsApi: MockEventsApi()),
      )..add(EventsOnSubscribedEvent()),
      child: const HomeView(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
