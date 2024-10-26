import 'package:exam_ai/common/popups/loader.dart';
import 'package:exam_ai/common/popups/popups.dart';
import 'package:exam_ai/repository/authentication/authentication_repository.dart';
import 'package:exam_ai/utils/constants/image_paths.dart';
import 'package:exam_ai/utils/helpers/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  NetworkManager NetworkManager_ = Get.put(NetworkManager());
  AuthenticationRepository AuthenticationRepository_ = Get.put(AuthenticationRepository());

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  Future<void> loginWithEmailAndPassword() async {
    try {
      // start loading
      Loader.startLoading(
          "Giriş Yapılıyor...", AppImages.loading);

      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        Loader.stopLoading();
        return;
      }

      // Validate form
      if (!loginFormKey.currentState!.validate()) {
        Loader.stopLoading();
        return;
      }

      // Save data if remember me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Login with email & password
      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Stop loading
      Loader.stopLoading();

      // redirect to the appropriate screen
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      Loader.stopLoading();
      AppPopups.errorSnackBar(title: 'Hata!', message: e.toString());
    }
  }
}