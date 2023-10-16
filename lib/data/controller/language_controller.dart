import 'dart:ui';

import 'package:doctormobileapplication/models/language_model.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController implements GetxService {
  int selectedIndex = 0;
  LanguageModel? selected;

  updateSelectedIndex(int index) {
    selectedIndex = index;
    update();
  }

  updateSelected(LanguageModel? model) {
    selected = model;

    update();
  }

  updateLocale(Locale locale) {
    Get.updateLocale(selected!.locale!);
  }

  static LanguageController get i => Get.put(LanguageController());
}
