part of 'view.dart';

class ChatbotView extends StatelessWidget {
  const ChatbotView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 70, bottom: 5),
        child: Column(
          children: [
            const Messages(),
            BlocBuilder<ChatbotBloc, ChatbotState>(
              builder: (context, state) => state.status == ChatbotStatus.loading
                  ? const LoadingMessageBubble()
                  : const SizedBox(height: 0),
            ),
            const SuggestionTiles(),
            const ChatTextfield(),
          ],
        ),
      ),
    );
  }
}
