import 'dart:developer';
import 'package:doclib/core/constants/text_constants.dart' as cons;
import 'package:doclib/core/errors/exeptions.dart';
import 'package:doclib/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  ///add recieved token to lacal storge
  Future<bool> cacheToken(String token);
  Future<void> cacheUserData(UserModel user);
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
  Future<void> cacheUserData(UserModel user) {
    // TODO: implement cacheUserData
    throw UnimplementedError();
  }

  @override
  Future<void> clearAll() {
    // TODO: implement clearAll
    throw UnimplementedError();
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
  Future<UserModel?> getCachedUser() {
    // TODO: implement getCachedUser
    throw UnimplementedError();
  }
}
