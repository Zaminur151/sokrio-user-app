import 'package:sokrio_user/core/errors/failures.dart';
import 'package:sokrio_user/core/errors/result.dart';
import 'package:sokrio_user/domain/entities/user.dart';

class UserListResponse {
  final List<User> users;
  final int totalPages;

  const UserListResponse({required this.users, required this.totalPages});
}

abstract class UserRepository {
  Future<Result<UserListResponse, Failure>> getUsers({
    required int page,
    required int perPage,
  });
}
