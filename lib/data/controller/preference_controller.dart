import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
import 'package:doctormobileapplication/models/designation.dart';
import 'package:doctormobileapplication/models/doctor_details.dart';
import 'package:doctormobileapplication/models/preference.dart';
import 'package:doctormobileapplication/models/work_locations.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PreferenceController extends GetxController implements GetxService {
  static PreferenceController get i => Get.put(PreferenceController());
  var idformatter = MaskTextInputFormatter();
  preferenceData preferenceObject = preferenceData();
  updatePreference(preferenceData p) {
    preferenceObject = p;
    // idformatter = MaskTextInputFormatter(
    //     mask: PreferenceController
    //         .i.preferenceObject.dynamicMaskingForIdentityNumber);
    update();
  }
}
