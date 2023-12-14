part of 'view.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const ChatbotPage());
  }

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage>
    with AutomaticKeepAliveClientMixin<ChatbotPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => ChatbotBloc(
        audioManager: RepositoryProvider.of<AudioManager>(context),
        chatbotRepository: ChatbotRepositoryImpl(
          chatbotApi: DialogflowGoogleApi(),
        ),
      )..add(ChatbotSubscription()),
      child: const ChatbotView(),
    );
  }
}
