import 'dart:convert';
import 'dart:developer';
import 'package:doclib/core/constants/text_constants.dart' as cons;
import 'package:doclib/core/errors/exeptions.dart';
import 'package:doclib/features/auth/data/models/model_mapper.dart';
import 'package:doclib/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  ///add recieved token to lacal storge
  Future<bool> cacheToken(String token);
  Future<bool> cacheUserData(UserModel user);
  Future<String?> getCachedToken();
  Future<UserModel?> getCachedUser();
  Future<void> clearAll(); // useful for logout
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences localBox;
  const AuthLocalDataSourceImpl(this.localBox);
  @override
  Future<bool> cacheToken(String token) async {
    try {
      final succes = await localBox.setString(cons.access_Token, token);
      return succes;
    } catch (e) {
      throw CacheException("error when save token");
    }
  }

  @override
  Future<bool> cacheUserData(UserModel user) async {
    final isSuccess = await localBox.setString(
      cons.localUser,
      jsonEncode(user.toJson()),
    );
    return isSuccess;
  }

  @override
  Future<void> clearAll() async {
    await localBox.clear();
  }

  @override
  Future<String?> getCachedToken() async {
    try {
      final token = localBox.getString(cons.access_Token);
      return token;
    } catch (e) {
      log("local data source error Token not exists ${e.toString()}");
      return null;
    }
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final userStringData = localBox.getString(cons.localUser);
    if (userStringData != null) {
      final json = jsonDecode(userStringData);
      return UserMapper.fromJson(json);
    } else {
      throw CacheException();
    }
  }
}
