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
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NavigationBloc>(create: (context) => NavigationBloc()),
          BlocProvider<ChatbotBloc>(
            create: (context) => ChatbotBloc(
              audioManager: RepositoryProvider.of<AudioManager>(context),
              chatbotRepository: ChatbotRepositoryImpl(
                chatbotApi: DialogflowGoogleApi(),
              ),
            )..add(ChatbotSubscription()),
          ),
          BlocProvider(
            create: (context) => ProfileBloc(
              userRepository: UserRepositoryImpl(userApi: HardcodedUserApi()),
            )..add(const ProfileSetUserEvent(username: kHardcodedUsername)),
          ),
        ],
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
