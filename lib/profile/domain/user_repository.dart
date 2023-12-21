part of 'domain.dart';

abstract class UserRepository {
  UserRepository({required this.userApi});
  final UserApi userApi;

  Future<User> getCurrentUser(String username);
}
