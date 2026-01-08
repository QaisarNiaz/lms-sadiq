import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/controllers/student_controller.dart';

class TimetableScreen extends StatelessWidget {
  TimetableScreen({super.key});
  final controller = Get.put(StudentController());

  // Helper to find subject details (color, icon, teacher) by name
  Map<String, dynamic> _getSubjectDetails(String subjectName) {
    final subject = controller.subjects.firstWhere(
      (s) => s['name'] == subjectName,
      orElse:
          () => {
            'name': subjectName,
            'teacher': 'N/A',
            'icon': Icons.class_,
            'color': Colors.grey.shade300,
          },
    );
    return subject;
  }

  // Time slots mapping (Assumed based on periods index)
  String _getTimeForPeriod(int index) {
    switch (index) {
      case 0:
        return "08:00 - 09:00";
      case 1:
        return "09:00 - 10:00";
      case 2:
        return "10:00 - 11:00";
      case 3:
        return "11:00 - 12:00";
      case 4:
        return "12:00 - 12:30"; // Break
      case 5:
        return "12:30 - 01:30";
      case 6:
        return "01:30 - 02:30";
      case 7:
        return "02:30 - 03:30";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get current weekday index (Monday = 1, so week index starts at 0)
    int initialIndex = DateTime.now().weekday - 1;
    if (initialIndex < 0 || initialIndex > 4)
      initialIndex = 0; // Default to Monday if weekend

    return DefaultTabController(
      length: controller.days.length,
      initialIndex: initialIndex,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        appBar: AppBar(
          title: const Text(
            'Weekly Timetable',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          bottom: TabBar(
            isScrollable: true,
            labelColor: const Color(0xFF6C63FF),
            unselectedLabelColor: Colors.grey,
            indicatorColor: const Color(0xFF6C63FF),
            indicatorWeight: 3,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            tabs:
                controller.days
                    .map((day) => Tab(text: day.substring(0, 3)))
                    .toList(),
          ),
        ),
        body: TabBarView(
          children: List.generate(controller.days.length, (dayIndex) {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              itemCount: controller.periods[dayIndex].length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, periodIndex) {
                final subjectName = controller.periods[dayIndex][periodIndex];
                final isBreak = subjectName == 'Break';
                final subjectDetails = _getSubjectDetails(subjectName);

                if (isBreak) {
                  return _buildBreakCard();
                }

                return _buildPeriodCard(
                  subjectName: subjectName,
                  teacher: subjectDetails['teacher'],
                  icon: subjectDetails['icon'],
                  color: subjectDetails['color'],
                  time: _getTimeForPeriod(periodIndex),
                );
              },
            );
          }),
        ),
      ),
    );
  }

  Widget _buildBreakCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.coffee, color: Colors.orange, size: 20),
          SizedBox(width: 8),
          Text(
            "Break Time (12:00 - 12:30)",
            style: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodCard({
    required String subjectName,
    required String teacher,
    required IconData icon,
    required Color color,
    required String time,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Time Column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    time.split(' - ')[0],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF2D3142),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time.split(' - ')[1],
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Container(width: 1, height: 40, color: Colors.grey.shade200),
              const SizedBox(width: 16),

              // Icon
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subjectName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Color(0xFF2D3142),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 14,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          teacher,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
