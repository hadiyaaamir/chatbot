part of 'widgets.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        _ProfilePicture(image: user.profilePicture),
        const SizedBox(height: 15),
        Text(
          '${user.firstname} ${user.lastname}',
          style: textTheme.headlineMedium,
        ),
        const SizedBox(height: 5),
        Text('@${user.username}', style: textTheme.bodyLarge),
      ],
    );
  }
}

class _ProfilePicture extends StatelessWidget {
  const _ProfilePicture({required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: colorScheme.onPrimary, width: 5),
        boxShadow: [
          BoxShadow(
            color: colorScheme.outline.withOpacity(0.7),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.network(image, height: 150, fit: BoxFit.fill),
      ),
    );
  }
}
