import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hommie/view/home.dart';
import 'package:hommie/view/welcomescreen.dart';
class StartupscreenController extends GetxController {
  
  final box = GetStorage();
  RxBool waiting = true.obs;
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 4), () {
      if (box.hasData('access_token')) {
        Get.offAll(() => Home()); 
      } else {
        Get.offAll(() => WelcomeScreen());
      }
      
      waiting.value = false;
    });
  }
}