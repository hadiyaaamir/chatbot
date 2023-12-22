part of 'widgets.dart';

class PersonalInformationTile extends StatelessWidget {
  const PersonalInformationTile({super.key, required this.ticket});

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          children: [
            const LabelTextRow(label: 'Username', text: kHardcodedUsername),
            LabelTextRow(label: 'Contact Number', text: ticket.phone),
          ],
        ),
      ),
    );
  }
}
