import 'dart:ui';

import 'package:doctormobileapplication/components/snackbar.dart';
import 'package:doctormobileapplication/models/notification_model.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController implements GetxService {
  static NotificationController get i => Get.put(NotificationController());

  List<NotificationModel> notificationlist = [];
  updatenotificationlist(List<NotificationModel> data) {
    notificationlist.clear();
    notificationlist = data;
    update();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  updateIsloading(bool value) {
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
      showSnackbar(Get.context!, 'allrecordsarefetched'.tr,
          color: const Color(0xfff1272d3));
      return false;
    }
  }
}
