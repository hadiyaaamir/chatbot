part of 'api.dart';

class HardcodedUserApi extends UserApi {
  User? _currentUser;

  @override
  Future<User> getCurrentUser(String username) async {
    if (_currentUser != null) return Future.value(_currentUser);

    await Future.delayed(const Duration(seconds: 1));
    return User(
      email: 'hadiyaaamir222@gmail.com',
      username: kHardcodedUsername,
      firstname: 'Hadiya',
      lastname: 'Aamir',
      phoneNumber: '1234567743',
      city: 'Karachi',
      country: 'Pakistan',
      profilePicture: _randomProfilePicture,
    );
  }

  String get _randomProfilePicture {
    int number = Random().nextInt(100);

    List<String> genders = ['men', 'women'];
    String gender = genders[Random().nextInt(genders.length)];

    return 'https://randomuser.me/api/portraits/$gender/$number.jpg';
  }
}
