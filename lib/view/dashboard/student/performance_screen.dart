import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/controllers/student_controller.dart';

class PerformanceScreen extends StatelessWidget {
  const PerformanceScreen({super.key});

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
          'Performance',
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildStatusBanner(controller),
              const SizedBox(height: 24),
              _buildSectionTitle('Attendance Overview'),
              const SizedBox(height: 16),
              _buildAttendanceCard(controller),
              const SizedBox(height: 24),
              _buildSectionTitle('Task Completion'),
              const SizedBox(height: 16),
              _buildTaskStats(controller),
              const SizedBox(height: 24),
              _buildSectionTitle('Exam Scores'),
              const SizedBox(height: 16),
              _buildExamScoresList(controller),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF2D3142),
      ),
    );
  }

  Widget _buildStatusBanner(StudentController controller) {
    final status = controller.overallPerformanceStatus;
    Color color;
    IconData icon;
    String message;

    switch (status) {
      case 'Excellent':
        color = const Color(0xFF4CD964);
        icon = Icons.star_rounded;
        message = "Keep up the great work!";
        break;
      case 'Good':
        color = Colors.blue;
        icon = Icons.thumb_up_rounded;
        message = "You're doing well!";
        break;
      case 'Fair':
        color = Colors.orange;
        icon = Icons.trending_flat_rounded;
        message = "You can do better.";
        break;
      default:
        color = Colors.red;
        icon = Icons.warning_rounded;
        message = "Needs improvement.";
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.8), color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 48),
          const SizedBox(height: 12),
          Text(
            status,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceCard(StudentController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Row(
        children: [
          SizedBox(
            height: 120,
            width: 120,
            child: Obx(
              () => Stack(
                children: [
                  PieChart(
                    PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: [
                        PieChartSectionData(
                          color: const Color(0xFF4CD964),
                          value: controller.presentPercentage.value,
                          radius: 12,
                          showTitle: false,
                        ),
                        PieChartSectionData(
                          color: const Color(0xFFFF3B30),
                          value: controller.absentPercentage.value,
                          radius: 12,
                          showTitle: false,
                        ),
                        PieChartSectionData(
                          color: const Color(0xFFFFCC00),
                          value: controller.leavePercentage.value,
                          radius: 12,
                          showTitle: false,
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Text(
                      '${controller.attendance.value}%',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3142),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _legendItem('Present', const Color(0xFF4CD964)),
                const SizedBox(height: 8),
                _legendItem('Absent', const Color(0xFFFF3B30)),
                const SizedBox(height: 8),
                _legendItem('Leave', const Color(0xFFFFCC00)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _legendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
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

  Widget _buildTaskStats(StudentController controller) {
    return Obx(() {
       final stats = controller.taskStats;
       return Row(
        children: [
          Expanded(
            child: _taskStatItem(
              'Pending',
              stats['pending'].toString(),
              Colors.orange,
              Icons.timelapse_rounded,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _taskStatItem(
              'Submitted',
              stats['submitted'].toString(),
              const Color(0xFF6C63FF),
              Icons.check_circle_outline_rounded,
            ),
          ),
        ],
      );
    });
  }

  Widget _taskStatItem(String label, String value, Color color, IconData icon) {
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
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3142),
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExamScoresList(StudentController controller) {
    return Obx(
      () => Column(
        children:
            controller.examScores.map((score) {
              final obtained = score['obtained'] as int;
              final total = score['total'] as int;
              final percentage = obtained / total;
              
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          score['subject'] as String,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF2D3142),
                          ),
                        ),
                        Text(
                          '$obtained / $total',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6C63FF),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: percentage,
                        backgroundColor: Colors.grey.shade100,
                        valueColor: AlwaysStoppedAnimation(
                          percentage > 0.8
                              ? const Color(0xFF4CD964)
                              : percentage > 0.6
                              ? Colors.blue
                              : Colors.orange,
                        ),
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
      ),
    );
  }
}
