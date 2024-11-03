import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String department;
  String grade;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.department,
    required this.grade,
  });

  String get fullName => "$firstName $lastName";

  static UserModel empty() => UserModel(
        id: "",
        firstName: "",
        lastName: "",
        email: "",
        phoneNumber: "",
        department: "",
        grade: "",
      );

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phoneNumber": phoneNumber,
      "department": department,
      "grade": grade,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data["firstName"] ?? "",
        lastName: data["lastName"] ?? "",
        email: data["email"] ?? "",
        phoneNumber: data["phoneNumber"] ?? "",
        department: data["department"] ?? "",
        grade: data["grade"] ?? "",
      );
    }
    return UserModel.empty();
  }
}
