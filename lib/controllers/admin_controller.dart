import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/routes/app_routes.dart';

class AdminController extends GetxController {
  // Add Student Form Controllers
  final studentNameController = TextEditingController();
  final studentFullNameController = TextEditingController();
  final studentEmailController = TextEditingController();
  final studentPasswordController = TextEditingController();
  final studentAddressController = TextEditingController();
  final studentPhoneController = TextEditingController();
  final studentEmergencyPhoneController = TextEditingController();
  final studentFeesController = TextEditingController();
  final studentClassController = TextEditingController();

  // Add Teacher Form Controllers
  final teacherNameController = TextEditingController();
  final teacherFullNameController = TextEditingController();
  final teacherEmailController = TextEditingController();
  final teacherPasswordController = TextEditingController();
  final teacherSalaryController = TextEditingController();
  final teacherClassController =
      TextEditingController(); // Can be refined to list later
  final teacherRoleController = TextEditingController();
  final teacherPhoneController = TextEditingController();
  final teacherEmergencyPhoneController = TextEditingController();
  final teacherAddressController = TextEditingController();

  // Observables for submit button state
  final isStudentFormValid = false.obs;
  final isTeacherFormValid = false.obs;

  @override
  void onInit() {
    super.onInit();
    _setupListeners();
  }

  void _setupListeners() {
    // Student Form Listeners
    void validateStudentForm() {
      // Required: Name, Full Name, Address, Phone, Emergency Phone, Fees
      isStudentFormValid.value =
          studentNameController.text.isNotEmpty &&
          studentFullNameController.text.isNotEmpty &&
          studentAddressController.text.isNotEmpty &&
          studentPhoneController.text.isNotEmpty &&
          studentEmergencyPhoneController.text.isNotEmpty &&
          studentFeesController.text.isNotEmpty;
    }

    studentNameController.addListener(validateStudentForm);
    studentFullNameController.addListener(validateStudentForm);
    studentEmailController.addListener(validateStudentForm);
    studentPasswordController.addListener(validateStudentForm);
    studentAddressController.addListener(validateStudentForm);
    studentPhoneController.addListener(validateStudentForm);
    studentEmergencyPhoneController.addListener(validateStudentForm);
    studentFeesController.addListener(validateStudentForm);
    studentClassController.addListener(validateStudentForm);

    // Teacher Form Listeners
    void validateTeacherForm() {
      // Required: Name, Full Name, Address, Phone, Emergency Phone, Salary
      isTeacherFormValid.value =
          teacherNameController.text.isNotEmpty &&
          teacherFullNameController.text.isNotEmpty &&
          teacherAddressController.text.isNotEmpty &&
          teacherPhoneController.text.isNotEmpty &&
          teacherEmergencyPhoneController.text.isNotEmpty &&
          teacherSalaryController.text.isNotEmpty;
    }

    teacherNameController.addListener(validateTeacherForm);
    teacherFullNameController.addListener(validateTeacherForm);
    teacherEmailController.addListener(validateTeacherForm);
    teacherPasswordController.addListener(validateTeacherForm);
    teacherSalaryController.addListener(validateTeacherForm);
    teacherClassController.addListener(validateTeacherForm);
    teacherRoleController.addListener(validateTeacherForm);
    teacherPhoneController.addListener(validateTeacherForm);
    teacherEmergencyPhoneController.addListener(validateTeacherForm);
    teacherAddressController.addListener(validateTeacherForm);
  }

  @override
  void onClose() {
    // Dispose Student Controllers
    studentNameController.dispose();
    studentFullNameController.dispose();
    studentEmailController.dispose();
    studentPasswordController.dispose();
    studentAddressController.dispose();
    studentPhoneController.dispose();
    studentEmergencyPhoneController.dispose();
    studentFeesController.dispose();
    studentClassController.dispose();

    // Dispose Teacher Controllers
    teacherNameController.dispose();
    teacherFullNameController.dispose();
    teacherEmailController.dispose();
    teacherPasswordController.dispose();
    teacherSalaryController.dispose();
    teacherClassController.dispose();
    teacherRoleController.dispose();
    teacherPhoneController.dispose();
    teacherEmergencyPhoneController.dispose();
    teacherAddressController.dispose();

    super.onClose();
  }

  void submitStudentForm() {
    if (isStudentFormValid.value) {
      Get.snackbar(
        'Success',
        'Student created successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        // duration: const Duration(seconds: 2),
      );

      Future.delayed(const Duration(milliseconds: 400), () {
        Get.offNamed(Routes.ADMIN);
      });
    }
  }

  void submitTeacherForm() {
    if (isTeacherFormValid.value) {
      Get.snackbar(
        'Success',
        'Staff created successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        // duration: const Duration(seconds: 2),
      );
      Future.delayed(const Duration(milliseconds: 400), () {
        Get.offNamed(Routes.ADMIN);
      });
    }
  }
}
