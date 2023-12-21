part of 'view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return Center(
              child: state.status == ProfileStatus.loading
                  ? const CustomProgessIndicator()
                  : state.currentUser == null
                      ? const Text('Error: User not found.')
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(state.currentUser!.firstname),
                            Text(state.currentUser!.lastname),
                            Text(state.currentUser!.username),
                            Text(state.currentUser!.city),
                            Text(state.currentUser!.country),
                          ],
                        ));
        },
      ),
    );
  }
}
