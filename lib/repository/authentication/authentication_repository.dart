import 'package:exam_ai/screens/authentication/login/login.dart';
import 'package:exam_ai/screens/main/home/home.dart';
import 'package:exam_ai/utils/exceptions/firebase_auth_exception.dart';
import 'package:exam_ai/utils/exceptions/firebase_exception.dart';
import 'package:exam_ai/utils/exceptions/format_exception.dart';
import 'package:exam_ai/utils/exceptions/platform_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;

  screenRedirect() async {
    final user = _auth.currentUser;

    if (user != null) {
      Get.offAll(() => HomeScreen());
    }
  }

  // Login
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AppFormatException();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw "Bir hata ile karşılaşıldı! Err: 10001";
    }
  }
}
