import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/controllers/student_controller.dart';

class TimetableScreen extends StatelessWidget {
  TimetableScreen({super.key});
  final controller = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    // Controllers for scrollbars
    final ScrollController verticalController = ScrollController();
    final ScrollController horizontalController = ScrollController();

    return Scaffold(
      appBar: AppBar(title: const Text('Timetable'), centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: const Text(
                'Weekly Subjects Schedule',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            ...controller.subjectsScheduleText.map(
              (text) => Row(
                children: [
                  const Text('• ', style: TextStyle(fontSize: 16)),
                  Expanded(child: Text(text)),
                ],
              ),
            ),
            SizedBox(height: 20),
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
                        dataRowColor: WidgetStateProperty.resolveWith<Color?>((
                          Set<WidgetState> states,
                        ) {
                          // Alternate row colors
                          if (states.contains(WidgetState.selected)) {
                            return Colors.blue[50];
                          }
                          return null; // Default color
                        }),
                        border: TableBorder.all(color: Colors.grey),
                        columns: [
                          const DataColumn(
                            label: Text(
                              'Day',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          for (int i = 1; i <= 8; i++)
                            DataColumn(
                              label: Text(
                                'Period $i',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                        rows: [
                          for (int i = 0; i < controller.days.length; i++)
                            DataRow(
                              color: WidgetStateProperty.resolveWith<Color?>((
                                states,
                              ) {
                                // Alternate row colors
                                return i % 2 == 0
                                    ? Colors.grey[100]
                                    : Colors.white;
                              }),
                              cells: [
                                DataCell(
                                  Text(
                                    controller.days[i],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                for (int j = 0; j < 8; j++)
                                  DataCell(Text(controller.periods[i][j])),
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
