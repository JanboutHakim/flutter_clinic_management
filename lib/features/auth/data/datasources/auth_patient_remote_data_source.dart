import 'dart:convert';
import 'dart:developer';
import 'package:doclib/core/errors/handler.dart';
import 'package:doclib/features/auth/data/datasources/model_mapper.dart';
import 'package:doclib/features/auth/data/models/Auth_model.dart';
import 'package:doclib/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required AuthRequest authreRuest});

  Future<UserModel> register({required AuthRequest authRequest});
}

class AuthRemoteDataSoureceImpl implements AuthRemoteDataSource {
  final http.Client client;
  AuthRemoteDataSoureceImpl({required this.client});

  @override
  Future<UserModel> register({required AuthRequest authRequest}) async {
    log("start sendeing register request ");
    // print("fofofofofofofofofofofo");
    final url = Uri.parse('http://192.168.1.137:8080/auth/register');
    final body = authRequest.toJson();
    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    log(response.body, level: 10);
    return handleResponse(response, (json) {
      return UserMapper.fromJson(json);
    });
  }

  @override
  Future<UserModel> login({required AuthRequest authreRuest}) async {
    final url = Uri.parse('http://192.168.1.137:8080/auth/login');
    final body = authreRuest.toJson();
    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return handleResponse(response, (json) => UserMapper.fromJson(json));
  }
}
