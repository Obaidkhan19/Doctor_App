import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletController extends GetxController implements GetxService {
  late TextEditingController cardNo;
  late TextEditingController cardHolderName;
  late TextEditingController amount;

  late TextEditingController expiry;
  late TextEditingController cvv;
  late TextEditingController otheramountController;
  @override
  void onInit() {
    cardNo = TextEditingController();
    cardHolderName = TextEditingController();
    amount = TextEditingController();
    expiry = TextEditingController();
    cvv = TextEditingController();
    otheramountController = TextEditingController();
    super.onInit();
  }

  // String amount = '';

  int selectedContainerIndex = -1;
  List<String> containerValues = ['AED 1,000', 'AED 2,000', 'AED 3,000'];

  updateindex(index) {
    selectedContainerIndex = index;
    update();
  }

  bool otheramount = false;
  updateotheramount() {
    otheramount = !otheramount;
    selectedContainerIndex = -1;
    update();
  }

  disposeother() {
    otheramount = false;
    otheramountController.clear();
    update();
  }

  static WalletController get i => Get.put(WalletController());
}
