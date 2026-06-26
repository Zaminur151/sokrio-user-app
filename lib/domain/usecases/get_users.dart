import 'package:sokrio_user/core/errors/failures.dart';
import 'package:sokrio_user/core/errors/result.dart';
import 'package:sokrio_user/domain/repositories/user_repository.dart';

class GetUsers {
  final UserRepository repository;

  GetUsers(this.repository);

  Future<Result<UserListResponse, Failure>> call({
    required int page,
    required int perPage,
  }) async {
    return await repository.getUsers(page: page, perPage: perPage);
  }
}
