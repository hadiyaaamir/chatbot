part of 'view.dart';

class NavigationView extends StatelessWidget {
  const NavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: IndexedStack(
                  index: state.currentIndex,
                  children: NavigablePage.pages,
                ),
              ),
              const NavigationBottomBar(),
            ],
          ),
        );
      },
    );
  }
}
