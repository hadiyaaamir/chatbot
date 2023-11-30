part of 'view.dart';

class ChatbotView extends StatelessWidget {
  const ChatbotView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('Chatbot'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const Messages(),
            BlocBuilder<ChatbotBloc, ChatbotState>(
              builder: (context, state) => state.status == ChatbotStatus.loading
                  ? const LoadingMessageBubble()
                  : const SizedBox(height: 0),
            ),
            const SuggestionTiles(),
            const RecordingButton(),
            const ChatTextfield(),
          ],
        ),
      ),
    );
  }
}
