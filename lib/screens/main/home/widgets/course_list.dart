import 'package:exam_ai/controllers/main/course_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'course_card.dart';

class CourseList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CourseController controller = Get.put(CourseController());

    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator()); // Yükleniyor göstergesi
      }

      if (controller.courses.isEmpty) {
        return Center(child: Text("Henüz kurs bulunamadı."));
      }

      return SingleChildScrollView(
        child: Column(
          // `controller.courses` listesi üzerinde döngü yapılıyor ve her bir `course` öğesi `CourseCard` widget'ına dönüştürülüyor.
          children: controller.courses.map((course) => CourseCard(course: course)).toList(),
        ),
      );
    });
  }
}
