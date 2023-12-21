part of 'models.dart';

class User extends Equatable {
  const User({
    required this.email,
    required this.username,
    required this.firstname,
    this.phoneNumber = '',
    this.lastname = '',
    this.city = '',
    required this.country,
  });

  final String email;
  final String username;
  final String firstname;
  final String lastname;
  final String phoneNumber;
  final String city;
  final String country;

  @override
  List<Object?> get props =>
      [email, username, firstname, lastname, phoneNumber, city, country];
}
