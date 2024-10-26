import 'package:exam_ai/utils/constants/sizes.dart';
import 'package:exam_ai/utils/constants/text_string.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.appName, style: Theme.of(context).textTheme.headlineMedium,),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppTexts.welcomeTitle, style: Theme.of(context).textTheme.titleLarge,),
            Text(AppTexts.welcomeSubTitle, style: Theme.of(context).textTheme.bodyMedium,),
          ],
        ),
      ),
    );
  }
}
