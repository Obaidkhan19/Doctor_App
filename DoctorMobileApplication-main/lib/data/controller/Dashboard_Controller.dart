import 'dart:async';
import 'dart:developer';

import 'package:doctormobileapplication/data/repositories/specialities_repo/specialities_repo.dart';
import 'package:doctormobileapplication/models/User_Model.dart';
import 'package:doctormobileapplication/models/search_models.dart';
import 'package:get/get.dart';

import '../../models/specialities_model.dart';

class DashboardController extends GetxController implements GetxService {
  UserData userData = UserData();

  List<Data> doctors = [];
  List<Search> searchDoctors = [];
  bool? isLoading = false;

  updateUserData(UserData userData) {
    userData = userData;
    update();
  }

  getSpecialities() async {
    isLoading = true;
    log(isLoading.toString());
    Specialities specialities = await SpecialitiesRepo.getSpecialities();
    doctors = specialities.data!;
    Timer(const Duration(milliseconds: 500), () {
      isLoading = false;
      update();
    });

    log(isLoading.toString());
    update();
  }

  Future<List<Search>> getDoctors(String id) async {
    SearchDoctors doctors = await SpecialitiesRepo().getSearchDoctors(id);
    searchDoctors = doctors.data!;
    return searchDoctors;
  }

  static DashboardController get i => Get.put(DashboardController());
}
