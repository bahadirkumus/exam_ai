import 'package:exam_ai/utils/constants/sizes.dart';
import 'package:exam_ai/utils/constants/text_string.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppTexts.loginTitle,
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: AppSizes.spaceBtwLabels),
        Text(AppTexts.loginSubTitle,
            style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
