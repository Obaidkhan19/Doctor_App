import 'package:doctormobileapplication/data/controller/ManageAppointments_Controller.dart';
import 'package:doctormobileapplication/data/controller/language_controller.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/controller/registration_controller.dart';
import 'package:get/get.dart';
import 'package:doctormobileapplication/data/controller/auth_controller.dart';
import 'package:doctormobileapplication/data/controller/google_maps_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<ProfileController>(ProfileController());
    Get.put<AddressController>(AddressController());
    Get.put<AuthController>(AuthController());
    Get.put<LanguageController>(LanguageController());
    Get.put<ManageAppointmentController>(ManageAppointmentController());
  }
}
