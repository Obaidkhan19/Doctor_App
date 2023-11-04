import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/doted_line.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EditPrescriptionConfiguration extends StatefulWidget {
  const EditPrescriptionConfiguration({super.key});

  @override
  State<EditPrescriptionConfiguration> createState() =>
      _EditPrescriptionConfigurationState();
}

class _EditPrescriptionConfigurationState
    extends State<EditPrescriptionConfiguration> {
  var edit = Get.put<EditProfileController>(EditProfileController());
  _getDoctorBasicInfo() async {
    ProfileRepo pr = ProfileRepo();
    await pr.getDoctorBasicInfo();
  }

  @override
  void initState() {
    // TODO: implement initState
    _getDoctorBasicInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: ColorManager.kPrimaryColor,
          onPressed: () {
            Get.back(result: true);
          },
        ),
        title: Text(
          'Edit Prescription Configuration',
          style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: ColorManager.kPrimaryColor),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<EditProfileController>(
        builder: (contr) => Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
          child: SingleChildScrollView(
            child: Column(
              children: [
                EditProfileCustomTextField(
                  controller: edit.displayeducation,
                  hintText: 'Display Education'.tr,
                ),
                EditProfileCustomTextField(
                  controller: edit.displaydesignation,
                  hintText: 'Display Designation'.tr,
                ),
                EditProfileCustomTextField(
                  controller: edit.stamp,
                  hintText: 'Stamp'.tr,
                ),
                EditProfileCustomTextField(
                  controller: edit.professionalsummary,
                  hintText: 'Professional Summary'.tr,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Center(
                  child: Text(
                    'EXR Configuration',
                    style: GoogleFonts.poppins(
                      textStyle: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.kPrimaryColor),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: Get.width * 0.02,
                    right: Get.width * 0.02,
                    top: Get.height * 0.01,
                    bottom: Get.height * 0.03,
                  ),
                  child: const MySeparator(
                    color: ColorManager.kPrimaryColor,
                  ),
                ),
                EditProfileCustomTextField(
                  controller: edit.topmargin,
                  hintText: 'Top Margin'.tr,
                ),
                EditProfileCustomTextField(
                  controller: edit.bottommargin,
                  hintText: 'Bottom Margin'.tr,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Center(
                  child: Text(
                    'English',
                    style: GoogleFonts.poppins(
                      textStyle: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.kPrimaryColor),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: Get.width * 0.02,
                    right: Get.width * 0.02,
                    top: Get.height * 0.01,
                    bottom: Get.height * 0.03,
                  ),
                  child: const MySeparator(
                    color: ColorManager.kPrimaryColor,
                  ),
                ),
                EditProfileCustomTextField(
                  controller: edit.displayenglisheducation,
                  hintText: 'Education'.tr,
                ),
                EditProfileCustomTextField(
                  controller: edit.displayenglishdesignation,
                  hintText: 'Designation(s)'.tr,
                ),
                EditProfileCustomTextField(
                  controller: edit.displayenglishothers,
                  hintText: 'Others'.tr,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Center(
                  child: Text(
                    'Arabic',
                    style: GoogleFonts.poppins(
                      textStyle: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.kPrimaryColor),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: Get.width * 0.02,
                    right: Get.width * 0.02,
                    top: Get.height * 0.01,
                    bottom: Get.height * 0.03,
                  ),
                  child: const MySeparator(
                    color: ColorManager.kPrimaryColor,
                  ),
                ),
                EditProfileCustomTextField(
                  controller: edit.displayurdueducation,
                  hintText: 'Education'.tr,
                ),
                EditProfileCustomTextField(
                  controller: edit.displayurdudesignation,
                  hintText: 'Designation(s)'.tr,
                ),
                EditProfileCustomTextField(
                  controller: edit.displayurduothers,
                  hintText: 'Others'.tr,
                ),
                SizedBox(height: Get.height * 0.03),
                PrimaryButton(
                    fontSize: 15,
                    title: 'update'.tr,
                    onPressed: () async {
                      ProfileRepo pr = ProfileRepo();
                      // String res = await pr.updateContact(
                      //   );
                      // if (res == "true") {
                      //   Get.back(result: true);
                      // }

                      Get.back(result: true);
                    },
                    color: ColorManager.kPrimaryColor,
                    textcolor: ColorManager.kWhiteColor),
                SizedBox(height: Get.height * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
