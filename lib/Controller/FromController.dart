import 'dart:developer';

import 'package:get/get.dart';
import 'package:notes_app/Models/PersonModel.dart';
import 'package:notes_app/Services/ApiServices.dart';

class FormController extends GetxController {
  final ApiService apiService = ApiService();

  var isLoading = false.obs;
  RxList<PersonModel> personData = <PersonModel>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getAllPersonList() async {
    isLoading.value = true;

    try {
      var response = await apiService.getAllPersonsServices();
      if (response != null) {
        // personData.assignAll(response);
        isLoading.value = false;
      }
    } catch (e) {
      log("error in getAllPersonList controller ");
    }
  }

  Future<void> createPerson() async {
    isLoading.value = true;
    var params = [
      {"Com": "1"},
    ];
    try {
      var response = await apiService.createPersonServices(params);
      if (response != null) {
        personData.assignAll(response);
        isLoading.value = false;
      }
    } catch (e) {
      log("error in addPerson controller ");
    }
  }

  Future<void> updatePerson() async {
    isLoading.value = true;
    var params = [
      {"Com": "1"},
    ];
    try {
      var response = await apiService.updatePersonServices(params);
      if (response != null) {
        personData.assignAll(response);
        isLoading.value = false;
      }
    } catch (e) {
      log("error in updatePerson controller ");
    }
  }

  Future<void> deletePerson() async {
    isLoading.value = true;
    var params = [
      {"Com": "1"},
    ];
    try {
      var response = await apiService.deletePersonServices(params);
      if (response != null) {
        personData.assignAll(response);
        isLoading.value = false;
      }
    } catch (e) {
      log("error in deletePerson controller ");
    }
  }
}
