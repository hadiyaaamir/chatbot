part of 'view.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  final PageController _controller = PageController(initialPage: 1);

  void _handleNavigation(int index) {
    _controller.jumpToPage(index);
    context.read<NavigationBloc>().add(
          NavigationIndexChanged(selectedIndex: index),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: PageView(
            controller: _controller,
            onPageChanged: _handleNavigation,
            children: NavigablePage.pages,
          ),
          bottomNavigationBar: NavigationBottomBar(
            onNavigationTapped: _handleNavigation,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
