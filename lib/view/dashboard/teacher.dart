import 'package:flutter/material.dart';
import 'package:lms/widgets/bottomnavbar.dart';


class TeacherDashboard extends StatelessWidget {
const TeacherDashboard({super.key});


@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('Teacher Dashboard')),
body: const Center(child: Text('Welcome Teacher')),
bottomNavigationBar: MainBottomNav(),
);
}
}