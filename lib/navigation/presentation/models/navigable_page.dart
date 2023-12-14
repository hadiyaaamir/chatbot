part of 'models.dart';

class NavigablePage {
  NavigablePage({
    required this.icon,
    required this.label,
    required this.page,
  });

  final IconData icon;
  final String label;
  final Widget page;

  static List<NavigablePage> items = [
    NavigablePage.chat(),
    NavigablePage.home(),
    NavigablePage.profile(),
  ];

  static List<Widget> get pages {
    return List.generate(items.length, (index) => items[index].page);
  }

  static Widget errorPage = const Scaffold(
    body: Center(
      child: Text('Error: page not found'),
    ),
  );

  factory NavigablePage.chat() {
    return NavigablePage(
      page: const ChatbotPage(),
      label: 'Chatbot',
      icon: Icons.chat_bubble_outline,
    );
  }

  factory NavigablePage.home() {
    return NavigablePage(
      page: const HomePage(),
      label: 'Home',
      icon: Icons.home_outlined,
    );
  }

  factory NavigablePage.profile() {
    return NavigablePage(
      page: const ProfilePage(),
      label: 'Profile',
      icon: Icons.account_circle_outlined,
    );
  }
}
