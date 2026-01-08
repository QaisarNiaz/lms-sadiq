import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/controllers/student_controller.dart';

class ExamsTimetableScreen extends StatelessWidget {
  ExamsTimetableScreen({super.key});

  final controller = Get.put(StudentController());

  // Helper to parse date string to DateTime object for sorting/comparison if needed
  // Assuming date format "dd Month yyyy"
  
  @override
  Widget build(BuildContext context) {
    // Sort exams by date if needed, currently using order from controller
    final exams = controller.examSchedule;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Exams Timetable',
           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             // Rules Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF4E5),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFFE0B2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                    children: const [
                       Icon(Icons.rule_rounded, color: Colors.orange, size: 24),
                       SizedBox(width: 12),
                       Text(
                         "Exam Rules",
                         style: TextStyle(
                           fontSize: 18,
                           fontWeight: FontWeight.bold,
                           color:  Color(0xFFE67E22),
                         ),
                       ),
                    ],
                   ),
                   const SizedBox(height: 12),
                   ...controller.examRules.map(
                    (rule) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("•", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              rule,
                              style: TextStyle(
                                color: Colors.orange.shade800,
                                fontSize: 13,
                                height: 1.4
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            const Text(
              "Schedule",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3142),
              ),
            ),
            const SizedBox(height: 16),
            
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: exams.length,
              itemBuilder: (context, index) {
                final exam = exams[index];
                return _buildExamCard(exam, index == 0); // Highlight first as "Next"
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExamCard(Map<String, String> exam, bool isNext) {
    final dateParts = exam['date']!.split(' '); // [10, March, 2024]
    final day = dateParts[0];
    final month = dateParts.length > 1 ? dateParts[1].substring(0, 3).toUpperCase() : '';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
        border: isNext ? Border.all(color: const Color(0xFF6C63FF), width: 2) : null,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Date Left Side
            Container(
              width: 90,
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                color: isNext ? const Color(0xFF6C63FF) : Colors.grey.shade50,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(22),
                  bottomLeft: Radius.circular(22),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    day,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isNext ? Colors.white : const Color(0xFF2D3142),
                    ),
                  ),
                  Text(
                    month,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isNext ? Colors.white.withOpacity(0.8) : Colors.grey.shade500,
                    ),
                  ),
                  if (isNext)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('UP NEXT', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
            
            // Details Right Side
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      exam['subject']!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3142),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_filled_rounded,
                          size: 16,
                          color: isNext ? const Color(0xFF6C63FF) : Colors.grey.shade400,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          exam['time']!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
