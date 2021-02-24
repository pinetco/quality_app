import 'package:get/get.dart';
import 'package:quality_app/packages/config_package.dart';

class BottomNavigationController extends GetxController {
  int _currentTab = 0;
  // final box = GetStorage();

  int get currentTab => _currentTab;

  updateCurrentTab(int index) {
    // box.write('darkmode', true);
    _currentTab = index;
    update();
  }
}
