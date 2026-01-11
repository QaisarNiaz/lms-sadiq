import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/controllers/student_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StudentController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF2D3142)),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Attendance',
          style: TextStyle(
            color: Color(0xFF2D3142),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Summary Section
              _buildSummaryHeader(),
              const SizedBox(height: 24),
              _buildChartCard(controller),
              const SizedBox(height: 32),
              
              // Calendar Section
              const Text(
                'Monthly Record',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3142),
                ),
              ),
              const SizedBox(height: 16),
              _buildCalendar(controller),
              
              const SizedBox(height: 30),
              _buildLegend(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3142),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Your overall attendance summary for this academic year.',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildChartCard(StudentController controller) {
    return Container(
      padding: const EdgeInsets.all(24),
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
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: Obx(
              () => Stack(
                children: [
                   PieChart(
                    PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: 70,
                      sections: [
                        PieChartSectionData(
                          color: const Color(0xFF4CD964), // Green
                          value: controller.presentPercentage.value,
                          title: '${controller.presentPercentage.value.toInt()}%',
                          radius: 20,
                          titleStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          color: const Color(0xFFFF3B30), // Red
                          value: controller.absentPercentage.value,
                          title: '${controller.absentPercentage.value.toInt()}%',
                          radius: 20,
                          titleStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                         PieChartSectionData(
                          color: const Color(0xFFFFCC00), // Yellow
                          value: controller.leavePercentage.value,
                          title: '${controller.leavePercentage.value.toInt()}%',
                          radius: 20,
                          titleStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Dark text for yellow
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${controller.attendance.value}%',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D3142),
                          ),
                        ),
                        const Text(
                          'Present',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
               _chartLegendItem('Present', const Color(0xFF4CD964)),
               _chartLegendItem('Absent', const Color(0xFFFF3B30)),
               _chartLegendItem('Leave', const Color(0xFFFFCC00)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chartLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3142),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendar(StudentController controller) {
    return Container(
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: TableCalendar(
        focusedDay: DateTime.now(),
        firstDay: DateTime(2023),
        lastDay: DateTime(2030),
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xFF2D3142),
          ),
        ),
        calendarStyle: const CalendarStyle(
           outsideDaysVisible: false,
        ),
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            return _buildCalendarDay(day, controller);
          },
          todayBuilder: (context, day, focusedDay) {
             return _buildCalendarDay(day, controller, isToday: true);
          },
          selectedBuilder:  (context, day, focusedDay) {
             return _buildCalendarDay(day, controller);
          },
        ),
      ),
    );
  }

  Widget _buildCalendarDay(DateTime day, StudentController controller, {bool isToday = false}) {
     // Skip weekends for coloring logic if desired, or color them neutral
     if (day.weekday == DateTime.saturday || day.weekday == DateTime.sunday) {
        return Center(
          child: Text(
            '${day.day}',
            style: TextStyle(color: Colors.grey.shade400),
          ),
        );
     }

     final status = controller.getAttendanceStatus(day);
     Color? bgColor;
     Color textColor = Colors.black87;

     if (status == 'P') {
       bgColor = const Color(0xFF4CD964).withOpacity(0.2); // Light Green
       textColor = const Color(0xFF2E7D32);
     } else if (status == 'A') {
       bgColor = const Color(0xFFFF3B30).withOpacity(0.2); // Light Red
       textColor = const Color(0xFFC62828);
     } else if (status == 'L') {
       bgColor = const Color(0xFFFFCC00).withOpacity(0.2); // Light Yellow
       textColor = const Color(0xFFF57F17);
     }
     
     if (bgColor == null) {
       // Future dates or no data
        return Center(
          child: Container(
             decoration: isToday ? BoxDecoration(
               color: const Color(0xFF6C63FF),
               shape: BoxShape.circle
             ) : null,
             width: 35,
             height: 35,
             alignment: Alignment.center,
             child: Text(
               '${day.day}',
               style: TextStyle(
                 color: isToday ? Colors.white : Colors.black87,
                 fontWeight: isToday ? FontWeight.bold : FontWeight.normal, 
                ),
             )
          ),
        );
     }

     return Center(
       child: Container(
         width: 35,
         height: 35,
         decoration: BoxDecoration(
           color: bgColor,
           shape: BoxShape.circle,
         ),
         alignment: Alignment.center,
         child: Text(
           '${day.day}',
           style: TextStyle(
             color: textColor,
             fontWeight: FontWeight.bold,
           ),
         ),
       ),
     );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _legendItem('Present', const Color(0xFF4CD964).withOpacity(0.2), const Color(0xFF2E7D32)),
        const SizedBox(width: 16),
        _legendItem('Absent', const Color(0xFFFF3B30).withOpacity(0.2), const Color(0xFFC62828)),
        const SizedBox(width: 16),
        _legendItem('Leave', const Color(0xFFFFCC00).withOpacity(0.2), const Color(0xFFF57F17)),
      ],
    );
  }

  Widget _legendItem(String text, Color bg, Color textC) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textC,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
