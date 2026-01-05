import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/controllers/student_controller.dart';

class FeesHistoryScreen extends StatelessWidget {
  final controller = Get.put(StudentController());

  FeesHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fees History"), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.feesList.length,
        itemBuilder: (context, index) {
          final fee = controller.feesList[index];
          return GestureDetector(
            onTap: () {
              if (!fee.isPaid) {
                Get.defaultDialog(
                  title: "Pay Fee",
                  middleText: "Do you want to pay the fee for ${fee.month}?",
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back(); // Close dialog
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Blue background
                        foregroundColor: Colors.white, // White text
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            8,
                          ), // Optional rounded corners
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ), // Optional padding
                      ),
                      onPressed: () {
                        Get.back(); // Close dialog
                        // Change status to Paid
                        fee.isPaid = true;
                        controller.feesList.refresh(); // Refresh UI

                        // Show Snackbar
                        Get.snackbar(
                          "Success",
                          "Fee Paid Successfully",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green[200],
                        );
                      },
                      child: Text(
                        "Pay Fee",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16), // Rounded corners
                side: const BorderSide(color: Colors.grey, width: 1),
              ),
              color: Colors.white,
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: Text("${fee.month} - ${fee.amount}"),
                subtitle: Text("Due: ${fee.dueDate}"),
                trailing: Text(
                  fee.isPaid ? "Paid" : "Pending",
                  style: TextStyle(
                    color: fee.isPaid ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
