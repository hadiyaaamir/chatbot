part of 'view.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  late final AudioManager _audioManager;

  @override
  void initState() {
    _audioManager = AudioManagerImpl()..initialise();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _audioManager,
      child: const AppView(),
    );
  }

  @override
  void dispose() {
    _audioManager.dispose();
    super.dispose();
  }
}
