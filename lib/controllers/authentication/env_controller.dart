import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Env {
  static String apiKey = '';

  static Future<void> load() async {
    final jsonString = await rootBundle.loadString('assets/env.json');
    final jsonData = json.decode(jsonString);
    apiKey = jsonData['api_key'];
  }
}
