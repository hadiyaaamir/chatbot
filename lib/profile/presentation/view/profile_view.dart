part of 'view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          _ColoredBanner(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                ProfileHeader(user: user),
                const SizedBox(height: 40),
                PersonalData(user: user),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ColoredBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(color: colorScheme.background),
          height: 70,
        ),
        Container(
          decoration: BoxDecoration(color: colorScheme.secondary),
          height: 30,
        ),
        Container(
          decoration: BoxDecoration(color: colorScheme.secondaryContainer),
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(color: colorScheme.primary),
          height: 10,
        ),
      ],
    );
  }
}
