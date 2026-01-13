import 'package:flutter/material.dart';
import 'package:lms/controllers/student_controller.dart';
import 'package:lms/model/student_model.dart';
import 'package:lms/view/dashboard/student/examtimetable.dart';
import 'package:lms/view/dashboard/student/fee_history.dart';
import 'package:lms/view/dashboard/student/timetable.dart';
import 'package:lms/view/dashboard/student/subject_details.dart';
import 'package:lms/view/dashboard/student/attendance_screen.dart';
import 'package:lms/view/dashboard/student/performance_screen.dart';
import 'package:lms/widgets/bottomnavbar.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is loaded
    final controller = Get.put(StudentController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA), // Light grey background
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Subjects Section
                  _sectionHeader(
                    'My Subjects',
                    'View Timetable',
                    () => Get.to(() => TimetableScreen()),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 180, // Increased height for better card proportion
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.subjects.length,
                      separatorBuilder:
                          (context, index) => const SizedBox(width: 0),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: index == 0 ? 0 : 0,
                            right: 16,
                          ),
                          child: _subjectCard(controller.subjects[index]),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// Exam Schedule
                  _sectionHeader(
                    'Exam Schedule',
                    'View All',
                    () => Get.to(() => ExamsTimetableScreen()),
                  ),
                  const SizedBox(height: 16),
                  _examCard('Mathematics', '08:00 AM - 10:00 AM', '10 Mar'),
                  const SizedBox(height: 12),
                  _examCard('Science', '10:30 AM - 12:30 PM', '12 Mar'),

                  const SizedBox(height: 30),

                  /// Performance & Attendance
                  const Text(
                    'Overview',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3142),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => Get.to(() => const AttendanceScreen()),
                          borderRadius: BorderRadius.circular(20),
                          child: _statCard(
                            'Attendance',
                            '${controller.attendance.value}%',
                            Colors.green,
                            Icons.check_circle_outline,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: InkWell(
                          onTap: () => Get.to(() => const PerformanceScreen()),
                          borderRadius: BorderRadius.circular(20),
                          child: _statCard(
                            'Performance',
                            controller.overallPerformanceStatus,
                            Colors.blue,
                            Icons.trending_up,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  /// Academic Calendar
                  const Text(
                    'Academic Calendar',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3142),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                    child: Column(
                      children: [
                        Obx(
                          () => TableCalendar(
                            focusedDay: controller.selectedDate.value,
                            firstDay: DateTime(2023),
                            lastDay: DateTime(2030),
                            selectedDayPredicate:
                                (day) => isSameDay(
                                  day,
                                  controller.selectedDate.value,
                                ),
                            onDaySelected: (selected, focused) {
                              controller.selectedDate.value = selected;
                            },
                            onPageChanged: (focused) {
                              controller.selectedDate.value = focused;
                            },
                            eventLoader: controller.getEventsForDate,
                            headerStyle: const HeaderStyle(
                              formatButtonVisible: false,
                              titleCentered: true,
                              titleTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            calendarStyle: const CalendarStyle(
                              todayDecoration: BoxDecoration(
                                color: Color(0xFF6C63FF),
                                shape: BoxShape.circle,
                              ),
                              selectedDecoration: BoxDecoration(
                                color: Color(0xFF2D3142),
                                shape: BoxShape.circle,
                              ),
                            ),
                            calendarBuilders: CalendarBuilders(
                              markerBuilder: (context, day, events) {
                                if (events.isEmpty)
                                  return const SizedBox.shrink();
                                final event = events.first as CalendarEvent;
                                return Positioned(
                                  bottom: 1,
                                  child: Container(
                                    width: 35, // constraining width
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 2,
                                      vertical: 1,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(
                                        0xFFFF9F43,
                                      ), // Orange accent for events
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      event.title,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 8,
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const Divider(height: 24),
                        // Event Details List
                        Obx(() {
                          final events = controller.getEventsForDate(
                            controller.selectedDate.value,
                          );
                          if (events.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "No events for this day",
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 13,
                                ),
                              ),
                            );
                          }
                          return Column(
                            children:
                                events
                                    .map(
                                      (event) => Container(
                                        margin: const EdgeInsets.only(
                                          bottom: 8,
                                        ),
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: const Color(
                                            0xFFFFF4E5,
                                          ), // Light orange bg
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: const Color(0xFFFFE0B2),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.event_outlined,
                                              size: 20,
                                              color: Color(0xFFFF9F43),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Text(
                                                event.title,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFFE67E22),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                          );
                        }),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// Fees Section
                  _sectionHeader(
                    'Fees Status',
                    'History',
                    () => Get.to(() => FeesHistoryScreen()),
                  ),
                  const SizedBox(height: 16),
                  _feeOverviewCard(controller.feesList),

                  const SizedBox(height: 100), // Bottom padding for nav bar
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainBottomNav(),
      extendBody: true, // Allows content to go behind nav bar if transparent
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6C63FF), Color(0xFF4834D4)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Welcome back,',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'John Smith',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     color: Colors.white.withOpacity(0.2),
              //     shape: BoxShape.circle,
              //   ),
              //   padding: const EdgeInsets.all(8),
              //   child: const Icon(Icons.notifications_none_rounded, color: Colors.white, size: 28),
              // )
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.school_outlined,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Class 4-A',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(width: 1, height: 20, color: Colors.white30),
                const Spacer(),
                const Text(
                  'ID: 10001',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
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
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3142),
          ),
        ),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              action,
              style: const TextStyle(
                color: Color(0xFF6C63FF),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _subjectCard(Map subject) {
    Color baseColor = subject['color'];

    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: baseColor.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Get.to(() => SubjectDetailsScreen(subject: subject)),
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            children: [
              // Decorative circle
              Positioned(
                right: -20,
                top: -20,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white.withOpacity(0.15),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        subject['icon'],
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subject['name'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subject['teacher'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w500,
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

  Widget _examCard(String subject, String time, String date) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF4E5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  date.split(' ')[0], // Day
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF9F43),
                  ),
                ),
                Text(
                  date.split(' ')[1].toUpperCase(), // Month
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF9F43),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3142),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 14,
                      color: Colors.grey.shade500,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 14,
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
    );
  }

  Widget _statCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3142),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _feeOverviewCard(List<FeeModel> fees) {
    final pendingFees = fees.where((f) => !f.isPaid).toList();
    final hasPending = pendingFees.isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: hasPending ? const Color(0xFFFFEEEE) : const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: hasPending ? Colors.red.shade100 : Colors.green.shade100,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              hasPending ? Icons.priority_high_rounded : Icons.check_rounded,
              color: hasPending ? Colors.red : Colors.green,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hasPending ? 'Pending Dues' : 'All Clear!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color:
                        hasPending
                            ? Colors.red.shade900
                            : Colors.green.shade900,
                  ),
                ),
                Text(
                  hasPending
                      ? '${pendingFees.length} invoice(s) pending payment'
                      : 'You have no outstanding fees',
                  style: TextStyle(
                    fontSize: 13,
                    color:
                        hasPending
                            ? Colors.red.shade700
                            : Colors.green.shade700,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: hasPending ? Colors.red.shade300 : Colors.green.shade300,
          ),
        ],
      ),
    );
  }
}
