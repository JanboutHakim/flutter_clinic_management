import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:doclib/core/errors/handler.dart';
import 'package:doclib/core/errors/exeptions.dart';
import 'package:doclib/features/auth/data/models/Tokens_response.dart';
import 'package:doclib/features/auth/data/models/model_mapper.dart';
import 'package:doclib/features/auth/data/models/Auth_model.dart';
import 'package:doclib/features/auth/data/models/otp_request_model.dart';
import 'package:doclib/features/auth/data/models/user_model.dart';
import 'package:doclib/features/auth/presentation/bloc/auth_bloc_bloc.dart';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:doclib/core/constants/text_constants.dart' as cons;

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required AuthRequest authrequest});
  Future<TokensResponse> otpVerify({required OtpRequestModel request});
  Future<UserModel> register({required AuthRequest authRequest});
}

class AuthRemoteDataSoureceImpl implements AuthRemoteDataSource {
  final http.Client client;
  AuthRemoteDataSoureceImpl({required this.client});

  Future<TokensResponse> otpVerify({required OtpRequestModel request}) async {
    log("start sending otp verification ");
    final url = Uri.parse('${cons.api}/auth/verify-otp');
    final body = request.toJson();
    late http.Response response;
    try {
      response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        return TokensResponse.fromJson(jsonDecode(response.body));
      } else {
        throw ValidationException();
      }
    } catch (e) {
      throw UnauthorizedException();
    }
  }

  @override
  Future<UserModel> register({required AuthRequest authRequest}) async {
    log("start sending register request ");
    log("auth is${authRequest.toJson().toString()}");
    final url = Uri.parse('${cons.api}/auth/register');
    final body = authRequest.toJson();
    late http.Response response;
    try {
      response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
    } on SocketException {
      throw NetworkException();
    } catch (e) {
      throw ServerException();
    }
    log("status code is ${response.statusCode} res is ${response.body}");
    return handleResponse(response, (json) {
      return UserMapper.fromJson(json);
    });
  }

  @override
  Future<UserModel> login({required AuthRequest authrequest}) async {
    final url = Uri.parse('${cons.api}/auth/login');
    final body = authrequest.toJson();
    late http.Response response;
    try {
      response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
    } on SocketException {
      throw NetworkException();
    }
    return handleResponse(response, (json) => UserMapper.fromJson(json));
  }
}
