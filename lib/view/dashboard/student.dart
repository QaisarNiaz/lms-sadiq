import 'package:flutter/material.dart';
import 'package:lms/controllers/student_controller.dart';
import 'package:lms/widgets/bottomnavbar.dart';
import 'package:get/get.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StudentController());

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: Get.back,
        //   icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
        // ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('John Smith', style: TextStyle(fontSize: 16)),
            Text(
              'Admission No: 10001 • Class 4-A',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        // actions: const [
        //   Padding(
        //     padding: EdgeInsets.only(right: 12),
        //     child: Icon(Icons.notifications_none),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Subjects
            _sectionHeader(
              'Subjects',
              'View Timetable',
              controller.openSubjects,
            ),
            const SizedBox(height: 8),
            Row(
              children:
                  controller.subjects
                      .take(2)
                      .map((s) => Expanded(child: _subjectCard(s)))
                      .toList(),
            ),

            const SizedBox(height: 20),

            /// Exam Schedule
            _sectionHeader(
              'Exam Schedule',
              'View All Exams',
              controller.openExams,
            ),
            const SizedBox(height: 8),
            _examCard('Mathematics', '08:00 AM - 10:00 AM', '10 March 2024'),
            const SizedBox(height: 8),
            _examCard('Science', '10:30 AM - 12:30 PM', '12 March 2024'),

            const SizedBox(height: 20),

            /// Attendance
            const Text(
              'Attendance',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _attendanceCard(controller.attendance.value),
          ],
        ),
      ),
      bottomNavigationBar: MainBottomNav(),
    );
  }
}

Widget _sectionHeader(String title, String action, VoidCallback onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      TextButton(onPressed: onTap, child: Text(action)),
    ],
  );
}

Widget _subjectCard(Map subject) {
  return Card(
    margin: const EdgeInsets.only(right: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(subject['icon'], color: Colors.blue, size: 28),
          const SizedBox(height: 12),
          Text(
            subject['name'],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.person, size: 14),
              const SizedBox(width: 4),
              Text(subject['teacher']),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.schedule, size: 14),
              const SizedBox(width: 4),
              Text(subject['time']),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('View Task', style: TextStyle(color: Colors.blue)),
              Icon(Icons.arrow_forward_ios, size: 14),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _examCard(String subject, String time, String date) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: ListTile(
      title: Text(subject, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('$time$date'),
      isThreeLine: true,
    ),
  );
}

Widget _attendanceCard(int percent) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          SizedBox(
            height: 80,
            width: 80,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: percent / 100,
                  strokeWidth: 8,
                  backgroundColor: Colors.red.shade200,
                  valueColor: const AlwaysStoppedAnimation(Colors.green),
                ),
                Center(
                  child: Text(
                    '$percent%',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'You are doing great! Keep attending classes regularly.',
            ),
          ),
        ],
      ),
    ),
  );
}
