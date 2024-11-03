import 'package:exam_ai/controllers/main/course_details_controller.dart';
import 'package:exam_ai/models/question_model.dart';
import 'package:exam_ai/screens/main/questions/questions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CourseDetails extends StatelessWidget {
  final String courseId;

  CourseDetails({required this.courseId});

  @override
  Widget build(BuildContext context) {
    // Controller'ı GetX üzerinden başlatıyoruz
    final controller = Get.put(CourseDetailsController(courseId));

    return Scaffold(
      appBar: AppBar(
        title: Text(courseId),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Çıkmış Sorular",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            // Veriyi dinleyerek UI'yi güncelleyen Obx widget'ı
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator()); // Yükleniyor göstergesi
                }

                if (controller.exams.isEmpty) {
                  return Center(child: Text("Bu kurs için sınav bulunamadı."));
                }

                // Sınavları liste halinde gösterme
                return ListView.builder(
                  itemCount: controller.exams.length,
                  itemBuilder: (context, index) {
                    final ExamModel exam = controller.exams[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Material(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            // `docId` ile TestScreen'e yönlendirme
                            Get.to(() => TestScreen(testId: exam.docId));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 24.0),
                            child: Text(
                              exam.title, // ExamModel'den title alınıyor
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
