import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms/model/student_model.dart';
import 'package:lms/model/task_model.dart';

class Attachment {
  final String path;
  final String name;
  final bool isImage;

  Attachment({required this.path, required this.name, required this.isImage});
}

class StudentController extends GetxController {
  var attendance = 70.obs;

  final subjects = [
    {
      'name': 'Mathematics',
      'teacher': 'Mr. John',
      'time': '08:00 - 09:00',
      'icon': Icons.calculate,
      'color': const Color.fromARGB(255, 130, 201, 252), // Light color for card
    },
    {
      'name': 'Science',
      'teacher': 'Ms. Anna',
      'time': '09:00 - 10:00',
      'icon': Icons.science,
      'color': const Color.fromARGB(255, 133, 255, 143),
    },
    {
      'name': 'English',
      'teacher': 'Ms. Sarah',
      'time': '10:00 - 11:00',
      'icon': Icons.menu_book,
      'color': const Color.fromARGB(255, 255, 205, 123),
    },
    {
      'name': 'Urdu',
      'teacher': 'Mr. Ali',
      'time': '11:00 - 12:00',
      'icon': Icons.book,
      'color': const Color.fromARGB(255, 238, 146, 252),
    },
    {
      'name': 'Islamiyat',
      'teacher': 'Ms. Fatima',
      'time': '12:00 - 01:00',
      'icon': Icons.account_balance,
      'color': const Color.fromARGB(255, 208, 204, 255),
    },
    // {
    //   'name': 'Break',
    //   'teacher': '',
    //   'time': '01:00 - 01:30',
    //   'icon': Icons.free_breakfast,
    //   'color': Colors.yellow[100],
    // },
    {
      'name': 'Sindhi',
      'teacher': 'Mr. Imran',
      'time': '01:30 - 02:30',
      'icon': Icons.language,
      'color': const Color.fromARGB(255, 149, 213, 221),
    },
    {
      'name': 'Social Studies',
      'teacher': 'Ms. Nadia',
      'time': '02:30 - 03:30',
      'icon': Icons.public,
      'color': const Color.fromARGB(255, 255, 184, 208),
    },
    {
      'name': 'Arts',
      'teacher': 'Mr. Kamran',
      'time': '03:30 - 04:30',
      'icon': Icons.brush,
      'color': const Color.fromARGB(255, 255, 248, 147),
    },
    {
      'name': 'Physics',
      'teacher': 'Mr. Salman',
      'time': '04:30 - 05:30',
      'icon': Icons.science_outlined,
      'color': const Color.fromARGB(255, 153, 165, 235),
    },
    {
      'name': 'Chemistry',
      'teacher': 'Ms. Ayesha',
      'time': '05:30 - 06:30',
      'icon': Icons.biotech,
      'color': const Color.fromARGB(255, 240, 169, 134),
    },
  ];

  // Example timetable data
  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  final List<List<String>> periods = [
    // 8 periods per day
    [
      'Mathematics',
      'Science',
      'English',
      'Urdu',
      'Break',
      'Sindhi',
      'Social Studies',
      'Arts',
    ],
    [
      'Mathematics',
      'Science',
      'English',
      'Islamiyat',
      'Break',
      'Physics',
      'Chemistry',
      'Arts',
    ],
    [
      'Mathematics',
      'English',
      'Urdu',
      'Science',
      'Break',
      'Social Studies',
      'Arts',
      'Physics',
    ],
    [
      'Mathematics',
      'English',
      'Science',
      'Islamiyat',
      'Break',
      'Chemistry',
      'Physics',
      'Arts',
    ],
    [
      'Mathematics',
      'Urdu',
      'Science',
      'English',
      'Break',
      'Sindhi',
      'Arts',
      'Social Studies',
    ],
  ];
  final feesList =
      <FeeModel>[
        FeeModel(
          month: "January",
          amount: 5000,
          dueDate: "1-01-2026",
          isPaid: false,
        ),
        FeeModel(
          month: "December",
          amount: 5000,
          dueDate: "1-12-2025",
          isPaid: false,
        ),
        FeeModel(
          month: "November",
          amount: 5000,
          dueDate: "1-11-2025",
          isPaid: true,
        ),
        FeeModel(
          month: "October",
          amount: 5000,
          dueDate: "1-10-2025",
          isPaid: true,
        ),
      ].obs;
  late Rx<DateTime> selectedDate;

