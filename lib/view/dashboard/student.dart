import 'package:flutter/material.dart';
import 'package:lms/widgets/bottomnavbar.dart';


class StudentDashboard extends StatelessWidget {
const StudentDashboard({super.key});


@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('Student Dashboard')),
body: const Center(child: Text('Welcome Student')),
bottomNavigationBar: MainBottomNav(),
);
}
}