import 'package:flutter/material.dart';
import 'package:lms/widgets/bottomnavbar.dart';

class OwnerDashboard extends StatelessWidget {
  const OwnerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Owner Dashboard')),
      body: const Center(child: Text('Welcome Owner')),
      bottomNavigationBar: MainBottomNav(),
    );
  }
}
