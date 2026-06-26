import 'package:dio/dio.dart';
import 'package:sokrio_user/core/errors/failures.dart';
import 'package:sokrio_user/core/errors/result.dart';
import 'package:sokrio_user/core/network/network_info.dart';
import 'package:sokrio_user/data/datasources/user_local_data_source.dart';
import 'package:sokrio_user/data/datasources/user_remote_data_source.dart';
import 'package:sokrio_user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Result<UserListResponse, Failure>> getUsers({
    required int page,
    required int perPage,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRes = await remoteDataSource.getUsers(page: page, perPage: perPage);
        
        if (page == 1) {
          await localDataSource.cacheUsers(remoteRes.users);
        } else {
          try {
            final cached = await localDataSource.getCachedUsers();
            final updated = [...cached, ...remoteRes.users];
            final ids = <int>{};
            final unique = updated.where((u) => ids.add(u.id)).toList();
            await localDataSource.cacheUsers(unique);
          } catch (_) {
          }
        }

        return Result.success(UserListResponse(
          users: remoteRes.users,
          totalPages: remoteRes.totalPages,
        ));
      } on DioException catch (e) {
        String errorMsg = 'An unexpected server error occurred';
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          errorMsg = 'Connection timed out. Please try again.';
        } else if (e.type == DioExceptionType.connectionError) {
          errorMsg = 'No internet connection.';
        } else if (e.response != null) {
          errorMsg = 'Server error: ${e.response?.statusCode}';
        }
        return Result.failure(ServerFailure(errorMsg));
      } catch (e) {
        return Result.failure(ServerFailure(e.toString()));
      }
    } else {
      try {
        final cachedUsers = await localDataSource.getCachedUsers();
        if (cachedUsers.isNotEmpty) {
          return Result.success(UserListResponse(
            users: cachedUsers,
            totalPages: 1,
          ));
        } else {
          return Result.failure(const NetworkFailure('No internet connection and no cached data found.'));
        }
      } catch (e) {
        return Result.failure(CacheFailure('Failed to load cached data: $e'));
      }
    }
  }
}
