import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/doted_line.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
import 'package:doctormobileapplication/data/controller/preference_controller.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/profile/personal.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

  _getCountries() async {
    ProfileRepo pr = ProfileRepo();

    EditProfileController.i.updatecountriesList(
      await pr.getCountries(),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCountries();
    _getDoctorBasicInfo();
    Future.delayed(Duration.zero, () async {
      ProfileController.i.updateselectedindex(8);
    });
  }

  var profile = Get.put<ProfileController>(ProfileController());
  var edit = Get.put<EditProfileController>(EditProfileController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (contt) => BlurryModalProgressHUD(
        inAsyncCall: profile.isLoading,
        blurEffectIntensity: 4,
        progressIndicator: const SpinKitSpinningLines(
          color: Color(0xfff1272d3),
          size: 60,
        ),
        child: GetBuilder<ProfileController>(
          builder: (contr) => contr.editval
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
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              EditProfileCustomTextField(
                                validator: (p0) {
                                  if (p0!.isEmpty) {
                                    return 'enteyourDisplayEducation'.tr;
                                  }
                                  return null;
                                },
                                controller: edit.displayeducation,
                                hintText: 'DisplayEducation'.tr,
                              ),
                              EditProfileCustomTextField(
                                validator: (p0) {
                                  if (p0!.isEmpty) {
                                    return 'enteyourDisplayDesignation'.tr;
                                  }
                                  return null;
                                },
                                controller: edit.displaydesignation,
                                hintText: 'DisplayDesignation'.tr,
                              ),
                              EditProfileCustomTextField(
                                controller: edit.stamp,
                                hintText: 'stamp'.tr,
                              ),
                              EditProfileCustomTextField(
                                controller: edit.professionalsummary,
                                hintText: 'professionalSummary'.tr,
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Center(
                                child: Text(
                                  'EXRConfiguration'.tr,
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
                                hintText: 'topMargin'.tr,
                              ),
                              EditProfileCustomTextField(
                                controller: edit.bottommargin,
                                hintText: 'bottomMargin'.tr,
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
                                  bottom: Get.height * 0.03,
                                ),
                                child: const MySeparator(
                                  color: ColorManager.kWhiteColor,
                                ),
                              ),
                              EditProfileCustomTextField(
                                controller: edit.displayenglisheducation,
                                hintText: 'education'.tr,
                              ),
                              EditProfileCustomTextField(
                                controller: edit.displayenglishdesignation,
                                hintText: 'designation(s)'.tr,
                              ),
                              EditProfileCustomTextField(
                                controller: edit.displayenglishothers,
                                hintText: 'others'.tr,
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Center(
                                child: GetBuilder<PreferenceController>(
                                  builder: (cont) => Text(
                                    PreferenceController.i.preferenceObject
                                                .customLanguageKeyBoardType ==
                                            null
                                        ? Language
                                        : PreferenceController
                                                    .i
                                                    .preferenceObject
                                                    .customLanguageKeyBoardType ==
                                                "null"
                                            ? Language
                                            : PreferenceController
                                                        .i
                                                        .preferenceObject
                                                        .customLanguageKeyBoardType ==
                                                    0
                                                ? "urdu".tr
                                                : 'arabic'.tr,
                                    style: GoogleFonts.poppins(
                                      textStyle: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: ColorManager.kWhiteColor),
                                    ),
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
                                hintText: 'education'.tr,
                              ),
                              EditProfileCustomTextField(
                                controller: edit.displayurdudesignation,
                                hintText: 'designation(s)'.tr,
                              ),
                              EditProfileCustomTextField(
                                controller: edit.displayurduothers,
                                hintText: 'others'.tr,
                              ),
                              SizedBox(height: Get.height * 0.03),
                              InkWell(
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    ProfileRepo pr = ProfileRepo();

                                    String res = await pr
                                        .updatePrescriptionConfiguration(
                                            edit.displayeducation.text,
                                            edit.displaydesignation.text,
                                            edit.professionalsummary.text,
                                            edit.stamp.text,
                                            edit.topmargin.text,
                                            edit.bottommargin.text,
                                            edit.displayenglisheducation.text,
                                            edit.displayurdueducation.text,
                                            edit.displayenglishdesignation.text,
                                            edit.displayurduothers.text,
                                            edit.displayenglishothers.text,
                                            edit.displayurduothers.text);
                                    if (res == "true") {
                                      ProfileController.i.updateval(false);
                                      _getDoctorBasicInfo();
                                      setState(() {});
                                    }
                                  }
                                },
                                child: Container(
                                  height: Get.height * 0.07,
                                  width: Get.width * 1,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                      child: edit.isloading == false
                                          ? Text(
                                              'update'.tr,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      ColorManager.kWhiteColor),
                                            )
                                          : const CircularProgressIndicator(
                                              color: ColorManager.kWhiteColor,
                                            )),
                                ),
                              ),
                              SizedBox(height: Get.height * 0.03),
                            ],
                          ),
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
                          name:
                              profile.selectedbasicInfo?.userDisplayEducation ==
                                      ""
                                  ? "-"
                                  : profile.selectedbasicInfo
                                              ?.userDisplayEducation ==
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
                          name: profile.selectedbasicInfo
                                      ?.userDisplayDesignation ==
                                  ""
                              ? "-"
                              : profile.selectedbasicInfo
                                          ?.userDisplayDesignation ==
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
                          name:
                              profile.selectedbasicInfo?.professionalSummary ==
                                      ""
                                  ? "-"
                                  : profile.selectedbasicInfo
                                              ?.professionalSummary ==
                                          null
                                      ? "-"
                                      : profile.selectedbasicInfo
                                              ?.professionalSummary ??
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
                          name:
                              profile.selectedbasicInfo?.marginTop.toString() ==
                                      ""
                                  ? "-"
                                  : profile.selectedbasicInfo?.marginTop
                                              .toString() ==
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
                          name: profile.selectedbasicInfo?.marginBottom
                                      .toString() ==
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
                          name: profile.selectedbasicInfo?.educationEnglish ==
                                  ""
                              ? "-"
                              : profile.selectedbasicInfo?.educationEnglish ==
                                      null
                                  ? "-"
                                  : profile.selectedbasicInfo
                                          ?.educationEnglish ??
                                      "-",
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        ProfileRecordWidget(
                          title: "designation".tr,
                          name: profile.selectedbasicInfo?.designationEnglish ==
                                  ""
                              ? "-"
                              : profile.selectedbasicInfo?.designationEnglish ==
                                      null
                                  ? "-"
                                  : profile.selectedbasicInfo
                                          ?.designationEnglish ??
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
                                  : profile.selectedbasicInfo?.othersEnglish ??
                                      "-",
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Center(
                          child: GetBuilder<PreferenceController>(
                            builder: (cont) => Text(
                              PreferenceController.i.preferenceObject
                                          .customLanguageKeyBoardType ==
                                      null
                                  ? Language
                                  : PreferenceController.i.preferenceObject
                                              .customLanguageKeyBoardType ==
                                          "null"
                                      ? Language
                                      : PreferenceController.i.preferenceObject
                                                  .customLanguageKeyBoardType ==
                                              0
                                          ? "urdu".tr
                                          : 'arabic'.tr,
                              style: GoogleFonts.poppins(
                                textStyle: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: ColorManager.kWhiteColor),
                              ),
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
                                  : profile.selectedbasicInfo?.educationUrdu ??
                                      "-",
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        ProfileRecordWidget(
                          title: "designation".tr,
                          name: profile.selectedbasicInfo?.designationUrdu == ""
                              ? "-"
                              : profile.selectedbasicInfo?.designationUrdu ==
                                      null
                                  ? "-"
                                  : profile
                                          .selectedbasicInfo?.designationUrdu ??
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
                                  : profile.selectedbasicInfo?.othersUrdu ??
                                      "-",
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
                              ProfileController.i.updateval(true);
                              profile.updateisEdit(true);
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
        ),
      ),
    );
  }
}
