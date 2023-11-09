import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/doted_line.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/profile/edit_prescription_configuration.dart';
import 'package:doctormobileapplication/screens/profile/personal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PrescriptionConfiguration extends StatefulWidget {
  const PrescriptionConfiguration({super.key});

  @override
  State<PrescriptionConfiguration> createState() =>
      _PrescriptionConfigurationState();
}

class _PrescriptionConfigurationState extends State<PrescriptionConfiguration> {
  _getDoctorBasicInfo() async {
    ProfileRepo pr = ProfileRepo();
    await pr.getDoctorBasicInfo();
  }

  var profile = Get.put<ProfileController>(ProfileController());
  var edit = Get.put<EditProfileController>(EditProfileController());
  bool val = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (contr) => val
          ? Container(
              height: Get.height * 1,
              color: ColorManager.kPrimaryColor,
              padding: EdgeInsets.only(
                top: Get.height * 0.02,
                left: Get.width * 0.02,
                right: Get.width * 0.02,
              ),
              child: GetBuilder<EditProfileController>(
                builder: (contr) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
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
                                  color: ColorManager.kWhiteColor),
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
                            color: ColorManager.kWhiteColor,
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
                                  color: ColorManager.kWhiteColor),
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
                            color: ColorManager.kWhiteColor,
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
                                  color: ColorManager.kWhiteColor),
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
                            color: ColorManager.kWhiteColor,
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
                              val = false;
                              _getDoctorBasicInfo();
                              setState(() {});
                            },
                            color: Colors.white.withOpacity(0.7),
                            textcolor: ColorManager.kWhiteColor),
                        SizedBox(height: Get.height * 0.03),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : Container(
              padding: EdgeInsets.only(top: Get.height * 0.04),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProfileRecordWidget(
                      title: "education".tr,
                      name: profile.selectedbasicInfo?.userDisplayEducation ==
                              ""
                          ? "-"
                          : profile.selectedbasicInfo?.userDisplayEducation ==
                                  null
                              ? "-"
                              : profile.selectedbasicInfo
                                      ?.userDisplayEducation ??
                                  "-",
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    ProfileRecordWidget(
                      title: "designation".tr,
                      name: profile.selectedbasicInfo?.userDisplayDesignation ==
                              ""
                          ? "-"
                          : profile.selectedbasicInfo?.userDisplayDesignation ==
                                  null
                              ? "-"
                              : profile.selectedbasicInfo
                                      ?.userDisplayDesignation ??
                                  "-",
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    ProfileRecordWidget(
                      title: "stamp".tr,
                      name: profile.selectedbasicInfo?.stamp == ""
                          ? "-"
                          : profile.selectedbasicInfo?.stamp == null
                              ? "-"
                              : profile.selectedbasicInfo?.stamp ?? "-",
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    ProfileRecordWidget(
                      title: "professionalSummary".tr,
                      name: profile.selectedbasicInfo?.professionalSummary == ""
                          ? "-"
                          : profile.selectedbasicInfo?.professionalSummary ==
                                  null
                              ? "-"
                              : profile
                                      .selectedbasicInfo?.professionalSummary ??
                                  "-",
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Center(
                      child: Text(
                        'ERXConfiguration'.tr,
                        style: GoogleFonts.poppins(
                          textStyle: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.kWhiteColor),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: Get.width * 0.02,
                        right: Get.width * 0.02,
                        top: Get.height * 0.01,
                        bottom: Get.height * 0.01,
                      ),
                      child: const MySeparator(
                        color: ColorManager.kWhiteColor,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    ProfileRecordWidget(
                      title: "topMargin".tr,
                      name: profile.selectedbasicInfo?.marginTop.toString() ==
                              ""
                          ? "-"
                          : profile.selectedbasicInfo?.marginTop.toString() ==
                                  null
                              ? "-"
                              : profile.selectedbasicInfo?.marginTop
                                      .toString() ??
                                  "-",
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    ProfileRecordWidget(
                      title: "bottomMargin".tr,
                      name:
                          profile.selectedbasicInfo?.marginBottom.toString() ==
                                  ""
                              ? "-"
                              : profile.selectedbasicInfo?.marginBottom
                                          .toString() ==
                                      null
                                  ? "-"
                                  : profile.selectedbasicInfo?.marginBottom
                                          .toString() ??
                                      "-",
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Center(
                      child: Text(
                        'english'.tr,
                        style: GoogleFonts.poppins(
                          textStyle: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.kWhiteColor),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: Get.width * 0.02,
                        right: Get.width * 0.02,
                        top: Get.height * 0.01,
                        bottom: Get.height * 0.01,
                      ),
                      child: const MySeparator(
                        color: ColorManager.kWhiteColor,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    ProfileRecordWidget(
                      title: "education".tr,
                      name: profile.selectedbasicInfo?.educationEnglish == ""
                          ? "-"
                          : profile.selectedbasicInfo?.educationEnglish == null
                              ? "-"
                              : profile.selectedbasicInfo?.educationEnglish ??
                                  "-",
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    ProfileRecordWidget(
                      title: "designation".tr,
                      name: profile.selectedbasicInfo?.designationEnglish == ""
                          ? "-"
                          : profile.selectedbasicInfo?.designationEnglish ==
                                  null
                              ? "-"
                              : profile.selectedbasicInfo?.designationEnglish ??
                                  "-",
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    ProfileRecordWidget(
                      title: "others".tr,
                      name: profile.selectedbasicInfo?.othersEnglish == ""
                          ? "-"
                          : profile.selectedbasicInfo?.othersEnglish == null
                              ? "-"
                              : profile.selectedbasicInfo?.othersEnglish ?? "-",
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Center(
                      child: Text(
                        'arabic'.tr,
                        style: GoogleFonts.poppins(
                          textStyle: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.kWhiteColor),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: Get.width * 0.02,
                        right: Get.width * 0.02,
                        top: Get.height * 0.01,
                        bottom: Get.height * 0.01,
                      ),
                      child: const MySeparator(
                        color: ColorManager.kWhiteColor,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    ProfileRecordWidget(
                      title: "education".tr,
                      name: profile.selectedbasicInfo?.educationUrdu == ""
                          ? "-"
                          : profile.selectedbasicInfo?.educationUrdu == null
                              ? "-"
                              : profile.selectedbasicInfo?.educationUrdu ?? "-",
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    ProfileRecordWidget(
                      title: "designation".tr,
                      name: profile.selectedbasicInfo?.designationUrdu == ""
                          ? "-"
                          : profile.selectedbasicInfo?.designationUrdu == null
                              ? "-"
                              : profile.selectedbasicInfo?.designationUrdu ??
                                  "-",
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    ProfileRecordWidget(
                      title: "others".tr,
                      name: profile.selectedbasicInfo?.othersUrdu == ""
                          ? "-"
                          : profile.selectedbasicInfo?.othersUrdu == null
                              ? "-"
                              : profile.selectedbasicInfo?.othersUrdu ?? "-",
                    ),
                    SizedBox(
                      height: Get.height * 0.04,
                    ),
                    PrimaryButton(
                        width: Get.width * 0.6,
                        height: Get.height * 0.06,
                        fontSize: 15,
                        title: "edit".tr,
                        onPressed: () async {
                          val = true;
                          setState(() {});
                          // var result = await Get.to(
                          //     () => const EditPrescriptionConfiguration());
                          // if (result == true) {
                          //   _getDoctorBasicInfo();
                          // }
                        },
                        color: ColorManager.kWhiteColor,
                        textcolor: ColorManager.kPrimaryColor),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
