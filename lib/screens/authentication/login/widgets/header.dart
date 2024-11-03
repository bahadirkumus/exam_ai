import 'package:exam_ai/utils/constants/image_paths.dart';
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
        Image(
          height: 150,
          image: AssetImage(
             AppImages.appLogo),
        ),
        Text(AppTexts.loginTitle,
            style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: AppSizes.spaceBtwLabels),
        Text(AppTexts.loginSubTitle,
            style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
