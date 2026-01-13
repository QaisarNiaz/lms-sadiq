import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/admin_controller.dart';

class AddTeacher extends GetView<AdminController> {
  const AddTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Teacher',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.school,
                  size: 60,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _buildTextField(
                    controller.teacherNameController,
                    'Name',
                    Icons.person,
                  ),
                  _buildTextField(
                    controller.teacherFullNameController,
                    'Full Name',
                    Icons.badge,
                  ),
                  _buildTextField(
                    controller.teacherEmailController,
                    'Email',
                    Icons.email,
                  ),
                  _buildTextField(
                    controller.teacherPasswordController,
                    'Password',
                    Icons.lock,
                    obscureText: true,
                  ),
                  _buildTextField(
                    controller.teacherSalaryController,
                    'Salary',
                    Icons.attach_money,
                    keyboardType: TextInputType.number,
                  ),
                  _buildTextField(
                    controller.teacherClassController,
                    'Class to Teach',
                    Icons.class_,
                  ),
                  _buildTextField(
                    controller.teacherRoleController,
                    'Role',
                    Icons.work,
                  ),
                  _buildTextField(
                    controller.teacherPhoneController,
                    'Phone Number',
                    Icons.phone,
                    keyboardType: TextInputType.phone,
                  ),
                  _buildTextField(
                    controller.teacherEmergencyPhoneController,
                    'Emergency Phone',
                    Icons.contact_phone,
                    keyboardType: TextInputType.phone,
                  ),
                  _buildTextField(
                    controller.teacherAddressController,
                    'Address',
                    Icons.location_on,
                  ),
                  const SizedBox(height: 30),
                  Obx(
                    () => SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed:
                            controller.isTeacherFormValid.value
                                ? controller.submitTeacherForm
                                : null,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          elevation: 5,
                          disabledBackgroundColor: Colors.grey[300],
                        ),
                        child: const Text(
                          'Submit Registration',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildTextField(
  TextEditingController controller,
  String label,
  IconData icon, {
  bool obscureText = false,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20.0),
    child: TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),
    ),
  );
}
