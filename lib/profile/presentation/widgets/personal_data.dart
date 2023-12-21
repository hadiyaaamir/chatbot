part of 'widgets.dart';

class PersonalData extends StatelessWidget {
  const PersonalData({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _InformationBlock(
          title: 'Email',
          information: user.email,
          icon: Icons.email_outlined,
        ),
        _InformationBlock(
          title: 'Date of Birth',
          information: formatDate(user.dateOfBirth),
          icon: Icons.cake_outlined,
        ),
        _InformationBlock(
          title: 'Phone Number',
          information: user.phoneNumber,
          icon: Icons.phone_android,
        ),
        _InformationBlock(
          title: 'Location',
          information: '${user.city}, ${user.country}',
          icon: Icons.location_on_outlined,
        ),
      ],
    );
  }
}

class _InformationBlock extends StatelessWidget {
  const _InformationBlock({
    required this.title,
    required this.information,
    required this.icon,
  });

  final String title;
  final String information;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 30),
      child: Row(
        children: [
          _ColoredIconBox(icon: icon),
          const SizedBox(width: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textTheme.labelLarge),
              const SizedBox(height: 3),
              Text(information, style: textTheme.titleMedium),
            ],
          ),
        ],
      ),
    );
  }
}

class _ColoredIconBox extends StatelessWidget {
  const _ColoredIconBox({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Icon(icon, size: 20, color: colorScheme.secondary),
      ),
    );
  }
}
