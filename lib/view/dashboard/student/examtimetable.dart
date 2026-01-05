import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/controllers/student_controller.dart';

class ExamsTimetableScreen extends StatelessWidget {
  ExamsTimetableScreen({super.key});

  final controller = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    final verticalController = ScrollController();
    final horizontalController = ScrollController();

    // Get list of all unique dates
    final dates =
        controller.examSchedule.map((e) => e['date']!).toSet().toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Exams Timetable'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: const Text(
                'Exam Rules & Instructions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            ...controller.examRules.map(
              (rule) => Row(
                children: [
                  const Text('• ', style: TextStyle(fontSize: 16)),
                  Expanded(child: Text(rule)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Scrollbar(
              controller: horizontalController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: horizontalController,
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                  child: Scrollbar(
                    controller: verticalController,
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      controller: verticalController,
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        headingRowColor: WidgetStateProperty.all(
                          Colors.blue[100],
                        ),
                        border: TableBorder.all(color: Colors.grey),
                        columns: const [
                          DataColumn(
                            label: Text(
                              'Date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Subject',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Time',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                        rows: [
                          for (var date in dates)
                            DataRow(
                              color: WidgetStateProperty.resolveWith<Color?>(
                                (states) =>
                                    dates.indexOf(date) % 2 == 0
                                        ? Colors.grey[100]
                                        : Colors.white,
                              ),
                              cells: [
                                DataCell(Text(date)),
                                DataCell(
                                  Text(
                                    controller.examSchedule.firstWhere(
                                      (e) => e['date'] == date,
                                      orElse: () => {'subject': 'No Exam'},
                                    )['subject']!,
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    controller.examSchedule.firstWhere(
                                      (e) => e['date'] == date,
                                      orElse: () => {'time': '-'},
                                    )['time']!,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
