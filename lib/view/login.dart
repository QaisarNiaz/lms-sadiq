import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final AuthController controller = Get.put(AuthController());
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final role = 'student'.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passCtrl,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 12),
            Obx(
              () => DropdownButton<String>(
                value: role.value,
                items: const [
                  DropdownMenuItem(value: 'student', child: Text('Student')),
                  DropdownMenuItem(value: 'teacher', child: Text('Teacher')),
                  DropdownMenuItem(value: 'admin', child: Text('Admin')),
                  DropdownMenuItem(value: 'owner', child: Text('Owner')),
                ],
                onChanged: (v) => role.value = v!,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  () => controller.login(
                    emailCtrl.text,
                    passCtrl.text,
                    role.value,
                  ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
