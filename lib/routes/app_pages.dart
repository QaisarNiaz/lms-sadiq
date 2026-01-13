import 'package:get/get.dart';
import 'package:lms/view/dashboard/admin/admin_dashboard.dart';
import 'package:lms/view/dashboard/owner.dart';
import 'package:lms/view/dashboard/student/student.dart';
import 'package:lms/view/dashboard/teacher.dart';
import 'package:lms/view/dashboard/admin/add_student.dart';
import 'package:lms/view/dashboard/admin/add_teacher.dart';
import 'package:lms/view/login.dart';
import 'package:lms/view/splash.dart';
import 'package:lms/controllers/admin_controller.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.SPLASH, page: () => const SplashView()),
    GetPage(name: Routes.LOGIN, page: () => LoginView()),
    GetPage(name: Routes.STUDENT, page: () => const StudentDashboard()),
    GetPage(name: Routes.TEACHER, page: () => const TeacherDashboard()),
    GetPage(name: Routes.ADMIN, page: () => const AdminDashboard()),
    GetPage(
      name: Routes.ADD_STUDENT, 
      page: () => const AddStudent(),
      binding: BindingsBuilder(() {
        Get.put(AdminController());
      }),
    ),
    GetPage(
      name: Routes.ADD_TEACHER, 
      page: () => const AddTeacher(),
       binding: BindingsBuilder(() {
        Get.put(AdminController());
      }),
    ),
    GetPage(name: Routes.OWNER, page: () => const OwnerDashboard()),
  ];
}
