import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentController extends GetxController {
  var attendance = 70.obs;

  final subjects = [
    {
      'name': 'Mathematics',
      'teacher': 'Mr. John',
      'time': '08:00 - 09:00',
      'icon': Icons.calculate,
    },
    {
      'name': 'Science',
      'teacher': 'Ms. Anna',
      'time': '09:00 - 10:00',
      'icon': Icons.science,
    },
  ];

  void openSubjects() {
    Get.snackbar('Subjects', 'Navigate to all subjects screen');
  }

  void openExams() {
    Get.snackbar('Exams', 'Navigate to exam timetable');
  }
}
