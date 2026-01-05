import 'package:flutter/material.dart';
import 'package:lms/controllers/student_controller.dart';
import 'package:lms/model/student_model.dart';
import 'package:lms/view/dashboard/student/examtimetable.dart';
import 'package:lms/view/dashboard/student/fee_history.dart';
import 'package:lms/view/dashboard/student/timetable.dart';
import 'package:lms/widgets/bottomnavbar.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

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
              () => Get.to(TimetableScreen()),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    controller.subjects
                        .map(
                          (s) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: _subjectCard(s),
                          ),
                        )
                        .toList(),
              ),
            ),

            const SizedBox(height: 20),

            /// Exam Schedule
            _sectionHeader(
              'Exam Schedule',
              'View All Exams',
              () => Get.to(ExamsTimetableScreen()), // ✅ Correct VoidCallback
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Fees",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () => Get.to(() => FeesHistoryScreen()),
                  child: const Text(
                    "History",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            /// Fees Table
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  _rowHeader(),
                  const Divider(),
                  ...controller.feesList.map(_feeRow),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Academic Calendar",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Obx(
              () => TableCalendar(
                focusedDay: controller.selectedDate.value,
                firstDay: DateTime(2023),
                lastDay: DateTime(2030),
                selectedDayPredicate:
                    (day) => isSameDay(day, controller.selectedDate.value),
                onDaySelected: (selected, focused) {
                  controller.selectedDate.value = selected;
                },
                onPageChanged: (focused) {
                  controller.selectedDate.value = focused;
                },
                eventLoader: controller.getEventsForDate,
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false, // ❌ hides "2 weeks"
                  titleCentered: true,
                ),
                calendarStyle: CalendarStyle(
                  markerDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, day, events) {
                    if (events.isEmpty) return const SizedBox.shrink();

                    final event = events.first as CalendarEvent;

                    return Positioned(
                      top: 2,
                      left: 2,
                      right: 2,
                      child: SizedBox(
                        width: double.infinity,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor, // 🔵 Theme blue
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            event.title,
                            maxLines: 1, // ✅ single line
                            softWrap: false,
                            overflow: TextOverflow.ellipsis, // ✅ no overflow
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 8,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Upcoming Events
            // Obx(() {
            //   final events = controller.getEventsForDate(
            //     controller.selectedDate.value,
            //   );
            //   if (events.isEmpty) {
            //     return const Text("No events");
            //   }
            //   return Column(
            //     children:
            //         events
            //             .map(
            //               (e) => ListTile(
            //                 leading: const Icon(Icons.event),
            //                 title: Text(e.title),
            //               ),
            //             )
            //             .toList(),
            //   );
            // }),
            PerformanceCard(
              attendance: 85,
              test: 70,
              exam: 90,
              onViewDetails: () {
                // Get.to(() => const PerformanceDetailScreen());
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: MainBottomNav(),
    );
  }
}

class PerformanceCard extends StatelessWidget {
  final int attendance;
  final int test;
  final int exam;
  final VoidCallback onViewDetails;

  const PerformanceCard({
    super.key,
    required this.attendance,
    required this.test,
    required this.exam,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Performance",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: onViewDetails,
              child: const Text("View Details"),
            ),
          ],
        ),

        const SizedBox(height: 12),

        /// Attendance
        PerformanceProgress(
          title: "Attendance",
          value: attendance,
          color: attendance > 50 ? Colors.green : Colors.red,
        ),

        const SizedBox(height: 12),

        /// Test
        PerformanceProgress(title: "Test", value: test, color: Colors.blue),

        const SizedBox(height: 12),

        /// Exam
        PerformanceProgress(title: "Exam", value: exam, color: Colors.amber),
      ],
    );
  }
}

class PerformanceProgress extends StatelessWidget {
  final String title;
  final int value;
  final Color color;

  const PerformanceProgress({
    super.key,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final progress = value / 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title + Value
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(
              "$value / 100",
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),

        const SizedBox(height: 6),

        /// Progress Bar
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ],
    );
  }
}

Widget _rowHeader() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: const [
      Text("Month"),
      Text("Amount"),
      Text("Due Date"),
      Text("Status"),
    ],
  );
}

Widget _feeRow(FeeModel fee) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(fee.month),
        Text("${fee.amount}"),
        Text(fee.dueDate),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: fee.isPaid ? Colors.green.shade100 : Colors.red.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            fee.isPaid ? "Paid" : "Pending",
            style: TextStyle(color: fee.isPaid ? Colors.green : Colors.red),
          ),
        ),
      ],
    ),
  );
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
    color: subject['color'],
    elevation: 0,
    margin: const EdgeInsets.only(right: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: Colors.grey, width: 1),
    ),
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
        ],
      ),
    ),
  );
}

Widget _examCard(String subject, String time, String date) {
  return Card(
    color: Colors.white, // ✅ white background
    elevation: 0,
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
    color: Colors.white, // ✅ white background
    elevation: 0,
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
