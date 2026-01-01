import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/controllers/bottomnavbarController.dart';

class MainBottomNav extends StatelessWidget {
  MainBottomNav({super.key});
  final controller = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: controller.index.value,
        onTap: (i) {
          controller.index.value = i;
          if (i == 0) controller.goHome();
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
      ),
    );
  }
}