  final events =
      <CalendarEvent>[
        // 🎓 ACADEMIC
        CalendarEvent(date: DateTime(2026, 1, 17), title: "Mid Term Exams"),
        CalendarEvent(date: DateTime(2026, 1, 25), title: "Sports Day"),
        CalendarEvent(date: DateTime(2026, 3, 10), title: "Annual Picnic"),
        CalendarEvent(date: DateTime(2026, 6, 15), title: "Final Exams"),
        CalendarEvent(
          date: DateTime(2026, 7, 1),
          title: "Summer Vacations Start",
        ),

        // 🌍 INTERNATIONAL / GLOBAL DAYS
        CalendarEvent(date: DateTime(2026, 1, 1), title: "New Year’s Day"),
        CalendarEvent(date: DateTime(2026, 3, 8), title: "Women’s Day"),
        CalendarEvent(date: DateTime(2026, 4, 22), title: "Earth Day"),
        CalendarEvent(date: DateTime(2026, 5, 1), title: "Labour Day"),
        CalendarEvent(
          date: DateTime(2026, 6, 5),
          title: "World Environment Day",
        ),
        CalendarEvent(date: DateTime(2026, 8, 12), title: "Youth Day"),
        CalendarEvent(date: DateTime(2026, 10, 5), title: "Teachers’ Day"),
        CalendarEvent(date: DateTime(2026, 12, 10), title: "Human Rights Day"),
        CalendarEvent(date: DateTime(2026, 12, 31), title: "New Year’s Eve"),

        // ❤️ SOCIAL / CULTURAL
        CalendarEvent(date: DateTime(2026, 2, 14), title: "Valentine’s Day"),
        CalendarEvent(date: DateTime(2026, 3, 20), title: "Happiness Day"),
        CalendarEvent(date: DateTime(2026, 6, 21), title: "Yoga Day"),
        CalendarEvent(date: DateTime(2026, 9, 21), title: "Peace Day"),
        // ✝️ CHRISTIANITY
        CalendarEvent(date: DateTime(2026, 12, 25), title: "Christmas Day"),
        CalendarEvent(date: DateTime(2026, 1, 6), title: "Epiphany"),
        CalendarEvent(
          date: DateTime(2026, 4, 3),
          title: "Good Friday",
        ), // moveable
        CalendarEvent(
          date: DateTime(2026, 4, 5),
          title: "Easter Sunday",
        ), // moveable
        // ☪️ ISLAM (Approximate dates for 2026)
        CalendarEvent(date: DateTime(2026, 2, 18), title: "Shab-e-Barat"),
        CalendarEvent(date: DateTime(2026, 3, 19), title: "Start of Ramadan"),
        CalendarEvent(date: DateTime(2026, 4, 18), title: "Eid-ul-Fitr"),
        CalendarEvent(date: DateTime(2026, 6, 7), title: "Hajj Begins"),
        CalendarEvent(date: DateTime(2026, 6, 8), title: "Eid-ul-Adha"),
        CalendarEvent(date: DateTime(2026, 7, 28), title: "Islamic New Year"),
        CalendarEvent(date: DateTime(2026, 9, 16), title: "Eid Milad-un-Nabi"),
        // 🕉️ HINDUISM (Approximate)
        CalendarEvent(date: DateTime(2026, 3, 25), title: "Holi"),
        CalendarEvent(date: DateTime(2026, 8, 17), title: "Raksha Bandhan"),
        CalendarEvent(date: DateTime(2026, 8, 19), title: "Janmashtami"),
        CalendarEvent(date: DateTime(2026, 10, 20), title: "Diwali"),
        CalendarEvent(date: DateTime(2026, 10, 21), title: "Govardhan Puja"),
      ].obs;

  @override
  void onInit() {
    super.onInit();

    final now = DateTime.now();

    // Ensure focusedDay is within calendar range
    selectedDate = Rx<DateTime>(
      now.year < 2023
          ? DateTime(2023, 1, 1)
          : now.year > 2030
          ? DateTime(2030, 12, 31)
          : now,
    );
     _generateMockAttendance();
  }

  // Attendance Logic
  final attendanceHistory = <DateTime, String>{}.obs; // 'P', 'A', 'L'

  void _generateMockAttendance() {
    final now = DateTime.now();
    // Generate for last 3 months
    for (int i = 0; i < 90; i++) {
      final date = now.subtract(Duration(days: i));
      if (date.weekday == 6 || date.weekday == 7) continue; // Skip weekends

      // Random status
      final rand = (date.day + date.month) % 10;
      if (rand < 7) {
        attendanceHistory[DateTime(date.year, date.month, date.day)] = 'P';
      } else if (rand < 9) {
        attendanceHistory[DateTime(date.year, date.month, date.day)] = 'A';
      } else {
        attendanceHistory[DateTime(date.year, date.month, date.day)] = 'L';
      }
    }
    _calculateAttendanceStats();
  }

  String getAttendanceStatus(DateTime date) {
    final key = DateTime(date.year, date.month, date.day);
    return attendanceHistory[key] ?? '';
  }

  var presentPercentage = 0.0.obs;
  var absentPercentage = 0.0.obs;
  var leavePercentage = 0.0.obs;

  void _calculateAttendanceStats() {
    int p = 0;
    int a = 0;
    int l = 0;
    attendanceHistory.forEach((_, status) {
      if (status == 'P') p++;
      else if (status == 'A') a++;
      else if (status == 'L') l++;
    });
    final total = p + a + l;
    if (total > 0) {
      presentPercentage.value = (p / total) * 100;
      absentPercentage.value = (a / total) * 100;
      leavePercentage.value = (l / total) * 100;
      attendance.value = presentPercentage.value.toInt(); // Sync with main dashboard stat
    }
  }

