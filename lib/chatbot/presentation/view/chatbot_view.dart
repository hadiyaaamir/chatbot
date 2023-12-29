part of 'view.dart';

class ChatbotView extends StatelessWidget {
  const ChatbotView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: const [MuteButton()]),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kPageHorizontalPadding,
          vertical: 5,
        ),
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
