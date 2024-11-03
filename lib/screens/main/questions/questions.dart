import 'package:exam_ai/controllers/main/question_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestScreen extends StatelessWidget {
  final String testId;

  TestScreen({required this.testId});

  @override
  Widget build(BuildContext context) {
    final TestController controller = Get.put(TestController());

    // Test verilerini Firebase'den yükle
    controller.fetchTest(testId);

    return Scaffold(
      backgroundColor: Colors.purple[200],
      appBar: AppBar(
        // Başlık için testModel null kontrolü
        title: Obx(() {
          return Text(
            controller.testModel.value?.title ?? "Yükleniyor...",
          );
        }),
        actions: [
          GetBuilder<TestController>(
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "${(controller.timeLeft ~/ 60).toString().padLeft(2, '0')}:${(controller.timeLeft % 60).toString().padLeft(2, '0')}",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: GetBuilder<TestController>(
        builder: (controller) {
          // Eğer testModel null ise yükleniyor göstergesi
          if (controller.testModel.value == null) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.testModel.value!.questions.isEmpty) {
            return Center(child: Text("Sorular bulunamadı."));
          }

          final question = controller.testModel.value!.questions[controller.currentIndex];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        question.questionText,
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Yukarıdaki sorunun cevapları aşağıdakilerden hangisidir?",
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ...List.generate(question.options.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black, backgroundColor: controller.userAnswers[controller.currentIndex] == index
                            ? Colors.blue
                            : Colors.white,
                      ),
                      onPressed: () {
                        controller.selectAnswer(index);
                      },
                      child: Text("A) ${question.options[index]}"),
                    ),
                  );
                }),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: controller.currentIndex > 0
                          ? controller.previousQuestion
                          : null,
                    ),
                    ElevatedButton(
                      onPressed: controller.showExitDialog,
                      child: Text("Durumu Gör"),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: controller.currentIndex < controller.testModel.value!.questions.length - 1
                          ? controller.nextQuestion
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
