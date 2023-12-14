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

  static List<NavigablePage> pages = [
    NavigablePage.chat(),
    NavigablePage.home(),
    NavigablePage.profile(),
  ];

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
