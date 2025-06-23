import 'dart:convert';
import 'package:doclib/core/constants/text_constants.dart' as cons;
import 'package:doclib/core/errors/exeptions.dart';
import 'package:doclib/features/drugs/data/models/drug_common_model.dart';
import 'package:doclib/features/drugs/data/models/drug_model.dart';
import 'package:http/http.dart' as http;

abstract class DrugRemoteDataSource {
  Future<DrugModel> getDrugById({required int drugId});
  Future<List<DrugCommonModel>> getAllDrugs();
  Future<List<DrugModel>> getPatientDrugs({required int id});
  Future<DrugModel> createDrug({required DrugModel drugmodel});
}

class DrugRemoteDataSourceImpl implements DrugRemoteDataSource {
  final http.Client client;

  const DrugRemoteDataSourceImpl(this.client);
  @override
  Future<DrugModel> createDrug({required DrugModel drugmodel}) {
    // TODO: implement creatDrug
    throw UnimplementedError();
  }

  @override
  Future<DrugModel> getDrugById({required int drugId}) {
    // TODO: implement getDrugById
    throw UnimplementedError();
  }

  @override
  Future<List<DrugCommonModel>> getAllDrugs() async {
    final api = cons.api;
    final url = Uri.parse("$api/drugs");
    late http.Response response;
    try {
      response = await client.get(url);
      final List<dynamic> decodedJson = jsonDecode(response.body);
      return decodedJson.map((e) => DrugCommonModel.fromJson(e)).toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<DrugModel>> getPatientDrugs({required int id}) {
    // TODO: implement getPateintDrugs
    throw UnimplementedError();
  }
}

// void main() async {
//   try {
//     final http.Client client = http.Client();
//     final api = cons.api;
//     final url = Uri.parse("$api/drugs");
//     print(url.toString());
//     final res = await client.get(url);
//     final String a = jsonDecode(res.body).toString();
//     print(a);
//   } catch (e) {
//     log("${e.runtimeType}");
//     throw Exception();
//   }
// }
