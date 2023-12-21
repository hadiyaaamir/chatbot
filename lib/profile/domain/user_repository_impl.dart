part of 'domain.dart';

class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl({required super.userApi});

  @override
  Future<User> getCurrentUser(String username) {
    return userApi.getCurrentUser(username);
  }
}
