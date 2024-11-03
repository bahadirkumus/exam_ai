import 'package:exam_ai/common/popups/loader.dart';
import 'package:exam_ai/common/popups/popups.dart';
import 'package:exam_ai/models/user_model.dart';
import 'package:exam_ai/repository/authentication/authentication_repository.dart';
import 'package:exam_ai/repository/authentication/user_repository.dart';
import 'package:exam_ai/screens/authentication/login/login.dart';
import 'package:exam_ai/utils/constants/image_paths.dart';
import 'package:exam_ai/utils/helpers/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final hidePassword = true.obs;
  final privacyPolicy = false.obs;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  RxString grade = ''.obs;
  RxString department = ''.obs;
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  void signup() async {
    try {
      // Start loading
      Loader.startLoading(
          "Kayıt Yapılıyor...", AppImages.loading);

      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        Loader.stopLoading();
        return;
      }

      // Validate form
      if (!signupFormKey.currentState!.validate()) {
        Loader.stopLoading();
        return;
      }

      // Privacy policy check
      if (!privacyPolicy.value) {
        Loader.stopLoading();
        AppPopups.warningSnackBar(
          title: "Accept the Privacy Agreement.",
          message: "In order for us to complete your membership process, you must accept the privacy policy.",
        );
        return;
      }

      // Register user in the Firebase Auth
      final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Save user data in Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        department: department.value.trim(),
        grade: grade.value.trim(),
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUser(newUser);

      // Remove loader
      Loader.stopLoading();

      Get.offAll(() => LoginScreen());

      // Show success message
      AppPopups.successSnackBar(title: "Harika!", message: "Hesabınız oluşturuldu. Şimdi giriş yapabilirsiniz!");

    } catch(e) {
      Loader.stopLoading();
      // Show error message
      AppPopups.errorSnackBar(title: 'Hata!', message: e.toString());
    }
  }
}
