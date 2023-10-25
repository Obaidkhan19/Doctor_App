import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditConfigureAppointmentController extends GetxController
    implements GetxService {
  static EditConfigureAppointmentController get i =>
      Get.put(EditConfigureAppointmentController());
  TextEditingController consultancyfeeController = TextEditingController();
  TextEditingController followupfeeController = TextEditingController();
  TextEditingController followupdayController = TextEditingController();

  String getDayName(int index) {
    switch (index) {
      case 0:
        return 'monday'.tr;
      case 1:
        return 'tuesday'.tr;
      case 2:
        return 'wednesday'.tr;
      case 3:
        return 'thursday'.tr;
      case 4:
        return 'friday'.tr;
      case 5:
        return 'saturday'.tr;
      case 6:
        return 'sunday'.tr;
      default:
        return '';
    }
  }

  List<int> daylst = [];

  addintodays(int index) {
    daylst.add(index);
    update();
  }

  deletefromdays(int index) {
    daylst.removeAt(index);
    update();
  }

  List<bool> switchStates = [false, false, false, false, false, false, false];
  List<List<Widget>> dayRows = [
    [],
    [],
    [],
    [],
    [],
    [],
    [],
  ];
  void toggleSwitch(int index) {
    switchStates[index] = !switchStates[index];
    update();
  }

  List<EditApprovalCriteria> approvalCriteriaList = [
    EditApprovalCriteria(1, 'Approved By PA Only'),
    EditApprovalCriteria(2, 'Approved By Doctor Only'),
    EditApprovalCriteria(3, 'Approved By PA and Doctor'),
    EditApprovalCriteria(4, 'Auto Approved'),
  ];

  EditApprovalCriteria? selectedApprovalCriteria;

  void initializeSelectedApprovalCriteria() {
    selectedApprovalCriteria = approvalCriteriaList[0];
  }

  void updateApprovalCriteria(EditApprovalCriteria criteria) {
    selectedApprovalCriteria = criteria;
  }
}

class EditApprovalCriteria {
  int id;
  String name;

  EditApprovalCriteria(this.id, this.name);
}
