import 'package:exam_ai/models/question_model.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class TestController extends GetxController {
  Rxn<TestModel> testModel = Rxn<TestModel>(); // Rxn<T> ile nullable yapıldı
  int currentIndex = 0;
  Map<int, int> userAnswers = {}; // Soru indeksine göre kullanıcı cevapları
  Timer? _timer;
  int timeLeft = 0;

  Future<void> fetchTest(String testId) async {
    try {
      final doc = await FirebaseFirestore.instance.collection('test').doc(testId).get();

      // Null kontrolü ekliyoruz
      if (doc.data() == null) {
        // Test verisi bulunamadıysa boş bir TestModel atayabiliriz veya hata gösterebiliriz.
        Get.snackbar("Hata", "Test verisi bulunamadı");
        return;
      }

      // Veriyi testModel'e atıyoruz
      testModel.value = TestModel.fromMap(doc.data()!);
      timeLeft = testModel.value!.duration;
      _startTimer();
    } catch (e) {
      print("Error fetching test: $e");
      Get.snackbar("Hata", "Bir hata oluştu. Lütfen tekrar deneyin.");
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        timeLeft--;
        update();
      } else {
        _timer?.cancel();
        _showFinishDialog();
      }
    });
  }

  void _showFinishDialog() {
    Get.defaultDialog(
      title: "Test Bitti",
      middleText: "Test süresi doldu.",
      onConfirm: () {
        Get.back();
        Get.back();
      },
      textConfirm: "Tamam",
    );
  }

  void selectAnswer(int index) {
    userAnswers[currentIndex] = index;
    update();
  }

  void nextQuestion() {
    if (currentIndex < testModel.value!.questions.length - 1) {
      currentIndex++;
      update();
    }
  }

  void previousQuestion() {
    if (currentIndex > 0) {
      currentIndex--;
      update();
    }
  }

  void showExitDialog() {
    Get.defaultDialog(
      title: "Testten Çık",
      middleText: "Cevaplanmış sorular kaydedilecek. Testten çıkmak istediğinizden emin misiniz?",
      onCancel: () {},
      onConfirm: () {
        Get.back();
        Get.back();
      },
      textConfirm: "Evet",
      textCancel: "Hayır",
    );
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
