part of 'view.dart';

class ChatbotPage extends StatelessWidget {
  const ChatbotPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const ChatbotPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatbotBloc(
        audioManager: AudioManagerImpl(),
        chatbotRepository: ChatbotRepositoryImpl(
          chatbotApi: DialogflowGoogleApi(),
        ),
      )..add(ChatbotSubscription()),
      child: const ChatbotView(),
    );
  }
}
