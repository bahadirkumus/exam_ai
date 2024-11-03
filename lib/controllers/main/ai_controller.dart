import 'package:exam_ai/controllers/authentication/env_controller.dart';
import 'package:flutter/physics.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AIController extends GetxController {
  final String apiKey = Env.apiKey;
  var messages = <Map<String, String>>[].obs;

  Future<String> generateAnswer(String question) async {
    try {
      final model = GenerativeModel(
        model: 'tunedModels/respiratorysystem2-t27oo2x72k1e',
        apiKey: apiKey,
      );

      final content = [Content.text(question)];
      final response = await model.generateContent(content);

      return response.text ?? 'Yanıt alınamadı, lütfen tekrar deneyiniz.';
    } catch (e) {
      print("Hata oluştu: $e");
      return 'Hata oluştu: $e';
    }
  }
}
