part of 'navigation_bloc.dart';

class NavigationState extends Equatable {
  const NavigationState({required this.currentIndex});

  final int currentIndex;

  Widget get currentPage {
    final pages = NavigablePage.items;
    return currentIndex < pages.length
        ? pages[currentIndex].page
        : NavigablePage.errorPage;
  }

  NavigationState copyWith({int? currentIndex}) {
    return NavigationState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object> get props => [currentIndex];
}

class NavigationInitial extends NavigationState {
  const NavigationInitial({super.currentIndex = 1});
}
