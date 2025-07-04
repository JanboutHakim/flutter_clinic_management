import 'dart:convert';
import 'dart:developer';
import 'package:doclib/core/constants/text_constants.dart' as cons;
import 'package:doclib/core/errors/exeptions.dart';
import 'package:doclib/features/auth/data/models/model_mapper.dart';
import 'package:doclib/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  ///add recieved token to lacal storge
  Future<bool> cacheTokens(String aAoken, String tToken);
  Future<bool> cacheUserData(UserModel user);
  Future<List<String?>> getCachedToken();
  Future<UserModel?> getCachedUser();
  Future<void> clearAll();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences localBox;
  const AuthLocalDataSourceImpl(this.localBox);
  @override
  Future<bool> cacheTokens(String aToken, String rToken) async {
    try {
      final savedAToken = await localBox.setString(cons.access_Token, aToken);
      final savedRToken = await localBox.setString(cons.refresh_Token, rToken);
      return savedAToken && savedRToken;
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
  Future<List<String?>> getCachedToken() async {
    List<String?> tokens = [];
    try {
      final aToken = localBox.getString(cons.access_Token);

      final rToken = localBox.getString(cons.refresh_Token);
      tokens = [aToken, rToken];
      return tokens;
    } catch (e) {
      log("local data source error Token not exists ${e.toString()}");
      throw CacheException();
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
