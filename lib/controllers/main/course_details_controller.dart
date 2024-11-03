import 'package:exam_ai/models/question_model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseDetailsController extends GetxController {
  final String courseId;
  var exams = <ExamModel>[].obs; // ExamModel tipinde sınav listesi
  var isLoading = true.obs; // Yükleme durumunu takip etmek için

  CourseDetailsController(this.courseId);

  @override
  void onInit() {
    super.onInit();
    fetchExams();
  }

  // Firestore'dan sınavları çekme fonksiyonu
  Future<void> fetchExams() async {
    try {
      isLoading(true);
      // Firestore'dan `test` koleksiyonundan courseId'ye göre filtrelenmiş veriyi çekiyoruz
      final querySnapshot = await FirebaseFirestore.instance
          .collection('test')
          .where('courseId', isEqualTo: courseId)
          .get();

      // Gelen veriyi ExamModel listesine dönüştürüp exams listesine ekliyoruz
      exams.value = querySnapshot.docs
          .map((doc) => ExamModel.fromFirestore(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error fetching exams: $e");
    } finally {
      isLoading(false); // Yükleme durumunu kapatıyoruz
    }
  }
}
