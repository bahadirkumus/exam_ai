import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_ai/models/user_model.dart';
import 'package:exam_ai/utils/exceptions/firebase_exception.dart';
import 'package:exam_ai/utils/exceptions/format_exception.dart';
import 'package:exam_ai/utils/exceptions/platform_exception.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save user
  Future<void> saveUser(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AppFormatException();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw "Bir hata ile karşılaşıldı. Err: 20001";
    }
  }
}