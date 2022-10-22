import 'package:agency31_app/controller/authentication.dart';
import 'package:agency31_app/controller/cart.dart';
import 'package:agency31_app/controller/location.dart';
import 'package:get/get.dart';

class ShopBinding implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => FavoriteController());
    Get.lazyPut(() => CardController());
    Get.lazyPut(() => LocationController());

    Get.put(LocationController(), permanent: true);
  }
}

class InitBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
