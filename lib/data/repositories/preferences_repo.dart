import 'dart:convert';
import 'package:doctormobileapplication/data/controller/preference_controller.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/preference.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PreferenceRepo {
  Future<String> getPreference() async {
    var headers = {
      'Content-Type': 'application/json',
    };
    String branceid = await LocalDb().getBranchId() ?? "";
    var body = {"BranchId": branceid};
    try {
      var response = await http.post(
        Uri.parse(AppConstants.getpreferences),
        body: jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var errormsg = responseData['ErrorMessage'];

        if (status == 1) {
          // make pref controller and update object
          dynamic data = responseData['Data'];
          PreferenceController.i
              .updatePreference(preferenceData.fromJson(data));
          return "ok";
        } else {
          Fluttertoast.showToast(
              msg: errormsg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return errormsg;
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Somethingwentwrong'.tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      return 'false';
    }
    return 'false';
  }
}
