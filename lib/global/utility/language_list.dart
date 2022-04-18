import 'package:get/get.dart';

import 'de.dart';
import 'en.dart';

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'de_DE': de,
      };
}
