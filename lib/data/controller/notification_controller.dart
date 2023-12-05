import 'dart:ui';

import 'package:doctormobileapplication/components/snackbar.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/notification_model.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController implements GetxService {
  static NotificationController get i => Get.put(NotificationController());

  List<NotificationModel> notificationlist = [];
  updatenotificationlist(List<NotificationModel> data) {
    notificationlist.clear();
    notificationlist = data;
    update();
  }

  int today = 1;
  int yesterday = 1;
  int previous = 1;

  updatedays() {
    today = 1;
    yesterday = 1;
    previous = 1;
    update();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  updateIsloading(bool value) {
    updatedays();
    update();
    _isLoading = value;
    update();
  }

  int startIndexToFetchData = 0;
  int TotalRecordsData = 0;

  SetStartToFetchNextData() {
    if ((startIndexToFetchData + AppConstants.maximumDataTobeFetched) <
        TotalRecordsData) {
      startIndexToFetchData =
          startIndexToFetchData + AppConstants.maximumDataTobeFetched;
      return true;
    } else {
      Fluttertoast.showToast(
          msg: "allrecordsarefetched".tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kPrimaryLightColor,
          textColor: ColorManager.kPrimaryColor,
          fontSize: 14.0);
      return false;
    }
  }
}
