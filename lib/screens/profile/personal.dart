import 'package:doctormobileapplication/components/custom_checkbox_dropdown.dart';
import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/components/searchable_dropdown.dart';
import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          EditProfileCustomTextField(
                            onTap: () async {
                              edit.selectedpersonalTitle = null;
                              PTitle generic = await searchabledropdown(
                                  context, edit.personalTitleList ?? []);
                              edit.selectedpersonalTitle = null;
                              edit.updateselectedpersonalTitle(generic);

                              if (generic != '') {
                                edit.selectedpersonalTitle = generic;
                                edit.selectedpersonalTitle = (generic == '')
                                    ? null
                                    : edit.selectedpersonalTitle;
                              }
                            },
                            readonly: true,
                            hintText: edit.selectedpersonalTitle?.name == ""
                                ? 'title'.tr
                                : edit.selectedpersonalTitle?.name.toString(),
                          ),
                          Visibility(
                            visible:
                                edit.selectedpersonalTitle?.name == 'Other',
                            child: EditProfileCustomTextField(
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return 'Enter Title Prefix';
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
                                return 'Enter First Name';
                              }
                              return null;
                            },
                            hintText: 'firstname'.tr,
                            controller: edit.firstname,
                          ),
                          EditProfileCustomTextField(
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Enter Middle Name';
                              }
                              return null;
                            },
                            hintText: 'middleName'.tr,
                            controller: edit.middlename,
                          ),
                          EditProfileCustomTextField(
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Enter Last Name';
                              }
                              return null;
                            },
                            hintText: 'lastname'.tr,
                            controller: edit.lastname,
                          ),
                          EditProfileCustomTextField(
                            onTap: () async {
                              edit.selectedgender = null;
                              GendersData generic = await searchabledropdown(
                                  context, edit.genderList ?? []);
                              edit.selectedgender = null;
                              edit.updateselectedgender(generic);

                              if (generic != '') {
                                edit.selectedgender = generic;
                                edit.selectedgender = (generic == '')
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
                            onTap: () async {
                              edit.selectedmaritalStatus = null;
                              MSData generic = await searchabledropdown(
                                  context, edit.maritalStatusList ?? []);
                              edit.selectedmaritalStatus = null;
                              edit.updateselectedmaritalStatus(generic);

                              if (generic != '') {
                                edit.selectedmaritalStatus = generic;
                                edit.selectedmaritalStatus = (generic == '')
                                    ? null
                                    : edit.selectedmaritalStatus;
                              }
                            },
                            readonly: true,
                            hintText: edit.selectedmaritalStatus?.name == ""
                                ? 'maritalstatus'.tr
                                : edit.selectedmaritalStatus?.name.toString(),
                          ),
                          EditProfileCustomTextField(
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Enter your Id Number'.tr;
                              }
                              return null;
                            },
                            controller: edit.idnumber,
                            hintText: 'idnumber'.tr,
                          ),
                          EditProfileCustomTextField(
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Enter Your Passport No';
                              }
                              return null;
                            },
                            controller: edit.passportno,
                            hintText: 'passportNumber'.tr,
                          ),
                          EditProfileCustomTextField(
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'enteryourimcno'.tr;
                              }
                              return null;
                            },
                            controller: edit.imcno,
                            hintText: 'imcno'.tr,
                          ),
                          InkWell(
                            onTap: () {
                              edit.picksinglefile();
                            },
                            child: Container(
                              width:
                                  Get.width * 1, // Adjust the width as needed
                              height: Get.height * 0.07,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: Text(
                                  'addLMPC'.tr,
                                  style: GoogleFonts.poppins(
                                    color: ColorManager.kWhiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: Get.height * 0.02),
                          EditProfileCustomTextField(
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Enter NTN Number';
                              }
                              return null;
                            },
                            controller: edit.ntnnumber,
                            hintText: 'NTNNumber'.tr,
                          ),
                          EditProfileCustomTextField(
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Enter Consultancy Fee';
                              }
                              return null;
                            },
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
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Enter Follow UP Fee';
                              }
                              return null;
                            },
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
                              bloodGroupData generic = await searchabledropdown(
                                  context, edit.bloodgroupList ?? []);
                              edit.selectedbloodgroup = null;
                              edit.updateselectedbloodgroup(generic);

                              if (generic != '') {
                                edit.selectedbloodgroup = generic;
                                edit.selectedbloodgroup = (generic == '')
                                    ? null
                                    : edit.selectedbloodgroup;
                              }
                            },
                            readonly: true,
                            hintText: edit.selectedbloodgroup?.name == ""
                                ? 'Blood Group'
                                : edit.selectedbloodgroup?.name.toString(),
                          ),
                          EditProfileCustomTextField(
                            onTap: () async {
                              edit.selectedreligion = null;
                              Religion generic = await searchabledropdown(
                                  context, edit.religionList ?? []);
                              edit.selectedreligion = null;
                              edit.updateselectedreligion(generic);

                              if (generic != '') {
                                edit.selectedreligion = generic;
                                edit.selectedreligion = (generic == '')
                                    ? null
                                    : edit.selectedreligion;
                              }
                            },
                            readonly: true,
                            hintText: edit.selectedreligion?.name == ""
                                ? 'Religion'
                                : edit.selectedreligion?.name.toString(),
                          ),
                          EditProfileCustomTextField(
                              onTap: () async {
                                Designations generic = await searchabledropdown(
                                    context, edit.designationList ?? []);
                                await edit.addDesignation(
                                    generic, BuildContext);
                                setState(() {});
                              },
                              readonly: true,
                              hintText: 'designations'.tr),
                          GetBuilder<EditProfileController>(
                            builder: (contr) => Visibility(
                              visible: edit.selecteddesignationList.isNotEmpty,
                              child: Column(
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
                                                .selecteddesignationList[index]
                                                .id!;
                                            deleteSelected(
                                                context,
                                                edit.selecteddesignationList,
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
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    height: Get.height * 0.03,
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
                                                      style:
                                                          GoogleFonts.poppins(
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
                            hintText: DateFormat('MM-dd-y').format(
                                DateTime.parse(edit.formattedArrival
                                    .toString()
                                    .split("T")[0])),
                          ),
                          EditProfileCustomTextField(
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Enter Guardian Name';
                              }
                              return null;
                            },
                            hintText: 'guardianName'.tr,
                            controller: edit.guardianname,
                          ),
                          EditProfileCustomTextField(
                            onTap: () async {
                              edit.selectedrelation = null;
                              RelationData generic = await searchabledropdown(
                                  context, edit.relationList ?? []);
                              edit.selectedrelation = null;
                              edit.updateselectedrelation(generic);

                              if (generic != '') {
                                edit.selectedrelation = generic;
                                edit.selectedrelation = (generic == '')
                                    ? null
                                    : edit.selectedrelation;
                              }
                            },
                            readonly: true,
                            hintText: edit.selectedrelation?.name == ""
                                ? 'Relation'
                                : edit.selectedrelation?.name.toString(),
                          ),
                          SizedBox(height: Get.height * 0.03),
                          PrimaryButton(
                              fontSize: 15,
                              title: 'update'.tr,
                              onPressed: () async {
                                String filepath = "";
                                if (edit.pmcfile != null) {
                                  AuthRepo ar = AuthRepo();
                                  await ar.uploadFile(edit.pmcfile!);
                                }

                                ProfileRepo pr = ProfileRepo();

                                String res = await pr.updatePersonalInfoCNIC(
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
                                  filepath,
                                  edit.ntnnumber.text,
                                  edit.consultancyfee.text,
                                  edit.followupfee.text,
                                  edit.selectedbloodgroup?.id ?? "",
                                  edit.selectedreligion?.id ?? "",
                                  edit.selecteddesignationIdList,
                                  edit.passportno.text,
                                );
                                if (res == "true") {
                                  //  Get.back(result: true);
                                  edit.selecteddesignationIdList.clear();
                                  edit.selecteddesignationList.clear();
                                  ProfileController.i.updateval(false);
                                  _getDoctorBasicInfo();
                                  setState(() {});
                                }
                              },
                              color: Colors.white.withOpacity(0.7),
                              textcolor: ColorManager.kWhiteColor),
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
                          ? DateFormat('MM-dd-y').format(DateTime.parse(profile
                              .selectedbasicInfo?.dateofBirth!
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
                      name: profile.selectedbasicInfo?.maritalStatusName == ""
                          ? "-"
                          : profile.selectedbasicInfo?.maritalStatusName == null
                              ? "-"
                              : profile.selectedbasicInfo?.maritalStatusName ??
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
                              : profile.selectedbasicInfo?.genderName ?? "-",
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    ProfileRecordWidget(
                      title: "idnumber".tr,
                      name: profile.selectedbasicInfo?.cNICNumber == ""
                          ? "-"
                          : profile.selectedbasicInfo?.cNICNumber == null
                              ? "-"
                              : profile.selectedbasicInfo?.cNICNumber ?? "-",
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    ProfileRecordWidget(
                      title: "passportNumber".tr,
                      name: profile.selectedbasicInfo?.passportNumber == ""
                          ? "-"
                          : profile.selectedbasicInfo?.passportNumber == null
                              ? "-"
                              : profile.selectedbasicInfo?.passportNumber ??
                                  "-",
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    ProfileRecordWidget(
                      title: "DHANO".tr,
                      name: profile.selectedbasicInfo?.pMDCNumber == ""
                          ? "-"
                          : profile.selectedbasicInfo?.pMDCNumber == null
                              ? "-"
                              : profile.selectedbasicInfo?.pMDCNumber ?? "-",
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    ProfileRecordWidget(
                      title: "NTNNumber".tr,
                      name: profile.selectedbasicInfo?.nTNNo == ""
                          ? "-"
                          : profile.selectedbasicInfo?.nTNNo == null
                              ? "-"
                              : profile.selectedbasicInfo?.nTNNo ?? "-",
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    ProfileRecordWidget(
                      title: "bloodGroup".tr,
                      name: profile.selectedbasicInfo?.bloodGroupName == ""
                          ? "-"
                          : profile.selectedbasicInfo?.bloodGroupName == null
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
                              : profile.selectedbasicInfo?.religionName ?? "-",
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    ProfileRecordWidget(
                      title: "consultancyFee".tr,
                      name: profile.selectedbasicInfo?.consultationFee
                                  .toString() ==
                              ""
                          ? "-"
                          : profile.selectedbasicInfo?.consultationFee
                              .toString(),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    ProfileRecordWidget(
                      title: "followupfee".tr,
                      name: profile.selectedbasicInfo?.followUpFee.toString() ==
                              ""
                          ? "-"
                          : profile.selectedbasicInfo?.followUpFee.toString(),
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
                              : profile.selectedbasicInfo?.designation ?? "-",
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
    );
  }
}

class ProfileRecordWidget extends StatelessWidget {
  final String? title;
  final String? name;

  const ProfileRecordWidget({Key? key, this.title, this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                '$title',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              ':',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(
              width: Get.width * 0.03,
            ),
            Expanded(
              child: Text(
                '$name',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
