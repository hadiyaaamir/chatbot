part of 'view.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  late final AudioManager _audioManager;
  late final EventBloc _eventBloc;

  @override
  void initState() {
    _audioManager = AudioManagerImpl()..initialise();
    _eventBloc = EventBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _audioManager,
      child: BlocProvider.value(
        value: _eventBloc,
        child: const AppView(),
      ),
    );
  }

  @override
  void dispose() {
    _audioManager.dispose();
    super.dispose();
  }
}
