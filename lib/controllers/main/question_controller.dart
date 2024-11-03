import 'dart:async';
import 'package:exam_ai/controllers/main/ai_controller.dart';
import 'package:exam_ai/models/question_model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TestController extends GetxController {
  Rxn<TestModel> testModel = Rxn<TestModel>();
  int currentIndex = 0;
  Map<int, int> userAnswers = {}; // Soru indeksine göre kullanıcı cevapları
  Timer? _timer;
  int timeLeft = 0;
  String? apiAnswer; // API'den gelen cevabı tutar

  final AIController aiController = Get.put(AIController()); // AIController'ı başlatıyoruz

  Future<void> fetchTest(String testId) async {
    try {
      final doc = await FirebaseFirestore.instance.collection('test').doc(testId).get();

      if (doc.data() == null) {
        Get.snackbar("Hata", "Test verisi bulunamadı");
        return;
      }

      testModel.value = TestModel.fromMap(doc.data()!);
      timeLeft = testModel.value!.duration;
      _startTimer();
      update();
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

  // Kullanıcı bir seçeneği işaretlediğinde çağrılacak fonksiyon
  void selectAnswer(int index) {
    userAnswers[currentIndex] = index;
    update();

    // Yanlış cevap verildiyse AIController'ı kullanarak API'ye sor
    if (!isAnswerCorrect(currentIndex)) {
      fetchAIAnswer(testModel.value!.questions[currentIndex].questionText, testModel.value!.questions[currentIndex].options,);
    }
  }

  // Kullanıcının verdiği cevabın doğru olup olmadığını kontrol eden fonksiyon
  bool isAnswerCorrect(int questionIndex) {
    if (!userAnswers.containsKey(questionIndex)) return false;
    return userAnswers[questionIndex] == testModel.value!.questions[questionIndex].correctAnswerIndex;
  }

  // Yanlış cevaplanan soruyu AI API'ye gönderip cevap almak için işlev
  Future<void> fetchAIAnswer(String questionText, List<String> options) async {
    // Soru ve seçenekleri birleştiriyoruz
    String prompt = "$questionText\nSeçenekler:\n";
    for (int i = 0; i < options.length; i++) {
      prompt += "${String.fromCharCode(65 + i)}) ${options[i]}\n"; // A, B, C, D gibi
    }

    // API'den yanıt alıyoruz
    apiAnswer = await aiController.generateAnswer(prompt);
    update();
  }


  void nextQuestion() {
    if (currentIndex < testModel.value!.questions.length - 1) {
      currentIndex++;
      apiAnswer = null; // Yeni soruya geçerken API cevabını temizle
      update();
    }
  }

  void previousQuestion() {
    if (currentIndex > 0) {
      currentIndex--;
      apiAnswer = null; // Yeni soruya geçerken API cevabını temizle
      update();
    }
  }

  void showExitDialog() {
    Get.defaultDialog(
      title: "Testten Çık",
      middleText: "Cevaplanmış sorular kaydedilecek. Testten çıkmak istediğinizden emin misiniz?",
      onCancel: () {},
      onConfirm: () {
        Get.back(); // Çıkış onaylandığında geçerli sayfadan çık
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
