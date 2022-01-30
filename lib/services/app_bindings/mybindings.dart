import 'package:get/get.dart';
import 'package:myapp/controller/authentication_controller.dart';
import 'package:myapp/controller/dashboard_controller.dart';

class MyBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AuthenticationController());
    Get.lazyPut(() => DashboardController());
  }
}
