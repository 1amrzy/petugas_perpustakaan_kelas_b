import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:petugas_perpustakaan_kelas_b/app/data/constant/endpoint.dart';
import 'package:petugas_perpustakaan_kelas_b/app/data/provider/api_provider.dart';
import 'package:petugas_perpustakaan_kelas_b/app/data/provider/storage_provider.dart';
import 'package:petugas_perpustakaan_kelas_b/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final loading = false.obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    //cek status login jika sudah login akan di direct menu home
    String status = StorageProvider.read(StorageKey.status);
    log("status : $status");
      if(status == "logged"){
      Get.offAllNamed(Routes.HOME);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  login() async{
    loading(true);
    try{
      FocusScope.of(Get.context!).unfocus();
      formkey.currentState?.save();
      if (formkey.currentState!.validate()){
        final response = await ApiProvider.instance().post(Endpoint.login,
        data: dio.FormData.fromMap(
          {"username": usernameController.text.toString(), "password": passwordController.text.toString()}));
        if (response.statusCode == 200) {
          await StorageProvider.write(StorageKey.status, "logged");
          Get.offAllNamed(Routes.HOME);
        }else {
          Get.snackbar("Sorry", "Failed to Login", backgroundColor: Colors.orange);
        }
      }loading(false);
    }on dio.DioException catch (e){
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          Get.snackbar("Sorry", "${e.response?.data['message']}", backgroundColor: Colors.orange);
          }
        }else{
        Get.snackbar("Sorry", "${e.response?.data['message']}", backgroundColor: Colors.red);
      }
    } catch (e) {loading(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }
}