  List<CalendarEvent> getEventsForDate(DateTime date) {
    return events
        .where(
          (e) =>
              e.date.year == date.year &&
              e.date.month == date.month &&
              e.date.day == date.day,
        )
        .toList();
  }

  final examSchedule = [
    {
      'subject': 'Mathematics',
      'date': '10 March 2024',
      'time': '08:00 AM - 10:00 AM',
    },
    {
      'subject': 'Science',
      'date': '12 March 2024',
      'time': '10:30 AM - 12:30 PM',
    },
    {
      'subject': 'English',
      'date': '13 March 2024',
      'time': '09:00 AM - 11:00 AM',
    },
    {'subject': 'Urdu', 'date': '15 March 2024', 'time': '08:30 AM - 10:30 AM'},
    {
      'subject': 'Physics',
      'date': '16 March 2024',
      'time': '11:00 AM - 01:00 PM',
    },
  ];
  final List<String> examRules = [
    'Arrive at least 15 minutes before the exam start time.',
    'Bring your admit card and stationery.',
    'Mobile phones and electronic devices are strictly prohibited.',
    'Follow the seating plan provided by the invigilator.',
    'No talking or cheating during the exam.',
    'Use only authorized calculators and reference materials if allowed.',
    'Maintain silence in the exam hall.',
  ];
  final List<String> subjectsScheduleText = [
    'The weekly timetable shows all subjects for each day.',
    'Each day has 8 periods including a break.',
    'Bring your books and copies according to the time table.',
    'Bring your identity card when coming to school.',
    'Scroll horizontally to view all subjects if they overflow the screen.',
  ];
  final List<String> examsScheduleText = [
    'The exams timetable lists all exams per day.',
    'Some days may have no exams and some may have consecutive exams.',
    'Exam timings are clearly mentioned.',
    'Arrive early for exams to avoid delays.',
    'Follow the exam hall rules strictly.',
    'Scroll horizontally or vertically to see the full timetable.',
  ];

  var tasks = <TaskModel>[
    TaskModel(
      id: '1',
      subjectName: 'Mathematics',
      title: 'Algebra Review',
      description: 'Solve exercises 1-10 from Chapter 3 regarding Linear Equations.',
      dueDate: DateTime.now().add(const Duration(days: 2)),
      documentUrl: 'math_worksheet.pdf',
    ),
    TaskModel(
      id: '2',
      subjectName: 'Mathematics',
      title: 'Geometry Project',
      description: 'Submit your geometry project report including diagrams.',
      dueDate: DateTime.now().subtract(const Duration(days: 1)),
      status: 'Pending',
    ),
     TaskModel(
      id: '3',
      subjectName: 'Science',
      title: 'Lab Report',
      description: 'Write a report on the photosynthesis experiment.',
      dueDate: DateTime.now().add(const Duration(days: 5)),
    ),
    TaskModel(
      id: '4',
      subjectName: 'English',
      title: 'Essay Writing',
      description: 'Write a 500-word essay on "Climate Change".',
      dueDate: DateTime.now().add(const Duration(days: 3)),
    ),
  ].obs;


  // Submission State
  var attachedFiles = <Attachment>[].obs;
  var isSubmitting = false.obs;

  void resetSubmission() {
    attachedFiles.clear();
    isSubmitting.value = false;
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      attachedFiles.add(
        Attachment(path: image.path, name: image.name, isImage: true),
      );
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final file = result.files.single;
      final isImage = [
        'jpg',
        'jpeg',
        'png',
        'webp',
      ].contains(file.extension?.toLowerCase());

      attachedFiles.add(
        Attachment(
          path: file.path ?? '',
          name: file.name,
          isImage: isImage,
        ),
      );
    }
  }

  void removeAttachment(int index) {
    attachedFiles.removeAt(index);
  }

  Future<void> submitAssignment(TaskModel task) async {
    if (attachedFiles.isEmpty) {
      Get.snackbar(
        'Attention',
        'Please attach at least one file or image before submitting.',
        backgroundColor: Colors.orange.shade100,
        colorText: Colors.orange.shade900,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    isSubmitting.value = true;

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    final index = tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      tasks[index].status = 'Submitted';
      tasks.refresh();
      
      isSubmitting.value = false;
      Get.back(); // Close screen
      Get.snackbar(
        'Success',
        '${task.title} has been submitted successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    } else {
       isSubmitting.value = false;
       Get.snackbar('Error', 'Task not found');
    }
  }

  // Deprecated usage kept for compatibility if needed, but submitAssignment replaces this flow
  bool submitTask(String taskId) {
    final index = tasks.indexWhere((t) => t.id == taskId);
    if (index != -1) {
      tasks[index].status = 'Submitted';
      tasks.refresh();
      return true;
    }
    return false;
  }

  List<TaskModel> getTasksForSubject(String subjectName) {
    return tasks.where((t) => t.subjectName == subjectName).toList();
  }

  void openSubjects() {
    Get.snackbar('Subjects', 'Navigate to all subjects screen');
  }

  void openExams() {
    Get.snackbar('Exams', 'Navigate to exam timetable');
  }
}
