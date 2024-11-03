import 'package:exam_ai/utils/constants/sizes.dart';
import 'package:exam_ai/utils/constants/text_string.dart';
import 'package:flutter/material.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppTexts.signUpTitle,
            style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: AppSizes.spaceBtwLabels),
        Text(AppTexts.signUpSubTitle,
            style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: AppSizes.spaceBtwSections),
      ],
    );
  }
}
