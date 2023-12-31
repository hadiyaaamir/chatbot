part of 'models.dart';

class User extends Equatable {
  const User({
    required this.email,
    required this.username,
    required this.firstname,
    required this.dateOfBirth,
    this.phoneNumber = '',
    this.lastname = '',
    this.city = '',
    required this.country,
    this.profilePicture = 'https://randomuser.me/api/portraits/men/0.jpg',
  });

  final String email;
  final String username;
  final String firstname;
  final String lastname;
  final DateTime dateOfBirth;
  final String phoneNumber;
  final String city;
  final String country;
  final String profilePicture;

  @override
  List<Object?> get props => [
        email,
        username,
        firstname,
        lastname,
        phoneNumber,
        city,
        country,
        profilePicture,
      ];
}
