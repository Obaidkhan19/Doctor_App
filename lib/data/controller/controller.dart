import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FamilyScreensController extends GetxController implements GetxService {
  static DateTime? arrival = DateTime.now();
  RxString? formatArrival = DateFormat.yMMMd().format(arrival!).obs;

  RxString? todayDate = DateFormat.yMMMd().format(arrival!).obs;

  Future<void> selectDateAndTime(
    BuildContext context,
    DateTime? date,
    RxString? formattedDate,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        confirmText: 'Ok',
        initialDate: date!,
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != date) {
      date = pickedDate;
      formattedDate!.value = DateFormat.yMMMd().format(date);

      update();
    }
  }

  static FamilyScreensController get i => Get.put(FamilyScreensController());
}
