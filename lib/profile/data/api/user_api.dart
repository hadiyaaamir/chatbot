part of 'api.dart';

abstract class UserApi {
  Future<User> getCurrentUser(String username);
}
