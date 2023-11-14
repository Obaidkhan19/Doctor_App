import 'package:doctormobileapplication/models/degree.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBankController extends GetxController implements GetxService {
  static AddBankController get i => Get.put(AddBankController());

  late TextEditingController accountTitle;
  late TextEditingController accountNo;

  @override
  void onInit() {
    accountNo = TextEditingController();
    accountTitle = TextEditingController();
    super.onInit();
  }

  List<Degrees> addbankList = [];
  Degrees? addselectedbank = Degrees();
  updatedaddbankList(List<Degrees> blist) {
    addbankList = blist;
    update();
  }

  updateaddselectedbank(Degrees bank) {
    addselectedbank = bank;
    update();
  }

  PlatformFile? bankfile;
  Future<void> picksingleBankfile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      bankfile = result.files.first;
    }
  }
}
