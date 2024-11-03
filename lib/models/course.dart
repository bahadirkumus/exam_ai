import 'package:flutter/material.dart';

class Course {
  final String docId;
  final String courseId;
  final String title;
  final int progress;
  final Color color;
  final String image;
  final String buttonText;

  Course({
    required this.docId,
    required this.courseId,
    required this.title,
    required this.progress,
    required this.color,
    required this.image,
    required this.buttonText,
  });

  factory Course.fromFirestore(String docId, Map<String, dynamic> data) {
    return Course(
      docId: docId,
      courseId: data['courseId'] ?? 'Unknown Code',
      title: data['title'] ?? 'Unknown Title',
      progress: data['progress'] ?? 0,
      color: _colorFromHex(data['color'] ?? '#000000'),
      image: data['image'] ?? 'default_image_path',
      buttonText: data['buttonText'] ?? 'Start',
    );
  }

  static Color _colorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor"; // Opaklık ekliyoruz (FF = 255)
    }
    return Color(int.parse("0x$hexColor"));
  }
}
