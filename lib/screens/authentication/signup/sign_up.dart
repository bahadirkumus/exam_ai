import 'package:exam_ai/screens/authentication/signup/widgets/form.dart';
import 'package:exam_ai/screens/authentication/signup/widgets/header.dart';
import 'package:exam_ai/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SignUpHeader(),
              SignUpForm(),
            ],
          ),
        ),
      ),
    );
  }
}
