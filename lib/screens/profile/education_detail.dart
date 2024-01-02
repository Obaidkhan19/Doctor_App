import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:doctormobileapplication/components/image_container.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/data/controller/add_education_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/models/doctor_details.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/components/searchable_dropdown.dart';
import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
import 'package:doctormobileapplication/models/countries_model.dart';
import 'package:doctormobileapplication/models/degree.dart';
import 'package:doctormobileapplication/models/institutes.dart';
import 'package:intl/intl.dart';

class EducationDetail extends StatefulWidget {
  const EducationDetail({super.key});

  @override
  State<EducationDetail> createState() => _EducationDetailState();
}

class _EducationDetailState extends State<EducationDetail> {
  _getDoctorBasicInfo() async {
    ProfileRepo pr = ProfileRepo();
    await pr.getDoctorBasicInfo();
  }

  var edit = Get.put<EditProfileController>(EditProfileController());
  var add = Get.put<AddEducationController>(AddEducationController());
  _getCountries() async {
    ProfileRepo pr = ProfileRepo();
    EditProfileController.i.updatecountriesList(
      await pr.getCountries(),
    );
  }

  _getaddCountries() async {
    ProfileRepo pr = ProfileRepo();
    AddEducationController.i.updateeducationaddcountriesList(
      await pr.getCountries(),
    );
  }

  _getaddInstitution(cid) async {
    ProfileRepo pr = ProfileRepo();
    AddEducationController.i.updateeducationaddinstitutionlist(
      await pr.getInstitution(cid),
    );
  }

  _getaddDegrees() async {
    ProfileRepo pr = ProfileRepo();
    AddEducationController.i.updatededucationaddegreesList(
      await pr.getDegree(),
    );
  }

  _getInstitution(cid) async {
    ProfileRepo pr = ProfileRepo();
    EditProfileController.i.updateinstitutionlist(
      await pr.getInstitution(cid),
    );
  }

  _getDegrees() async {
    ProfileRepo pr = ProfileRepo();
    EditProfileController.i.updatedegreesList(
      await pr.getDegree(),
    );
  }

  _getaddFieldofStudies() async {
    ProfileRepo pr = ProfileRepo();
    AddEducationController.i.updateeducationaddfieldofstudyList(
      await pr.getFieldofStudy(),
    );
  }

  _getFieldofStudies() async {
    ProfileRepo pr = ProfileRepo();
    EditProfileController.i.updatefieldofstudyList(
      await pr.getFieldofStudy(),
    );
  }

  @override
  void initState() {
    _getInstitution(EditProfileController.i.educationselectedCountry?.id);
    _getCountries();
    _getaddCountries();
    _getaddFieldofStudies();
    _getaddDegrees();
    _getDoctorBasicInfo();
    _getDegrees();
    _getFieldofStudies();
    Future.delayed(Duration.zero, () async {
      ProfileController.i.updateselectedindex(2);
    });
    super.initState();
  }

  var profile = Get.put<ProfileController>(ProfileController());

