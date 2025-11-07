import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:notes_app/Models/PersonModel.dart';
import 'package:notes_app/Services/ApiServices.dart';

class FormController extends GetxController {
  final ApiService apiService = ApiService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  RxString gender = 'Male'.obs;
  RxString? qualification = "".obs;
  var isLoading = false.obs;
  final RxList<PersonModel> personData = <PersonModel>[].obs;

  Future<void> getAllPersonList() async {
    isLoading.value = true;

    try {
      var response = await apiService.getAllPersonsServices();
      if (response != null) {
        // log("$response");
        personData.assignAll(response);
        isLoading.value = false;
      }
    } catch (e) {
      log("error in getAllPersonList controller ");
    }
  }

  Future<void> createPerson(skills) async {
    isLoading.value = true;
    var params = {
      "fullName": nameController.text,
      "dob": dobController.text,
      "gender": gender.value,
      "qualification": qualification?.value,
      "skills": skills,
    };

    try {
      var response = await apiService.createPersonServices(params);
      if (response != null) {
        final message = response['message'];
        // Get.back();
        getAllPersonList();
        isLoading.value = false;
        Get.back();
        Fluttertoast.showToast(msg: message);
      }
    } catch (e) {
      log("error in addPerson controller ");
    }
  }

  Future<void> updatePerson(id, skills) async {
    var params = {
      "fullName": nameController.text,
      "dob": dobController.text,
      "gender": gender.value,
      "qualification": qualification?.value,
      "skills": skills,
    };
    try {
      var response = await apiService.updatePersonServices(params, id);
      if (response != null) {
        final message = response['message'];
        getAllPersonList();
        // Get.back();
        Get.back();
        Fluttertoast.showToast(msg: message);
      }
    } catch (e) {
      log("error in updatePerson controller ");
    }
  }

  Future<void> deletePerson(id) async {
    try {
      var response = await apiService.deletePersonServices(id);
      if (response != null) {
        final message = response['message'];
        // Get.back();
        getAllPersonList();
        Fluttertoast.showToast(msg: message);
      }
    } catch (e) {
      log("error in deletePerson controller ");
    }
  }
}
