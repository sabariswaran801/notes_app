import 'dart:convert';
import 'dart:developer';

import 'package:notes_app/Models/PersonModel.dart';
import 'package:notes_app/Services/NetworkServices.dart';

import '../Url/url.dart';

class ApiService {
  final NetworkService networkService = NetworkService();

  Future<List<PersonModel>?> getAllPersonsServices() async {
    try {
      dynamic res = await networkService.getApiConnection(url: "");
      // log("wfsdgfdg$res");
      final jsonData = personModelFromJson(jsonEncode(res));
      return jsonData;
    } catch (e) {
      log("getAllPersonsServices $e");
      rethrow;
    }
  }

  Future<List<PersonModel>?> getPersonServices(
    List<Map<String, dynamic>> params,
  ) async {
    try {
      dynamic res = await networkService.postApiConnection(
        url: "",
        params: params,
      );
      return personModelFromJson(jsonEncode(res));
    } catch (e) {
      log("getPersonsServices $e");
      rethrow;
    }
  }

  Future<dynamic> createPersonServices(Map<String, dynamic> params) async {
    try {
      dynamic res = await networkService.postApiConnection(
        url: "",
        params: params,
      );
      return res;
    } catch (e) {
      log("createPersonServices $e");
      rethrow;
    }
  }

  Future<dynamic> updatePersonServices(Map<String, dynamic> params, id) async {
    try {
      final dynamic res = await networkService.putApiConnection(
        url: "/$id",
        params: params,
      );

      return res;
    } catch (e, stackTrace) {
      log("updatePersonServices error: $e\n$stackTrace");
      rethrow;
    }
  }

  Future<dynamic> deletePersonServices(id) async {
    try {
      dynamic res = await networkService.deleteApiConnection(url: "/$id");
      return res;
    } catch (e) {
      log("deletePersonServices $e");
      rethrow;
    }
  }
}
