part of 'view.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const ProfilePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: const ProfileView(),
    );  
  }
}
