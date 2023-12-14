part of 'widgets.dart';

class NavigationBottomBar extends StatelessWidget {
  const NavigationBottomBar({super.key, required this.onNavigationTapped});

  final Function(int index) onNavigationTapped;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final items = NavigablePage.items;

    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
          backgroundColor: colorScheme.onInverseSurface,
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
