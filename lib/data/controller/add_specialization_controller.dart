import 'package:doctormobileapplication/models/speciality.dart';
import 'package:get/get.dart';

class AddSpecializationController extends GetxController
    implements GetxService {
  static AddSpecializationController get i =>
      Get.put(AddSpecializationController());

  List<Specialities1> addspecialitiesList = [];
  Specialities1? addselectedspecialities;
  updateaddspecialitiesList(List<Specialities1> slist) {
    addspecialitiesList = slist;
    update();
  }

  updateaddselectedspeciality(Specialities1 s) {
    addselectedspecialities = s;
    update();
  }

  List<Specialities1> addsubspecialitiesList = [];
  Specialities1? addselectedsubspecialities;

  updateaddsubspecialitiesList(List<Specialities1> slist) {
    addsubspecialitiesList = slist;
    update();
  }

  updateaddselectedsubspeciality(Specialities1 s) {
    addselectedsubspecialities = s;
    update();
  }
}
