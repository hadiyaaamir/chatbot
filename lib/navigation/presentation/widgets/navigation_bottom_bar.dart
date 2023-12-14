part of 'widgets.dart';

class NavigationBottomBar extends StatefulWidget {
  const NavigationBottomBar({super.key});

  @override
  State<NavigationBottomBar> createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar> {
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
              label: page.label,
            );
          }),
          currentIndex: state.currentIndex,
          onTap: (index) => context
              .read<NavigationBloc>()
              .add(NavigationIndexChanged(selectedIndex: index)),
        );
      },
    );
  }
}
