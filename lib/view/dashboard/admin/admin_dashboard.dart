import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/widgets/bottomnavbar.dart';
import 'package:lms/routes/app_routes.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Welcome Admin',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 10,
        toolbarHeight: 100, // Extended height
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Changed CrossAxis to default (center)
            const SizedBox(height: 40),
            // const Text(
            //   'Welcome Admin',
            //   style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepPurple), // Enhanced text style
            // ),
            // const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Centered buttons
              children: [
                _buildDashboardButton(
                  icon: Icons.person_add,
                  label: 'Add Student',
                  color: Colors.blueAccent,
                  onTap: () => Get.toNamed(Routes.ADD_STUDENT),
                ),
                const SizedBox(width: 20),
                _buildDashboardButton(
                  icon: Icons.person_add_alt_1,
                  label: 'Add Teacher',
                  color: Colors.green,
                  onTap: () => Get.toNamed(Routes.ADD_TEACHER),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainBottomNav(),
    );
  }

  Widget _buildDashboardButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
