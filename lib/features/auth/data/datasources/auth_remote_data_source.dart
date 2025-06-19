import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:doclib/core/errors/handler.dart';
import 'package:doclib/core/errors/exeptions.dart';
import 'package:doclib/features/auth/data/models/model_mapper.dart';
import 'package:doclib/features/auth/data/models/Auth_model.dart';
import 'package:doclib/features/auth/data/models/user_model.dart';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:doclib/core/constants/text_constants.dart' as cons;

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
    log("auth is${authRequest.toJson().toString()}");
    // print("fofofofofofofofofofofo");
    // if (!await NetworkChecker.isConnected) {
    //   throw NetworkException();
    // }
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
    }
    // final data = {
    //   "id": "20",
    //   "username": "jojo",
    //   "password": "09546132465",
    //   "name": "hajradwan",
    //   "email": "gogo",
    //   "phoneNumber": "3543035430384",
    //   "DOB": "${DateTime.now()}",
    //   "role": "PATIENT",
    //   "gender": "MALE",
    //   "patient": {"address": "halab"},
    //   "doctor": "null",
    // };
    // final jsondata = jsonEncode(data);
    // // debugPrint(jsondata);
    // http.Response response = http.Response(jsondata, 200);
    // log(response.body);
    log("status code is ${response.statusCode} res is ${response.body}");
    return handleResponse(response, (json) {
      return UserMapper.fromJson(json);
    });
  }

  @override
  Future<UserModel> login({required AuthRequest authreRuest}) async {
    // if (!await NetworkChecker.isConnected) {
    //   throw NetworkException();
    // }
    final url = Uri.parse('${cons.api}/auth/login');
    final body = authreRuest.toJson();
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
