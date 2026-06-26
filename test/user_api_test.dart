import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sokrio_user/data/datasources/user_remote_data_source.dart';

class MockAdapter implements HttpClientAdapter {
  late ResponseBody responseBody;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<void>? requestStream,
    Future<void>? cancelFuture,
  ) async => responseBody;

  @override
  void close({bool force = false}) {}
}

void main() {
  late Dio dio;
  late UserRemoteDataSourceImpl dataSource;
  late MockAdapter mockAdapter;

  setUp(() {
    dio = Dio();
    mockAdapter = MockAdapter();
    dio.httpClientAdapter = mockAdapter;
    dataSource = UserRemoteDataSourceImpl(dio);
  });

  test('should return users when status code is 200', () async {
    final mockJson = {
      'total_pages': 2,
      'data': [
        {
          'id': 1,
          'email': 'george.bluth@reqres.in',
          'first_name': 'George',
          'last_name': 'Bluth',
          'avatar': 'https://reqres.in/img/faces/1-image.jpg',
        }
      ]
    };

    mockAdapter.responseBody = ResponseBody.fromString(
      jsonEncode(mockJson),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );

    final result = await dataSource.getUsers(page: 1, perPage: 10);

    expect(result.users.length, 1);
    expect(result.users[0].id, 1);
    expect(result.users[0].firstName, 'George');
    expect(result.totalPages, 2);
  });

  test('should throw DioException when status code is 500', () async {
    mockAdapter.responseBody = ResponseBody.fromString('', 500);

    expect(
      () => dataSource.getUsers(page: 1, perPage: 10),
      throwsA(isA<DioException>()),
    );
  });
}
