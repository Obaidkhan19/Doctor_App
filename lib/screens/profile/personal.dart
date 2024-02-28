import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:doctormobileapplication/components/custom_checkbox_dropdown.dart';
import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/components/searchable_dropdown.dart';
import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
import 'package:doctormobileapplication/data/controller/preference_controller.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/auth_repo.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/blood_group.dart';
import 'package:doctormobileapplication/models/designation.dart';
import 'package:doctormobileapplication/models/genders_model.dart';
import 'package:doctormobileapplication/models/marital_status.dart';
import 'package:doctormobileapplication/models/person_title.dart';
import 'package:doctormobileapplication/models/relation.dart';
import 'package:doctormobileapplication/models/religion.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PersonalDetail extends StatefulWidget {
  const PersonalDetail({super.key});

  @override
  State<PersonalDetail> createState() => _PersonalDetailState();
}

class _PersonalDetailState extends State<PersonalDetail> {
  _getDoctorBasicInfo() async {
    ProfileRepo pr = ProfileRepo();
    await pr.getDoctorBasicInfo();
  }

  var profile = Get.put<ProfileController>(ProfileController());

  @override
  void initState() {
    super.initState();

    _getTitle();
    _getMaritalStatus();
    _getGenders();
    _getBloodGroup();
    _getReligion();
    _getRelation();
    _getDesgination();
    _getDoctorBasicInfo();
    Future.delayed(Duration.zero, () async {
      ProfileController.i.updateselectedindex(0);
    });
  }

  _getTitle() async {
    AuthRepo ar = AuthRepo();
    EditProfileController.i.updatepersonalTitleList(
      await ar.getPersonalTitle(),
    );
  }

  _getMaritalStatus() async {
    AuthRepo ar = AuthRepo();
    EditProfileController.i.updatemaritalStatusList(
      await ar.getMaritalStatus(),
    );
  }

  _getGenders() async {
    AuthRepo ar = AuthRepo();
    EditProfileController.i.updategenderList(
      await ar.getGendersList(),
    );
  }

  _getBloodGroup() async {
    AuthRepo ar = AuthRepo();
    EditProfileController.i.updatebloodgroupList(
      await ar.getBloodGroupDetail(),
    );
  }

  _getReligion() async {
    AuthRepo ar = AuthRepo();
    EditProfileController.i.updatereligionList(
      await ar.getReligion(),
    );
  }

  _getRelation() async {
    AuthRepo ar = AuthRepo();
    EditProfileController.i.updaterelationList(
      await ar.getRelation(),
    );
  }

