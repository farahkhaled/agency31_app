import 'dart:developer';

import 'package:agency31_app/model/product.dart';
import 'package:agency31_app/utils/base/colors.dart';
import 'package:get/get.dart';

class CardController extends GetxController {
  static CardController get to => Get.find();
  final _products = {}.obs;

  RxInt itemsCount = 0.obs;
  Rx<double> cartTotal = 0.0.obs;

  RxMap<dynamic, dynamic> get getProduct => _products;

  void addProduct(Product product) {
    if (_products.containsKey(product)) {
      _products[product] += 1;
    } else {
      _products[product] = 1;
    }
    itemsCount += 1;
    cartTotal += product.price;

    Get.snackbar(
      "Product added",
      "You have added the ${product.name} to the cart",
      isDismissible: true,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: MyColors.secondary,
    );
    log(itemsCount.toString(), name: "itemsCount");
    log(_products.toString(), name: "_products");
  }

  void removeProduct(Product product) {
    if (_products.containsKey(product) && _products[product] == 1) {
      _products.removeWhere((key, value) => key == product);
      cartTotal -= product.price;
    } else if (_products.containsKey(product)) {
      _products[product] -= 1;
      cartTotal -= product.price;
    }
    itemsCount -= 1;
    log(itemsCount.toString(), name: "itemsCount");
    log(_products.toString(), name: "_products");
  }

  void removeProductAll(Product product) {
    if (_products.containsKey(product)) {
      itemsCount -= _products[product];
      cartTotal -= product.price * _products[product];
      log(itemsCount.toString(), name: "itemsCount");
      _products.remove(product);
    }
    log(_products.toString(), name: "_products");
  }
}
