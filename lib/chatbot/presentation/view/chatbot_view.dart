part of 'view.dart';

class ChatbotView extends StatelessWidget {
  const ChatbotView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chatbot'), centerTitle: true),
      body: const Column(
        children: [Messages(), ChatTextfield()],
      ),
    );
  }
}
