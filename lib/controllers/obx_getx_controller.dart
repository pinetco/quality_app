import 'package:get/get.dart';

class ObxGetxController extends GetxController {
  var count = 0.obs;

  int get counterValue => count.value;

  void increment() {
    count.value++;
  }
}
