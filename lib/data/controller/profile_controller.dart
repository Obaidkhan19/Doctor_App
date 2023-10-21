import 'package:doctormobileapplication/models/doctor_details.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController implements GetxService {
  static ProfileController get i => Get.put(ProfileController());

  int pageIndex = 2;
  var status = "iamoffline".tr;
  var value = 0;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  updateIsloading(bool value) {
    _isLoading = value;
    update();
  }

Specialities? mainspeciality;
 updatemainspeciality(Specialities data){
  mainspeciality=data;
  update();
}

  List<Specialities> specialities=[];
  updatespecialitites(List<Specialities> data){
    specialities=data;
    update();
  }


  BasicInfo? selectedbasicInfo;
  updatedDoctorInfo(BasicInfo bi) {
    selectedbasicInfo = bi;

    update();
  }
}
