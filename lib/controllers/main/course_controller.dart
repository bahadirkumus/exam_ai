import 'package:exam_ai/models/course.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseController extends GetxController {
  var courses = <Course>[].obs; // `Course` tipinde liste
  var isLoading = true.obs; // Yükleniyor durumu

  @override
  void onInit() {
    super.onInit();
    fetchCourses();
  }

  // Firestore'dan course verilerini çekme fonksiyonu
  Future<void> fetchCourses() async {
    try {
      isLoading(true);
      final querySnapshot = await FirebaseFirestore.instance
          .collection('course')
          .get();

      courses.value = querySnapshot.docs.map((doc) {
        return Course.fromFirestore(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print("Error fetching courses: $e");
    } finally {
      isLoading(false);
    }
  }
}
