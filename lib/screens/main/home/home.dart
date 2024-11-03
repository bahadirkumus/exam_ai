import 'package:exam_ai/screens/main/home/course_details.dart';
import 'package:exam_ai/screens/main/home/widgets/course_list.dart';
import 'package:exam_ai/utils/constants/image_paths.dart';
import 'package:exam_ai/utils/constants/sizes.dart';
import 'package:exam_ai/utils/constants/text_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.appName, style: Theme.of(context).textTheme.headlineMedium,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppTexts.welcomeTitle, style: Theme.of(context).textTheme.titleLarge,),
              Text(AppTexts.welcomeSubTitle, style: Theme.of(context).textTheme.bodyMedium,),
              SizedBox(height: AppSizes.spaceBtwItems,),
              CourseList(),
            ],
          ),
        ),
      ),
    );
  }
}
