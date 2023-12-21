part of 'view.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const ProfilePage());
  }

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return state.status == ProfileStatus.loading
              ? const CustomProgessIndicator()
              : state.currentUser == null
                  ? const Center(child: Text('Error: User not found.'))
                  : ProfileView(user: state.currentUser!);
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
