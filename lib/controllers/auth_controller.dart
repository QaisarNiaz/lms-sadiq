import 'package:get/get.dart';
import '../routes/app_routes.dart';


class AuthController extends GetxController {
var role = ''.obs;


void login(String email, String password, String selectedRole) {
role.value = selectedRole;


switch (selectedRole) {
case 'student':
Get.offAllNamed(Routes.STUDENT);
break;
case 'teacher':
Get.offAllNamed(Routes.TEACHER);
break;
case 'admin':
Get.offAllNamed(Routes.ADMIN);
break;
case 'owner':
Get.offAllNamed(Routes.OWNER);
break;
}}}