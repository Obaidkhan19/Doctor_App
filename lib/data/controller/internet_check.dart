import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity connectivity = Connectivity();
  @override
  void onInit() {
    super.onInit();
    connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      log('no internet connection error');
      Get.rawSnackbar(
          messageText: Text('PLEASECONNECTTOTHEINTERNET'.tr,
              style: const TextStyle(color: Colors.white, fontSize: 14)),
          isDismissible: false,
          duration: const Duration(days: 1),
          backgroundColor: Colors.red[400]!,
          icon: const Icon(
            Icons.wifi_off,
            color: Colors.white,
            size: 35,
          ),
          margin: EdgeInsets.zero,
          snackPosition: SnackPosition.TOP,
          snackStyle: SnackStyle.GROUNDED);
    } else {
      if (Get.isSnackbarOpen) {
        log(' internet  ok');
        Get.closeCurrentSnackbar();
      }
    }
  }

  static NetworkController get i => Get.put(NetworkController());
}
