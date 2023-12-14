part of 'view.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const NavigationPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: const NavigationView(),
    );  
  }
}
