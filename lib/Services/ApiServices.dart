import 'dart:convert';
import 'dart:developer';

import 'package:notes_app/Models/PersonModel.dart';
import 'package:notes_app/Services/NetworkServices.dart';

import '../Url/url.dart';

class ApiService {
  final NetworkService networkService = NetworkService();

  Future<List<PersonModel>?> getAllPersonsServices() async {
    try {
      final res = await networkService.getApiConnection(
        url: ApiUrl.formEndpoint,
      );
      log(res);
      // return personModelFromJson(jsonEncode(res));
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
        url: ApiUrl.formEndpoint,
        params: params,
      );
      return personModelFromJson(jsonEncode(res));
    } catch (e) {
      log("getPersonsServices $e");
      rethrow;
    }
  }

  Future<List<PersonModel>?> createPersonServices(
    List<Map<String, dynamic>> params,
  ) async {
    try {
      dynamic res = await networkService.postApiConnection(
        url: ApiUrl.formEndpoint,
        params: params,
      );
      return personModelFromJson(jsonEncode(res));
    } catch (e) {
      log("createPersonServices $e");
      rethrow;
    }
  }

  Future<List<PersonModel>?> updatePersonServices(
    List<Map<String, dynamic>> params,
  ) async {
    try {
      dynamic res = await networkService.postApiConnection(
        url: ApiUrl.formEndpoint,
        params: params,
      );
      return personModelFromJson(jsonEncode(res));
    } catch (e) {
      log("updatePersonServices $e");
      rethrow;
    }
  }

  Future<List<PersonModel>?> deletePersonServices(
    List<Map<String, dynamic>> params,
  ) async {
    try {
      dynamic res = await networkService.postApiConnection(
        url: ApiUrl.formEndpoint,
        params: params,
      );
      return personModelFromJson(jsonEncode(res));
    } catch (e) {
      log("deletePersonServices $e");
      rethrow;
    }
  }
}
