import 'package:exam_ai/common/style/register_spacing_style.dart';
import 'package:exam_ai/screens/authentication/login/widgets/form.dart';
import 'package:exam_ai/screens/authentication/login/widgets/header.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: AppSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LoginHeader(),
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
