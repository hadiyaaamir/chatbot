part of 'view.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();

    _controller = PageController(initialPage: NavigablePage.initialIndex);

    context.read<NavigationBloc>().stream.listen((state) {
      if (_controller.page != state.currentIndex.toDouble()) {
        _controller.jumpToPage(state.currentIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: PageView(
            controller: _controller,
            onPageChanged: (index) => context.read<NavigationBloc>().add(
                  NavigationIndexChanged(selectedIndex: index),
                ),
            children: NavigablePage.pages,
          ),
          bottomNavigationBar: const NavigationBottomBar(),
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
