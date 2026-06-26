import 'package:dio/dio.dart';
import 'package:sokrio_user/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<RemoteUserListResponse> getUsers({required int page, required int perPage});
}

class RemoteUserListResponse {
  final List<UserModel> users;
  final int totalPages;

  const RemoteUserListResponse({required this.users, required this.totalPages});
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSourceImpl(this.dio);

  @override
  Future<RemoteUserListResponse> getUsers({required int page, required int perPage}) async {
    try {
      final response = await dio.get(
        '/users',
        queryParameters: {
          'page': page,
          'per_page': perPage,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final List<dynamic> list = data['data'] as List<dynamic>;
        final int totalPages = data['total_pages'] as int? ?? 1;

        final users = list.map((json) => UserModel.fromJson(json as Map<String, dynamic>)).toList();
        return RemoteUserListResponse(users: users, totalPages: totalPages);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