  var education = Get.put<ProfileController>(ProfileController());
  final GlobalKey<FormState> _addformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _editformKey = GlobalKey<FormState>();
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
                        child: SingleChildScrollView(
                          child: Form(
                            key: _editformKey,
                            child: Column(
                              children: [
                                EditProfileCustomTextField(
                                  validator: (p0) {
                                    if (edit.educationselectedCountry!.id ==
                                        null) {
                                      return 'pleaseselectyourcountry'.tr;
                                    }
                                    return null;
                                  },
                                  onTap: () async {
                                    Countries generic =
                                        await searchabledropdown(
                                            context, edit.countriesList);
                                    edit.educationselectedCountry = null;
                                    edit.updateeducationselectedCountry(
                                        generic);

                                    if (generic != '') {
                                      edit.educationselectedCountry = generic;
                                      edit.educationselectedCountry =
                                          (generic == '')
                                              ? null
                                              : edit.educationselectedCountry;
                                    }
                                    String cid = edit
                                            .educationselectedCountry?.id
                                            .toString() ??
                                        "";
                                    setState(() {
                                      _getInstitution(cid);
                                    });
                                  },
                                  readonly: true,
                                  hintText:
                                      edit.educationselectedCountry?.name == ""
                                          ? 'country'.tr
                                          : edit.educationselectedCountry
                                                  ?.name ??
                                              "Selectcountry".tr,
                                ),
                                EditProfileCustomTextField(
                                  validator: (p0) {
                                    if (edit.selectedinstitution!.id == null) {
                                      return 'Selectyourinstitution'.tr;
                                    }
                                    return null;
                                  },
                                  onTap: () async {
                                    Institutions generic =
                                        await searchabledropdown(
                                            context, edit.institutionList);
                                    edit.selectedinstitution = null;
                                    edit.updateselectedInstitution(generic);

                                    if (generic != '') {
                                      edit.selectedinstitution = generic;
                                      edit.selectedinstitution = (generic == '')
                                          ? null
                                          : edit.selectedinstitution;
                                    }
                                  },
                                  readonly: true,
                                  hintText: edit.selectedinstitution?.name == ""
                                      ? 'Institution'.tr
                                      : edit.selectedinstitution?.name ??
                                          "SelectInstitution".tr,
                                ),
                                EditProfileCustomTextField(
                                  validator: (p0) {
                                    if (edit.selecteddegree!.id == null) {
                                      return 'SelectyourDegree'.tr;
                                    }
                                    return null;
                                  },
                                  onTap: () async {
                                    Degrees generic = await searchabledropdown(
                                        context, edit.degreesList);
                                    edit.selecteddegree = null;
                                    edit.updateselecteddegree(generic);

                                    if (generic.id != null) {
                                      edit.selecteddegree = generic;
                                      edit.selecteddegree = (generic.id == null)
                                          ? null
                                          : edit.selecteddegree;
                                    }
                                  },
                                  readonly: true,
                                  hintText: edit.selecteddegree?.name == ""
                                      ? 'degree'.tr
                                      : edit.selecteddegree?.name ??
                                          "SelectDegree".tr,
                                ),
                                EditProfileCustomTextField(
                                  onTap: () async {
                                    Degrees generic = await searchabledropdown(
                                        context, edit.fieldofstudyList);
                                    edit.selectedfieldofstudy = null;
                                    edit.updateselectedfieldofstudy(generic);

                                    if (generic != '') {
                                      edit.selectedfieldofstudy = generic;
                                      edit.selectedfieldofstudy =
                                          (generic == '')
                                              ? null
                                              : edit.selectedfieldofstudy;
                                    }
                                  },
                                  readonly: true,
                                  hintText:
                                      edit.selectedfieldofstudy?.name == ""
                                          ? 'FieldofStudy'.tr
                                          : edit.selectedfieldofstudy?.name ??
                                              "SelectFieldofStudy".tr,
                                ),
                                EditProfileCustomTextField(
                                    isSizedBoxAvailable: false,
                                    onTap: () async {
                                      await edit
                                          .selecteducationstartDateAndTime(
                                              context,
                                              EditProfileController.degreestart,
                                              edit.formatedegreestart);
                                    },
                                    readonly: true,
                                    hintText:
                                        edit.educationstartdatetextvisible ==
                                                true
                                            ? "SelectStartDate".tr
                                            : edit.formatteddegreestart
                                                .toString()
                                                .split("T")[0]),
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                      side: MaterialStateBorderSide.resolveWith(
                                        (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.selected)) {
                                            return const BorderSide(
                                                color: Colors.white);
                                          }
                                          return const BorderSide(
                                              color: Colors.white);
                                        },
                                      ),
                                      value: edit.inprogressisChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          edit.inprogressisChecked = value!;
                                        });
                                      },
                                      checkColor: ColorManager.kWhiteColor,
                                      activeColor: ColorManager.kPrimaryColor,
                                    ),
                                    Text(
                                      'InProgress'.tr,
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: ColorManager.kWhiteColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: edit.inprogressisChecked == false,
                                  child: EditProfileCustomTextField(
                                      onTap: () async {
                                        edit.selecteducationendDateAndTime(
                                            context,
                                            EditProfileController.degreeend,
                                            edit.formatedegreeend);
                                      },
                                      readonly: true,
                                      hintText:
                                          edit.educationenddatetextvisible ==
                                                  true
                                              ? "SelectEndDate".tr
                                              : edit.formatteddegreeend
                                                  .toString()
                                                  .split("T")[0]),
                                ),

                                Visibility(
                                  visible: edit.inprogressisChecked == false,
                                  child: EditProfileCustomTextField(
                                      onTap: () async {
                                        edit.selecteducationissueDateAndTime(
                                            context,
                                            EditProfileController.degreeissue,
                                            edit.formatedegreeissue);
                                      },
                                      readonly: true,
                                      hintText:
                                          edit.educationissuedatetextvisible ==
                                                  true
                                              ? "SelectIssueDate".tr
                                              : edit.formatteddegreeissue
                                                  .toString()
                                                  .split("T")[0]),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'GradingScale'.tr,
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: ColorManager.kWhiteColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Radio(
                                      fillColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                        return (edit.radioselectedValue ==
                                                "CGPA")
                                            ? Colors.white
                                            : Colors.white;
                                      }),
                                      focusColor: ColorManager.kDarkBlue,
                                      value: "CGPA",
                                      groupValue: edit.radioselectedValue,
                                      onChanged: (value) {
                                        edit.updateradiovalue(value.toString());
                                      },
                                      activeColor: ColorManager.kWhiteColor,
                                    ),
                                    Text(
                                      "CGPA".tr,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: ColorManager.kWhiteColor,
                                      ),
                                    ),
                                    Radio(
                                      value: "Marks",
                                      fillColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                        return (edit.radioselectedValue ==
                                                "Marks")
                                            ? Colors.white
                                            : Colors.white;
                                      }),
                                      groupValue: edit.radioselectedValue,
                                      onChanged: (value) {
                                        edit.updateradiovalue(value.toString());
                                      },
                                      activeColor: ColorManager.kWhiteColor,
                                    ),
                                    Text(
                                      "Marks".tr,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: ColorManager.kWhiteColor,
                                      ),
                                    ),
                                    Radio(
                                      fillColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                        return (edit.radioselectedValue ==
                                                "Percentage")
                                            ? Colors.white
                                            : Colors.white;
                                      }),
                                      value: "Percentage",
                                      groupValue: edit.radioselectedValue,
                                      onChanged: (value) {
                                        edit.updateradiovalue(value.toString());
                                      },
                                      activeColor: ColorManager.kWhiteColor,
                                    ),
                                    Text(
                                      "Percentage".tr,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: ColorManager.kWhiteColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: edit.radioselectedValue == "CGPA" ||
                                      edit.radioselectedValue == "Marks",
                                  child: EditProfileCustomTextField(
                                    controller: edit.totalmarks,
                                    hintText: 'Total'.tr,
                                    keyboardTypenew: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d*\.?\d{0,2}')),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: edit.radioselectedValue == "CGPA" ||
                                      edit.radioselectedValue == "Marks",
                                  child: EditProfileCustomTextField(
                                    controller: edit.obtainedmarks,
                                    hintText: 'Obtained'.tr,
                                    keyboardTypenew: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d*\.?\d{0,2}')),
                                    ],
                                  ),
                                ),
                                EditProfileCustomTextField(
                                  controller: edit.percentage,
                                  hintText: 'Percentage'.tr,
                                  keyboardTypenew: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d*\.?\d{0,2}')),
                                  ],
                                ),
                                SizedBox(height: Get.height * 0.03),

                                InkWell(
                                  onTap: () async {
                                    edit.updateisloading(true);
                                    if (_editformKey.currentState!.validate()) {
                                      bool inprogress = false;
                                      if (edit.inprogressisChecked == true) {
                                        edit.formatteddegreeend = null;
                                        edit.formatteddegreeissue = null;
                                        inprogress = true;
                                      } else {
                                        inprogress = false;
                                      }

                                      int gradingscale = 1;
                                      if (edit.radioselectedValue == "CGPA") {
                                        gradingscale = 1;
                                      } else if (edit.radioselectedValue ==
                                          "Marks") {
                                        gradingscale = 2;
                                      } else if (edit.radioselectedValue ==
                                          "Percentage") {
                                        gradingscale = 3;
                                      } else {
                                        gradingscale = 1;
                                      }

                                      if (edit.formatteddegreeend ==
                                          DateTime.now().toString()) {
                                        edit.formatteddegreeend = "";
                                      }
                                      if (edit.formatteddegreeissue ==
                                          DateTime.now().toString()) {
                                        edit.formatteddegreeissue = "";
                                      }
                                      ProfileRepo pr = ProfileRepo();
                                      String res = await pr.editEducation(
                                          edit.editselectededucationid,
                                          edit.educationselectedCountry?.id,
                                          edit.selectedinstitution?.id,
                                          edit.selecteddegree?.id,
                                          edit.selectedfieldofstudy?.id,
                                          edit.formatteddegreestart,
                                          edit.formatteddegreeend ?? "",
                                          edit.formatteddegreeissue ?? "",
                                          inprogress,
                                          gradingscale,
                                          edit.totalmarks.text,
                                          edit.obtainedmarks.text,
                                          edit.percentage.text);

                                      if (res == "true") {
                                        _getDoctorBasicInfo();
                                        ProfileController.i.updateval(false);
                                        edit.inprogressisChecked = false;
                                        edit.updateisloading(false);
                                        setState(() {});
                                      }
                                      edit.updateisloading(false);
                                    }
                                    edit.updateisloading(false);
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
                                                'edit'.tr,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: ColorManager
                                                        .kWhiteColor),
                                              )
                                            : const CircularProgressIndicator(
                                                color: ColorManager.kWhiteColor,
                                              )),
                                  ),
                                ),
                                // PrimaryButton(
                                //     fontSize: 15,
                                //     title: 'edit'.tr,
                                //     onPressed: () async {
                                //       if (_editformKey.currentState!
                                //           .validate()) {
                                //         ProfileController.i.updateval(false);
                                //         setState(() {});
                                //       }
                                //     },
                                //     color: Colors.white.withOpacity(0.7),
                                //     textcolor: ColorManager.kWhiteColor),
                                SizedBox(height: Get.height * 0.03),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : contr.addval
                    ? Container(
                        height: Get.height * 1,
                        color: ColorManager.kPrimaryColor,
                        padding: EdgeInsets.only(
                          top: Get.height * 0.02,
                          left: Get.width * 0.02,
                          right: Get.width * 0.02,
                        ),
                        child: GetBuilder<AddEducationController>(
                          builder: (contr) => Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.02),
                            child: SingleChildScrollView(
                              child: Form(
                                key: _addformKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    EditProfileCustomTextField(
                                      validator: (p0) {
                                        if (add.selectededucationaddcountry!
                                                .id ==
                                            null) {
                                          return 'pleaseselectyourcountry'.tr;
                                        }
                                        return null;
                                      },
                                      onTap: () async {
                                        Countries generic =
                                            await searchabledropdown(context,
                                                add.educationaddcountriesList);
                                        add.selectededucationaddcountry = null;
                                        add.updateselectededucationaddCountry(
                                            generic);

                                        if (generic != '') {
                                          add.selectededucationaddcountry =
                                              generic;
                                          add.selectededucationaddcountry =
                                              (generic == '')
                                                  ? null
                                                  : add
                                                      .selectededucationaddcountry;
                                        }
                                        String cid = add
                                                .selectededucationaddcountry?.id
                                                .toString() ??
                                            "";
                                        setState(() {
                                          _getaddInstitution(cid);
                                        });
                                      },
                                      readonly: true,
                                      hintText: add.selectededucationaddcountry
                                                  ?.name ==
                                              ""
                                          ? 'country'.tr
                                          : add.selectededucationaddcountry
                                                  ?.name ??
                                              "Selectcountry".tr,
                                    ),
                                    EditProfileCustomTextField(
                                      validator: (p0) {
                                        if (add.educationaddselectedinstitution!
                                                .id ==
                                            null) {
                                          return 'Selectyourinstitution'.tr;
                                        }
                                        return null;
                                      },
                                      onTap: () async {
                                        Institutions generic =
                                            await searchabledropdown(context,
                                                add.educationaddinstitutionList);
                                        add.educationaddselectedinstitution =
                                            null;
                                        add.updateeducationaddselectedInstitution(
                                            generic);

                                        if (generic != '') {
                                          add.educationaddselectedinstitution =
                                              generic;
                                          add.educationaddselectedinstitution =
                                              (generic == '')
                                                  ? null
                                                  : add
                                                      .educationaddselectedinstitution;
                                        }
                                      },
                                      readonly: true,
                                      hintText: add
                                                  .educationaddselectedinstitution
                                                  ?.name ==
                                              ""
                                          ? 'Institution'.tr
                                          : add.educationaddselectedinstitution
                                                  ?.name ??
                                              "SelectInstitution".tr,
                                    ),
                                    EditProfileCustomTextField(
                                      validator: (p0) {
                                        if (add.educationaddselecteddegree!
                                                .id ==
                                            null) {
                                          return 'SelectyourDegree'.tr;
                                        }
                                        return null;
                                      },
                                      onTap: () async {
                                        Degrees generic =
                                            await searchabledropdown(context,
                                                add.educationadddegreesList);
                                        add.educationaddselecteddegree = null;
                                        add.updateeducationaddselecteddegree(
                                            generic);

                                        if (generic.id != null) {
                                          add.educationaddselecteddegree =
                                              generic;
                                          add.educationaddselecteddegree =
                                              (generic.id == null)
                                                  ? null
                                                  : add
                                                      .educationaddselecteddegree;
                                        }
                                      },
                                      readonly: true,
                                      hintText: add.educationaddselecteddegree
                                                  ?.name ==
                                              ""
                                          ? 'Degree'.tr
                                          : add.educationaddselecteddegree
                                                  ?.name ??
                                              "SelectDegree".tr,
                                    ),
                                    EditProfileCustomTextField(
                                      onTap: () async {
                                        Degrees generic =
                                            await searchabledropdown(context,
                                                add.educationaddfieldofstudyList);
                                        add.educationaddselectedfieldofstudy =
                                            null;
                                        add.updateeducationaddselectedfieldofstudy(
                                            generic);

                                        if (generic != '') {
                                          add.educationaddselectedfieldofstudy =
                                              generic;
                                          add.educationaddselectedfieldofstudy =
                                              (generic == '')
                                                  ? null
                                                  : add
                                                      .educationaddselectedfieldofstudy;
                                        }
                                      },
                                      readonly: true,
                                      hintText: add
                                                  .educationaddselectedfieldofstudy
                                                  ?.name ==
                                              ""
                                          ? 'FieldofStudy'.tr
                                          : add.educationaddselectedfieldofstudy
                                                  ?.name ??
                                              "SelectFieldofStudy".tr,
                                    ),
                                    EditProfileCustomTextField(
                                      isSizedBoxAvailable: false,
                                      validator: (value) {
                                        if (add.formatteddegreestart
                                                .toString()
                                                .split("T")[0] ==
                                            DateTime.now()
                                                .toString()
                                                .split(" ")[0]) {
                                          return 'SelectStartDate'.tr;
                                        }
                                        return null;
                                      },
                                      onTap: () async {
                                        await add
                                            .selecteducationstartDateAndTime(
                                                context,
                                                AddEducationController
                                                    .degreestart,
                                                add.formatedegreestart);
                                      },
                                      readonly: true,
                                      hintText: add.formatteddegreestart
                                                  .toString()
                                                  .split("T")[0] ==
                                              DateTime.now()
                                                  .toString()
                                                  .split(" ")[0]
                                          ? "SelectStartDate".tr
                                          : DateFormat('MM-dd-y').format(
                                              DateTime.parse(add
                                                  .formatteddegreestart
                                                  .toString()
                                                  .split(" ")[0])),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Checkbox(
                                          side: MaterialStateBorderSide
                                              .resolveWith(
                                            (Set<MaterialState> states) {
                                              if (states.contains(
                                                  MaterialState.selected)) {
                                                return const BorderSide(
                                                    color: Colors.white);
                                              }
                                              return const BorderSide(
                                                  color: Colors.white);
                                            },
                                          ),
                                          value: add.inprogressisChecked,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              add.inprogressisChecked = value!;
                                            });
                                          },
                                          checkColor: ColorManager.kWhiteColor,
                                          activeColor:
                                              ColorManager.kPrimaryColor,
                                        ),
                                        Text(
                                          'InProgress'.tr,
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: ColorManager.kWhiteColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Visibility(
                                      visible: add.inprogressisChecked == false,
                                      child: EditProfileCustomTextField(
                                        onTap: () async {
                                          add.selecteducationendDateAndTime(
                                              context,
                                              AddEducationController.degreeend,
                                              add.formatedegreeend);
                                        },
                                        validator: (value) {
                                          if (add.formatteddegreeend
                                                  .toString()
                                                  .split("T")[0] ==
                                              DateTime.now()
                                                  .toString()
                                                  .split(" ")[0]) {
                                            return 'SelectEndDate'.tr;
                                          }
                                          return null;
                                        },
                                        readonly: true,
                                        hintText: add.formatteddegreeend
                                                    .toString()
                                                    .split("T")[0] ==
                                                DateTime.now()
                                                    .toString()
                                                    .split(" ")[0]
                                            ? "SelectEndDate".tr
                                            : DateFormat('MM-dd-y').format(
                                                DateTime.parse(add
                                                    .formatteddegreeend
                                                    .toString()
                                                    .split(" ")[0])),
                                      ),
                                    ),
                                    Visibility(
                                      visible: add.inprogressisChecked == false,
                                      child: EditProfileCustomTextField(
                                        onTap: () async {
                                          add.selecteducationissueDateAndTime(
                                              context,
                                              AddEducationController
                                                  .degreeissue,
                                              add.formatedegreeissue);
                                        },
                                        readonly: true,
                                        hintText: add.formatteddegreeissue
                                                    .toString()
                                                    .split("T")[0] ==
                                                DateTime.now()
                                                    .toString()
                                                    .split(" ")[0]
                                            ? "SelectIssueDate".tr
                                            : DateFormat('MM-dd-y').format(
                                                DateTime.parse(add
                                                    .formatteddegreeissue
                                                    .toString()
                                                    .split(" ")[0])),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'GradingScale'.tr,
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: ColorManager.kWhiteColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Radio(
                                          fillColor: MaterialStateProperty
                                              .resolveWith<Color>(
                                                  (Set<MaterialState> states) {
                                            return (add.radioselectedValue ==
                                                    "CGPA")
                                                ? Colors.white
                                                : Colors.white;
                                          }),
                                          focusColor: ColorManager.kDarkBlue,
                                          value: "CGPA",
                                          groupValue: add.radioselectedValue,
                                          onChanged: (value) {
                                            add.updateradiovalue(
                                                value.toString());
                                          },
                                          activeColor: ColorManager.kWhiteColor,
                                        ),
                                        Text(
                                          "CGPA".tr,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: ColorManager.kWhiteColor,
                                          ),
                                        ),
                                        Radio(
                                          value: "Marks",
                                          fillColor: MaterialStateProperty
                                              .resolveWith<Color>(
                                                  (Set<MaterialState> states) {
                                            return (add.radioselectedValue ==
                                                    "Marks")
                                                ? Colors.white
                                                : Colors.white;
                                          }),
                                          groupValue: add.radioselectedValue,
                                          onChanged: (value) {
                                            add.updateradiovalue(
                                                value.toString());
                                          },
                                          activeColor: ColorManager.kWhiteColor,
                                        ),
                                        Text(
                                          "Marks".tr,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: ColorManager.kWhiteColor,
                                          ),
                                        ),
                                        Radio(
                                          fillColor: MaterialStateProperty
                                              .resolveWith<Color>(
                                                  (Set<MaterialState> states) {
                                            return (add.radioselectedValue ==
                                                    "Percentage")
                                                ? Colors.white
                                                : Colors.white;
                                          }),
                                          value: "Percentage",
                                          groupValue: add.radioselectedValue,
                                          onChanged: (value) {
                                            add.updateradiovalue(
                                                value.toString());
                                          },
                                          activeColor: ColorManager.kWhiteColor,
                                        ),
                                        Text(
                                          "Percentage".tr,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: ColorManager.kWhiteColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Visibility(
                                      visible:
                                          add.radioselectedValue == "CGPA" ||
                                              add.radioselectedValue == "Marks",
                                      child: EditProfileCustomTextField(
                                        controller: add.totalmarks,
                                        hintText: 'Total'.tr,
                                        keyboardTypenew: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'^\d*\.?\d{0,2}')),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible:
                                          add.radioselectedValue == "CGPA" ||
                                              add.radioselectedValue == "Marks",
                                      child: EditProfileCustomTextField(
                                        controller: add.obtainedmarks,
                                        hintText: 'Obtained'.tr,
                                        keyboardTypenew: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'^\d*\.?\d{0,2}')),
                                        ],
                                      ),
                                    ),
                                    EditProfileCustomTextField(
                                      controller: add.percentage,
                                      hintText: 'Percentage'.tr,
                                      keyboardTypenew: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^\d*\.?\d{0,2}')),
                                      ],
                                    ),
                                    SizedBox(height: Get.height * 0.03),
                                    InkWell(
                                      onTap: () async {
                                        add.updateisaddloading(true);
                                        if (_addformKey.currentState!
                                            .validate()) {
                                          int inprogress = 0;
                                          if (add.inprogressisChecked == true) {
                                            inprogress = 1;
                                          } else {
                                            inprogress = 0;
                                          }

                                          int gradingscale = 1;
                                          if (add.radioselectedValue ==
                                              "CGPA") {
                                            gradingscale = 1;
                                          } else if (add.radioselectedValue ==
                                              "Marks") {
                                            gradingscale = 2;
                                          } else if (add.radioselectedValue ==
                                              "Percentage") {
                                            gradingscale = 3;
                                          } else {
                                            gradingscale = 1;
                                          }

                                          if (add.formatteddegreeend ==
                                              DateTime.now()) {
                                            add.formatteddegreeend = "";
                                          }
                                          if (add.formatteddegreeissue ==
                                              DateTime.now()) {
                                            add.formatteddegreeissue = "";
                                          }
                                          ProfileRepo pr = ProfileRepo();
                                          String res = await pr.addEducation(
                                              add.selectededucationaddcountry
                                                  ?.id,
                                              add.educationaddselectedinstitution
                                                  ?.id,
                                              add.educationaddselecteddegree
                                                  ?.id,
                                              add.educationaddselectedfieldofstudy
                                                  ?.id,
                                              add.formatteddegreestart,
                                              add.formatteddegreeend,
                                              add.formatteddegreeissue,
                                              inprogress,
                                              gradingscale,
                                              add.totalmarks.text,
                                              add.obtainedmarks.text,
                                              add.percentage.text);

                                          if (res == "true") {
                                            _getDoctorBasicInfo();
                                            ProfileController.i
                                                .updateaddval(false);

                                            add.updateisaddloading(false);
                                            setState(() {});
                                          }
                                          add.updateisaddloading(false);
                                        }
                                        add.updateisaddloading(false);
                                      },
                                      child: Container(
                                        height: Get.height * 0.07,
                                        width: Get.width * 1,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.7),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                            child: add.isaddloading == false
                                                ? Text(
                                                    'add'.tr,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: ColorManager
                                                            .kWhiteColor),
                                                  )
                                                : const CircularProgressIndicator(
                                                    color: ColorManager
                                                        .kWhiteColor,
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
                    : GetBuilder<ProfileController>(
                        builder: (contr) => Container(
                          height: Get.height * 1,
                          color: ColorManager.kPrimaryColor,
                          padding: EdgeInsets.only(
                            top: Get.height * 0.02,
                            left: Get.width * 0.02,
                            right: Get.width * 0.02,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: Get.width * 0.04),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ImageContainer(
                                        onpressed: () {
                                          // clear
                                          add.clearAddValues();

                                          ProfileController.i
                                              .updateaddval(true);
                                          ProfileController.i
                                              .updateisEdit(true);
                                          setState(() {});
                                        },
                                        imagePath: Images.add,
                                        isSvg: false,
                                        color: ColorManager.kPrimaryColor,
                                        backgroundColor:
                                            ColorManager.kWhiteColor,
                                        boxheight: Get.height * 0.04,
                                        boxwidth: Get.width * 0.08,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                education.educationList.isNotEmpty
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: Get.width * 0.4,
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  child: SizedBox(
                                                    height: Get.height * 0.04,
                                                    width: Get.width * 0.15,
                                                    child: Image.asset(
                                                      Images.edit,
                                                      color: ColorManager
                                                          .kPrimaryColor,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  'degree'.tr,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: ColorManager
                                                        .kWhiteColor,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.2,
                                            child: Text(
                                              'country'.tr,
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: ColorManager.kWhiteColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.2,
                                            child: Text(
                                              'EndDate'.tr,
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: ColorManager.kWhiteColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : const SizedBox.shrink(),
                                education.educationList.isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            education.educationList.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: Get.height * 0.01,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: Get.width * 0.4,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        // ImageContainerNew(
                                                        //   onpressed: () {
                                                        //     deleteEducation(
                                                        //         context,
                                                        //         contr
                                                        //             .educationList[
                                                        //                 index]
                                                        //             .id!);
                                                        //   },
                                                        //   imagePath:
                                                        //       AppImages.cross,
                                                        //   isSvg: false,
                                                        //   color: ColorManager
                                                        //       .kRedColor,
                                                        //   backgroundColor:
                                                        //       ColorManager
                                                        //           .kWhiteColor,
                                                        //   boxheight:
                                                        //       Get.height * 0.03,
                                                        //   boxwidth:
                                                        //       Get.width * 0.06,
                                                        // ),
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.004,
                                                        ),
                                                        ImageContainerNew(
                                                          onpressed: () {
                                                            // send object

                                                            // edit.editSelectedEducation =
                                                            //     null;
                                                            // edit.updateEditSelectedEducation(
                                                            //     education
                                                            //             .educationList[
                                                            //         index]);

                                                            Educations e =
                                                                Educations();
                                                            e = education
                                                                    .educationList[
                                                                index];
                                                            edit.updateeditSelectedEducation(
                                                                e);
                                                            ProfileController.i
                                                                .updateval(
                                                                    true);
                                                            ProfileController.i
                                                                .updateisEdit(
                                                                    true);
                                                            setState(() {});
                                                          },
                                                          imagePath:
                                                              AppImages.editbig,
                                                          isSvg: false,
                                                          color: ColorManager
                                                              .kPrimaryColor,
                                                          backgroundColor:
                                                              ColorManager
                                                                  .kWhiteColor,
                                                          boxheight:
                                                              Get.height * 0.03,
                                                          boxwidth:
                                                              Get.width * 0.06,
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.002,
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.25,
                                                          child: Text(
                                                            ProfileController
                                                                    .i
                                                                    .educationList[
                                                                        index]
                                                                    .degreeName ??
                                                                "",
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 11,
                                                              color: ColorManager
                                                                  .kWhiteColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: Get.width * 0.2,
                                                    child: Text(
                                                      ProfileController
                                                              .i
                                                              .educationList[
                                                                  index]
                                                              .countryName ??
                                                          "",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 11,
                                                        color: ColorManager
                                                            .kWhiteColor,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width: Get.width * 0.2,
                                                      child: Text(
                                                        // ProfileController
                                                        //         .i
                                                        //         .educationList[index]
                                                        //         .endDate ??
                                                        //     "",
                                                        contr
                                                                    .educationList[
                                                                        index]
                                                                    .endDate !=
                                                                null
                                                            ? DateFormat.yMMMd()
                                                                .format((DateTime
                                                                    .parse(
                                                                        "${contr.educationList[index].endDate.toString().split('T').first} ${contr.educationList[index].endDate.toString().split('T').last}")))
                                                            : "In Progress",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 11,
                                                          color: ColorManager
                                                              .kWhiteColor,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ],
                                          );
                                        },
                                      )
                                    : Center(
                                        child: Text(
                                          "NoRecordFound".tr,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      )),
      ),
    );
  }

  deleteEducation(BuildContext context, String id) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: Get.width * 0.05),
                      Text(
                        'delete'.tr,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          textStyle: GoogleFonts.poppins(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.close_outlined,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Text(
                    'doyouwanttodeleteit'.tr,
                    style: GoogleFonts.poppins(
                      textStyle: GoogleFonts.poppins(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  PrimaryButton(
                    title: 'yes'.tr,
                    fontSize: 14,
                    height: Get.height * 0.06,
                    width: Get.width * 0.5,
                    onPressed: () async {
                      ProfileRepo pr = ProfileRepo();

                      String res = await pr.deleteEducation(id);

                      if (res == "true") {
                        _getDoctorBasicInfo();

                        setState(() {});
                      }

                      // Call API
                      Get.back();
                    },
                    color: ColorManager.kPrimaryColor,
                    textcolor: ColorManager.kWhiteColor,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
