import 'package:get/get.dart';

class QuantityController extends GetxController {
  var quantity = 1.obs; // الكمية المحددة

  void increaseQuantity() {
    quantity.value++;
  }

  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }
}
