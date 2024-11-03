class QuestionModel {
  String questionText;
  List<String> options;
  int correctAnswerIndex;

  QuestionModel({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      questionText: map['questionText'] ?? '',
      options: List<String>.from(map['options'] ?? []),
      correctAnswerIndex: map['correctAnswerIndex'] ?? -1,
    );
  }
}

class TestModel {
  String title;
  int duration; // in seconds
  List<QuestionModel> questions;

  TestModel({
    required this.title,
    required this.duration,
    required this.questions,
  });

  factory TestModel.fromMap(Map<String, dynamic> map) {
    return TestModel(
      title: map['title'] ?? 'Untitled Test',
      duration: map['duration'] ?? 300,
      questions: (map['questions'] as List<dynamic>?)
          ?.map((q) => QuestionModel.fromMap(q as Map<String, dynamic>))
          .toList() ??
          [], // Eğer `questions` null ise boş liste
    );
  }
}

class ExamModel {
  final String docId; // Belge ID'sini saklamak için
  final String courseId;
  final String title;
  final String date;

  ExamModel({
    required this.docId,
    required this.courseId,
    required this.title,
    required this.date,
  });

  // Firestore belgesinden model oluşturmak için bir factory metodu
  factory ExamModel.fromFirestore(String docId, Map<String, dynamic> data) {
    return ExamModel(
      docId: docId, // Belge ID'si
      courseId: data['courseId'] ?? 'Unknown Course',
      title: data['title'] ?? 'Bilinmeyen Sınav',
      date: data['date'] ?? 'Bilinmeyen Tarih',
    );
  }
}

