import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sokrio_user/data/models/user_model.dart';

abstract class UserLocalDataSource {
  Future<List<UserModel>> getCachedUsers();
  Future<void> cacheUsers(List<UserModel> usersToCache);
}

const cachedUserListKey = 'CACHED_USER_LIST';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> cacheUsers(List<UserModel> usersToCache) {
    final List<Map<String, dynamic>> jsonList =
        usersToCache.map((user) => user.toJson()).toList();
    final String jsonString = jsonEncode(jsonList);
    return sharedPreferences.setString(cachedUserListKey, jsonString);
  }

  @override
  Future<List<UserModel>> getCachedUsers() {
    final jsonString = sharedPreferences.getString(cachedUserListKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;
      final List<UserModel> users = jsonList
          .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
          .toList();
      return Future.value(users);
    } else {
      return Future.value([]);
    }
  }
}
