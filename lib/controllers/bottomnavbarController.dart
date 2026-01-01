import 'package:get/get.dart';
import '../routes/app_routes.dart';
import 'auth_controller.dart';


class BottomNavController extends GetxController {
var index = 0.obs;


void goHome() {
final role = Get.find<AuthController>().role.value;
if (role == 'student') Get.offAllNamed(Routes.STUDENT);
if (role == 'teacher') Get.offAllNamed(Routes.TEACHER);
if (role == 'admin') Get.offAllNamed(Routes.ADMIN);
if (role == 'owner') Get.offAllNamed(Routes.OWNER);
}
}