part of 'models.dart';

enum NavigablePages { chat, home, tickets, profile }

extension XNavigablePages on NavigablePages {
  static final Map<NavigablePages, int> _indexes = {
    NavigablePages.chat: 0,
    NavigablePages.home: 1,
    NavigablePages.tickets: 2,
    NavigablePages.profile: 3,
  };

  static final Map<NavigablePages, NavigablePage> _pages = {
    NavigablePages.chat: NavigablePage.chat(),
    NavigablePages.home: NavigablePage.home(),
    NavigablePages.tickets: NavigablePage.tickets(),
    NavigablePages.profile: NavigablePage.profile(),
  };

  int get index => _indexes[this] ?? 1;
  NavigablePage get page => _pages[this] ?? NavigablePage.home();
}

class NavigablePage {
  NavigablePage({
    required this.icon,
    IconData? activeIcon,
    required this.label,
    required this.page,
  }) : activeIcon = activeIcon ?? icon;

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final Widget page;

  static int initialIndex = NavigablePages.home.index;

  static List<NavigablePage> items = List.generate(
    NavigablePages.values.length,
    (index) => NavigablePages.values[index].page,
  ).toList();

  static List<Widget> get pages {
    return List.generate(
      NavigablePages.values.length,
      (index) => NavigablePages.values[index].page.page,
    ).toList();
  }

  static Widget errorPage = const Scaffold(
    body: Center(
      child: Text('Error: page not found'),
    ),
  );

  factory NavigablePage.chat() {
    return NavigablePage(
      page: const ChatbotPage(),
      label: 'Assistant',
      icon: Icons.chat_bubble_outline_rounded,
      activeIcon: Icons.chat_bubble_rounded,
    );
  }

  factory NavigablePage.home() {
    return NavigablePage(
      page: const HomePage(),
      label: 'Home',
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
    );
  }

  factory NavigablePage.tickets() {
    return NavigablePage(
      page: const TicketsPage(),
      label: 'My Tickets',
      icon: Icons.confirmation_num_outlined,
      activeIcon: Icons.confirmation_num,
    );
  }

  factory NavigablePage.profile() {
    return NavigablePage(
      page: const ProfilePage(),
      label: 'Profile',
      icon: Icons.account_circle_outlined,
      activeIcon: Icons.account_circle,
    );
  }
}