  _getDesgination() async {
    AuthRepo ar = AuthRepo();
    EditProfileController.i.updatedesignationdata(
      await ar.getDesignation(),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var edit = Get.put<EditProfileController>(EditProfileController());
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
                                validator: (value) {
                                  if (edit.selectedpersonalTitle == null) {
                                    return 'selectpersonaltitle'.tr;
                                  } else {
                                    return null;
                                  }
                                },
                                onTap: () async {
                                  edit.selectedpersonalTitle = null;
                                  PTitle generic = await searchabledropdown(
                                      context, edit.personalTitleList);
                                  edit.selectedpersonalTitle = null;
                                  edit.updateselectedpersonalTitle(generic);

                                  if (generic.id == null) {
                                    edit.selectedpersonalTitle = generic;
                                    edit.selectedpersonalTitle =
                                        (generic.id == null)
                                            ? null
                                            : edit.selectedpersonalTitle;
                                  }
                                },
                                readonly: true,
                                hintText: edit.selectedpersonalTitle?.name == ""
                                    ? 'title'.tr
                                    : edit.selectedpersonalTitle?.name
                                        .toString(),
                              ),
                              Visibility(
                                visible:
                                    edit.selectedpersonalTitle?.name == 'Other',
                                child: EditProfileCustomTextField(
                                  validator: (p0) {
                                    if (p0!.isEmpty) {
                                      return 'EnterTitlePrefix'.tr;
                                    }
                                    return null;
                                  },
                                  hintText: 'titlePrefix'.tr,
                                  controller: edit.customprefixtitle,
                                ),
                              ),
                              EditProfileCustomTextField(
                                validator: (p0) {
                                  if (p0!.isEmpty) {
                                    return 'enteryourfirstname'.tr;
                                  }
                                  return null;
                                },
                                hintText: 'firstname'.tr,
                                controller: edit.firstname,
                              ),
                              EditProfileCustomTextField(
                                hintText: 'middleName'.tr,
                                controller: edit.middlename,
                              ),
                              EditProfileCustomTextField(
                                validator: (p0) {
                                  if (p0!.isEmpty) {
                                    return 'enteryourlastname'.tr;
                                  }
                                  return null;
                                },
                                hintText: 'lastname'.tr,
                                controller: edit.lastname,
                              ),
                              EditProfileCustomTextField(
                                validator: (p0) {
                                  if (edit.selectedgender == null) {
                                    return 'selectgender'.tr;
                                  }
                                  return null;
                                },
                                onTap: () async {
                                  edit.selectedgender = null;
                                  GendersData generic =
                                      await searchabledropdown(
                                          context, edit.genderList);
                                  edit.selectedgender = null;
                                  edit.updateselectedgender(generic);

                                  if (generic.id == null) {
                                    edit.selectedgender = generic;
                                    edit.selectedgender = (generic.id == null)
                                        ? null
                                        : edit.selectedgender;
                                  }
                                },
                                readonly: true,
                                hintText: edit.selectedgender?.name == ""
                                    ? 'gender'.tr
                                    : edit.selectedgender?.name.toString(),
                              ),
                              EditProfileCustomTextField(
                                validator: (p0) {
                                  if (edit.selectedmaritalStatus == null) {
                                    return 'selectmaritalstatus'.tr;
                                  }
                                  return null;
                                },
                                onTap: () async {
                                  edit.selectedmaritalStatus = null;
                                  MSData generic = await searchabledropdown(
                                      context, edit.maritalStatusList);
                                  edit.selectedmaritalStatus = null;
                                  edit.updateselectedmaritalStatus(generic);

                                  if (generic.id == null) {
                                    edit.selectedmaritalStatus = generic;
                                    edit.selectedmaritalStatus =
                                        (generic.id == null)
                                            ? null
                                            : edit.selectedmaritalStatus;
                                  }
                                },
                                readonly: true,
                                hintText: edit.selectedmaritalStatus?.name == ""
                                    ? 'maritalstatus'.tr
                                    : edit.selectedmaritalStatus?.name
                                        .toString(),
                              ),
                              GetBuilder<PreferenceController>(
                                builder: (cont) => EditProfileCustomTextField(
                                  validator: (p0) {
                                    if (p0!.isEmpty) {
                                      return "${'Enteryour'.tr} ";
                                    }
                                    return null;
                                  },
                                  keyboardTypenew: TextInputType.number,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(15)
                                  ],
                                  controller: edit.idnumber,
                                  hintText: '',
                                ),
                              ),
                              EditProfileCustomTextField(
                                // validator: (p0) {
                                //   if (p0!.isEmpty) {
                                //     return 'EnterPassportNumber'.tr;
                                //   }
                                //   return null;
                                // },
                                controller: edit.passportno,
                                hintText: 'passportNumber'.tr,
                              ),
                              GetBuilder<PreferenceController>(
                                builder: (cont) => EditProfileCustomTextField(
                                  validator: (p0) {
                                    if (p0!.isEmpty) {
                                      return '${'Enteryour'.tr} ';
                                    }
                                    return null;
                                  },
                                  controller: edit.imcno,
                                  hintText: '',
                                ),
                              ),
                              EditLMPCCustomTextField(
                                readonly: true,
                                onTap: () {
                                  edit.picksinglefile();
                                },
                                // },
                              ),
                              SizedBox(height: Get.height * 0.02),
                              GetBuilder<PreferenceController>(
                                builder: (cont) => EditProfileCustomTextField(
                                  controller: edit.ntnnumber,
                                  hintText: '',
                                  keyboardTypenew: TextInputType.number,
                                ),
                              ),
                              EditProfileCustomTextField(
                                keyboardTypenew:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d*\.?\d{0,2}')),
                                ],
                                hintText: 'consultancyfee'.tr,
                                controller: edit.consultancyfee,
                              ),
                              EditProfileCustomTextField(
                                hintText: 'followupfee'.tr,
                                controller: edit.followupfee,
                                keyboardTypenew:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d*\.?\d{0,2}')),
                                ],
                              ),
                              EditProfileCustomTextField(
                                onTap: () async {
                                  edit.selectedbloodgroup = null;
                                  bloodGroupData generic =
                                      await searchabledropdown(
                                          context, edit.bloodgroupList);
                                  edit.selectedbloodgroup = null;
                                  edit.updateselectedbloodgroup(generic);

                                  if (generic.id == null) {
                                    edit.selectedbloodgroup = generic;
                                    edit.selectedbloodgroup =
                                        (generic.id == null)
                                            ? null
                                            : edit.selectedbloodgroup;
                                  }
                                },
                                readonly: true,
                                hintText: edit.selectedbloodgroup?.name == ""
                                    ? 'bloodGroup'.tr
                                    : edit.selectedbloodgroup?.name.toString(),
                              ),
                              EditProfileCustomTextField(
                                onTap: () async {
                                  edit.selectedreligion = null;
                                  Religion generic = await searchabledropdown(
                                      context, edit.religionList);
                                  edit.selectedreligion = null;
                                  edit.updateselectedreligion(generic);

                                  if (generic.id == null) {
                                    edit.selectedreligion = generic;
                                    edit.selectedreligion = (generic.id == null)
                                        ? null
                                        : edit.selectedreligion;
                                  }
                                },
                                readonly: true,
                                hintText: edit.selectedreligion?.name == ""
                                    ? 'religion'.tr
                                    : edit.selectedreligion?.name.toString(),
                              ),
                              EditProfileCustomTextField(
                                  onTap: () async {
                                    Designations generic =
                                        await searchabledropdown(
                                            context, edit.designationList);
                                    await edit.addDesignation(
                                        generic, BuildContext);
                                    setState(() {});
                                  },
                                  readonly: true,
                                  hintText: 'designations'.tr),
                              GetBuilder<EditProfileController>(
                                builder: (contr) => Visibility(
                                  visible:
                                      edit.selecteddesignationList.isNotEmpty,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Wrap(
                                        direction: Axis
                                            .horizontal, // Make sure items are laid out horizontally
                                        runSpacing: 8.0,
                                        children: <Widget>[
                                          for (int index = 0;
                                              index <
                                                  edit.selecteddesignationList
                                                      .length;
                                              index++)
                                            InkWell(
                                              onTap: () {
                                                String cid = edit
                                                    .selecteddesignationList[
                                                        index]
                                                    .id!;
                                                deleteSelectedDesignation(
                                                    context,
                                                    edit.selecteddesignationList,
                                                    // edit.selecteddesignationIdList,
                                                    cid,
                                                    "designation");
                                              },
                                              child: Card(
                                                elevation: 4,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: Get.width * 0.01,
                                                      right: Get.width * 0.01),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      SizedBox(
                                                        height:
                                                            Get.height * 0.03,
                                                        width: Get.width * 0.03,
                                                        child: Image.asset(
                                                            AppImages.cross),
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * 0.01,
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          edit
                                                              .selecteddesignationList[
                                                                  index]
                                                              .name
                                                              .toString(),
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 10,
                                                            color: ColorManager
                                                                .kblackColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              EditProfileCustomTextField(
                                  onTap: () async {
                                    edit.ontap = true;
                                    edit.selectDateAndTime(
                                        context,
                                        EditProfileController.arrival,
                                        edit.formatearrival);
                                  },
                                  readonly: true,
                                  hintText: edit.formatearrival.toString()),
                              EditProfileCustomTextField(
                                hintText: 'guardianName'.tr,
                                controller: edit.guardianname,
                              ),
                              EditProfileCustomTextField(
                                onTap: () async {
                                  edit.selectedrelation = null;
                                  RelationData generic =
                                      await searchabledropdown(
                                          context, edit.relationList);
                                  edit.selectedrelation = null;
                                  edit.updateselectedrelation(generic);

                                  if (generic.id == null) {
                                    edit.selectedrelation = generic;
                                    edit.selectedrelation = (generic.id == null)
                                        ? null
                                        : edit.selectedrelation;
                                  }
                                },
                                readonly: true,
                                hintText: edit.selectedrelation?.name == ""
                                    ? 'relation'.tr
                                    : edit.selectedrelation?.name.toString(),
                              ),
                              SizedBox(height: Get.height * 0.03),
                              InkWell(
                                onTap: () async {
                                  edit.updateiseditloading(true);
                                  String? filepath;
                                  if (edit.pmcfile != null) {
                                    AuthRepo ar = AuthRepo();
                                    filepath =
                                        await ar.uploadFile(edit.pmcfile!);
                                  }

                                  ProfileRepo pr = ProfileRepo();
                                  if (edit.ntnnumber.text == "null") {
                                    edit.ntnnumber.text = "";
                                  }
                                  if (edit.passportno.text == "null") {
                                    edit.passportno.text = "";
                                  }
                                  if (edit.consultancyfee.text == "null") {
                                    edit.consultancyfee.text = "";
                                  }
                                  if (edit.followupfee.text == "null") {
                                    edit.followupfee.text = "";
                                  }
                                  if (_formKey.currentState!.validate()) {
                                    String res =
                                        await pr.updatePersonalInfoCNIC(
                                      edit.customprefixtitle.text,
                                      edit.selectedpersonalTitle?.id ?? "",
                                      edit.firstname.text,
                                      edit.middlename.text,
                                      edit.lastname.text,
                                      edit.formattedArrival,
                                      edit.selectedmaritalStatus?.id ?? "",
                                      edit.guardianname.text,
                                      edit.selectedrelation?.id ?? "",
                                      edit.selectedgender?.id ?? "",
                                      edit.idnumber.text,
                                      edit.imcno.text,
                                      filepath ??
                                          profile.selectedbasicInfo
                                              ?.pMDCCertificateAttachment,
                                      edit.ntnnumber.text,
                                      edit.consultancyfee.text,
                                      edit.followupfee.text,
                                      edit.selectedbloodgroup?.id ?? "",
                                      edit.selectedreligion?.id ?? "",
                                      edit.selecteddesignationList,
                                      edit.passportno.text,
                                    );
                                    edit.updateiseditloading(true);
                                    if (res == "true") {
                                      //  Get.back(result: true);
                                      // edit.selecteddesignationIdList.clear();
                                      edit.selecteddesignationList.clear();
                                      ProfileController.i.updateval(false);
                                      _getDoctorBasicInfo();
                                      setState(() {});
                                      edit.updateiseditloading(false);
                                    }
                                    edit.updateiseditloading(false);
                                  }
                                  edit.updateiseditloading(false);
                                },
                                child: Container(
                                  height: Get.height * 0.07,
                                  width: Get.width * 1,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                      child: edit.iseditloading == false
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
                  height: Get.height * 1,
                  padding: EdgeInsets.only(
                    top: Get.height * 0.02,
                    left: Get.width * 0.02,
                    right: Get.width * 0.02,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ProfileRecordWidget(
                          title: "name".tr,
                          name: profile.selectedbasicInfo?.fullName == ""
                              ? "-"
                              : profile.selectedbasicInfo?.fullName == null
                                  ? "-"
                                  : profile.selectedbasicInfo?.fullName ?? "-",
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        ProfileRecordWidget(
                          title: "dateOfBirth".tr,
                          name: (profile.selectedbasicInfo?.dateofBirth != null)
                              ? DateFormat('MM-dd-y').format(DateTime.parse(
                                  profile.selectedbasicInfo?.dateofBirth!
                                      .split("T")[0]))
                              : "-",
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        ProfileRecordWidget(
                          title: "age".tr,
                          name: profile.selectedbasicInfo?.age == ""
                              ? "-"
                              : profile.selectedbasicInfo?.age == null
                                  ? "-"
                                  : profile.selectedbasicInfo?.age ?? "-",
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        ProfileRecordWidget(
                          title: "maritalStatus".tr,
                          name: profile.selectedbasicInfo?.maritalStatusName ==
                                  ""
                              ? "-"
                              : profile.selectedbasicInfo?.maritalStatusName ==
                                      null
                                  ? "-"
                                  : profile.selectedbasicInfo
                                          ?.maritalStatusName ??
                                      "-",
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        ProfileRecordWidget(
                          title: "gender".tr,
                          name: profile.selectedbasicInfo?.genderName == ""
                              ? "-"
                              : profile.selectedbasicInfo?.genderName == null
                                  ? "-"
                                  : profile.selectedbasicInfo?.genderName ??
                                      "-",
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        GetBuilder<ProfileController>(
                          builder: (cont) => ProfileRecordWidget(
                            title: ' National ID',
                            name: profile.selectedbasicInfo?.cNICNumber == ""
                                ? "-"
                                : profile.selectedbasicInfo?.cNICNumber == null
                                    ? "-"
                                    : profile.selectedbasicInfo?.cNICNumber ??
                                        "-",
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        ProfileRecordWidget(
                          title: "passportNumber".tr,
                          name: profile.selectedbasicInfo?.passportNumber == ""
                              ? "-"
                              : profile.selectedbasicInfo?.passportNumber ==
                                      null
                                  ? "-"
                                  : profile.selectedbasicInfo?.passportNumber ??
                                      "-",
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        GetBuilder<PreferenceController>(
                          builder: (cont) => ProfileRecordWidget(
                            title: '',
                            name: profile.selectedbasicInfo?.nTNNo == ""
                                ? "-"
                                : profile.selectedbasicInfo?.nTNNo == null
                                    ? "-"
                                    : profile.selectedbasicInfo?.nTNNo ?? "-",
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        GetBuilder<PreferenceController>(
                          builder: (cont) => ProfileRecordWidget(
                            title: '',
                            name: profile.selectedbasicInfo?.pMDCNumber == ""
                                ? "-"
                                : profile.selectedbasicInfo?.pMDCNumber == null
                                    ? "-"
                                    : profile.selectedbasicInfo?.pMDCNumber ??
                                        "-",
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        ProfileRecordWidget(
                          title: "bloodGroup".tr,
                          name: profile.selectedbasicInfo?.bloodGroupName == ""
                              ? "-"
                              : profile.selectedbasicInfo?.bloodGroupName ==
                                      null
                                  ? "-"
                                  : profile.selectedbasicInfo?.bloodGroupName ??
                                      "-",
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        ProfileRecordWidget(
                          title: "religion".tr,
                          name: profile.selectedbasicInfo?.religionName == ""
                              ? "-"
                              : profile.selectedbasicInfo?.religionName == null
                                  ? "-"
                                  : profile.selectedbasicInfo?.religionName ??
                                      "-",
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        ProfileRecordWidget(
                          title: "consultancyFee".tr,
                          name: profile.selectedbasicInfo?.consultationFee
                                          .toString() ==
                                      "" ||
                                  profile.selectedbasicInfo?.consultationFee
                                          .toString() ==
                                      "null" ||
                                  profile.selectedbasicInfo?.consultationFee
                                          .toString() ==
                                      null
                              ? "-"
                              : profile.selectedbasicInfo?.consultationFee
                                  .toString(),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        ProfileRecordWidget(
                          title: "followupfee".tr,
                          name: profile.selectedbasicInfo?.followUpFee
                                          .toString() ==
                                      "" ||
                                  profile.selectedbasicInfo?.followUpFee
                                          .toString() ==
                                      "null" ||
                                  profile.selectedbasicInfo?.followUpFee
                                          .toString() ==
                                      null
                              ? "-"
                              : profile.selectedbasicInfo?.followUpFee
                                  .toString(),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        ProfileRecordWidget(
                          title: "designation(s)".tr,
                          name: profile.selectedbasicInfo?.designation == ""
                              ? "-"
                              : profile.selectedbasicInfo?.designation == null
                                  ? "-"
                                  : profile.selectedbasicInfo?.designation ??
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

class ProfileRecordWidget extends StatelessWidget {
  final bool? isDoctorConsultationScreen;
  final String? title;
  final String? name;
  final Color? color;
  const ProfileRecordWidget(
      {Key? key,
      this.title,
      this.name,
      this.color,
      this.isDoctorConsultationScreen = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: isDoctorConsultationScreen == false
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 7,
                  child: Text(
                    '${title?.trimLeft()}',
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: color ?? Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      ':',
                      style: TextStyle(
                        color: color ?? Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    '${name?.trim()}',
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: color ?? Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 13,
                        ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
          ],
        ),
      ),
    );
  }
}

// class ProfileRecordWidget extends StatelessWidget {
//   final String? title;
//   final String? name;

//   const ProfileRecordWidget({Key? key, this.title, this.name})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
//       child: Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Text(
//                 '$title',
//                 style: GoogleFonts.poppins(
//                   fontSize: 12,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Text(
//               ':',
//               style: GoogleFonts.poppins(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w900,
//               ),
//             ),
//             SizedBox(
//               width: Get.width * 0.03,
//             ),
//             Expanded(
//               child: Text(
//                 '$name',
//                 style: GoogleFonts.poppins(
//                   fontSize: 12,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
