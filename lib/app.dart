import 'package:exam_ai/screens/authentication/login/login.dart';
import 'package:exam_ai/screens/main/home/home.dart';
import 'package:exam_ai/utils/constants/text_string.dart';
import 'package:exam_ai/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExamAIApp extends StatelessWidget {
  const ExamAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppTexts.appName,
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
