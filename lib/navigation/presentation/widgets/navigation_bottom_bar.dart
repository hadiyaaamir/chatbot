part of 'widgets.dart';

class NavigationBottomBar extends StatelessWidget {
  const NavigationBottomBar({super.key, required this.onNavigationTapped});

  final Function(int index) onNavigationTapped;

  @override
  Widget build(BuildContext context) {
    final items = NavigablePage.items;

    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
          items: List.generate(items.length, (index) {
            final page = items[index];
            return BottomNavigationBarItem(
              icon: Icon(page.icon),
              activeIcon: Icon(page.activeIcon),
              label: page.label,
            );
          }),
          currentIndex: state.currentIndex,
          onTap: onNavigationTapped,
        );
      },
    );
  }
}
