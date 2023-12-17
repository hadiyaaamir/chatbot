part of 'view.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const NavigationPage());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
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
      ],
      child: const NavigationView(),
    );
  }
}
