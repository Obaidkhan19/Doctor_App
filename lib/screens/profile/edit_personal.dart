import 'package:doctormobileapplication/components/custom_checkbox_dropdown.dart';
import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/components/searchable_dropdown.dart';
import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
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
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EditPersonal extends StatefulWidget {
  const EditPersonal({super.key});

  @override
  State<EditPersonal> createState() => _EditPersonalState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _EditPersonalState extends State<EditPersonal> {
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

  @override
  Widget build(BuildContext context) {
    var edit = Get.put<EditProfileController>(EditProfileController());
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
          'editPersonal'.tr,
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
                        edit.selectedpersonalTitle =
                            (generic == '') ? null : edit.selectedpersonalTitle;
                      }
                    },
                    readonly: true,
                    hintText: edit.selectedpersonalTitle?.name == ""
                        ? 'title'.tr
                        : edit.selectedpersonalTitle?.name.toString(),
                  ),

                  Visibility(
                    visible: edit.selectedpersonalTitle?.name == 'Other',
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
                        edit.selectedgender =
                            (generic == '') ? null : edit.selectedgender;
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
                        edit.selectedmaritalStatus =
                            (generic == '') ? null : edit.selectedmaritalStatus;
                      }
                    },
                    readonly: true,
                    hintText: edit.selectedmaritalStatus?.name == ""
                        ? 'maritalstatus'.tr
                        : edit.selectedmaritalStatus?.name.toString(),
                  ),

                  // Center(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       CustomRadioTile(
                  //         title: 'nationalid'.tr,
                  //         value: 'idno',
                  //         groupValue: edit.selectedRadioValue,
                  //         onChanged: (value) {
                  //           // setState(() {
                  //           //   selectedRadioValue = value!;
                  //           // });
                  //           edit.updateRadioValue(value);
                  //         },
                  //       ),
                  //       CustomRadioTile(
                  //         title: 'passport'.tr,
                  //         value: 'passport',
                  //         groupValue: edit.selectedRadioValue,
                  //         onChanged: (value) {
                  //           // setState(() {
                  //           //   selectedRadioValue = value!;
                  //           // });
                  //           edit.updateRadioValue(value);
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(height: Get.height * 0.02),
                  // AuthTextField(
                  //   validator: (p0) {
                  //     if (p0!.isEmpty) {
                  //       if (edit.selectedRadioValue == "idno") {
                  //         return 'enteryouridnumber'.tr;
                  //       } else {
                  //         return 'Enter Your Passport No';
                  //       }
                  //     }
                  //     return null;
                  //   },
                  //   controller: edit.idnumber,
                  //   hintText: edit.selectedRadioValue == "idno"
                  //       ? 'idnumber'.tr
                  //       : 'passport'.tr,
                  // ),
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
                      width: Get.width * 1, // Adjust the width as needed
                      height: Get.height * 0.07,
                      decoration: BoxDecoration(
                        color: ColorManager.kPrimaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          'addLMPC'.tr,
                          style: GoogleFonts.poppins(
                            color: ColorManager.kWhiteColor,
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
                        edit.selectedbloodgroup =
                            (generic == '') ? null : edit.selectedbloodgroup;
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
                        edit.selectedreligion =
                            (generic == '') ? null : edit.selectedreligion;
                      }
                    },
                    readonly: true,
                    hintText: edit.selectedreligion?.name == ""
                        ? 'Religion'
                        : edit.selectedreligion?.name.toString(),
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       'Designation(s)',
                  //       style: GoogleFonts.poppins(
                  //         textStyle: GoogleFonts.poppins(
                  //           fontSize: 12,
                  //           color: Colors.black,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  EditProfileCustomTextField(
                      onTap: () async {
                        Designations generic = await searchabledropdown(
                            context, edit.designationList ?? []);
                        await edit.addDesignation(generic, BuildContext);
                        setState(() {});
                      },
                      readonly: true,
                      hintText: 'designations'.tr),

                  SizedBox(
                    height: Get.height * 0.01,
                  ),
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
                                  index < edit.selecteddesignationList.length;
                                  index++)
                                InkWell(
                                  onTap: () {
                                    String cid =
                                        edit.selecteddesignationList[index].id!;
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
                                            child: Image.asset(AppImages.cross),
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
                                              style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                color: ColorManager.kblackColor,
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
                      edit.selectDateAndTime(context,
                          EditProfileController.arrival, edit.formatearrival);
                    },
                    readonly: true,
                    hintText: DateFormat('MM-dd-y').format(DateTime.parse(
                        edit.formattedArrival.toString().split("T")[0])),
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
                        edit.selectedrelation =
                            (generic == '') ? null : edit.selectedrelation;
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
                        // UPLOAD CERTIFICATE
                        String filepath = "";
                        if (edit.pmcfile != null) {
                          AuthRepo ar = AuthRepo();
                          await ar.uploadFile(edit.pmcfile!);
                        }

                        ProfileRepo pr = ProfileRepo();
                        // if (EditProfileController.i.selectedRadioValue ==
                        //     'idno') {
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
                          Get.back(result: true);
                        }
                        // } else {
                        //   // call passport

                        //   String res = await pr.updatePersonalInfoPassport(
                        //     edit.customprefixtitle.text,
                        //     edit.selectedpersonalTitle?.id ?? "",
                        //     edit.firstname.text,
                        //     edit.middlename.text,
                        //     edit.lastname.text,
                        //     edit.formattedArrival,
                        //     edit.selectedmaritalStatus?.id ?? "",
                        //     edit.guardianname.text,
                        //     edit.selectedrelation?.id ?? "",
                        //     edit.selectedgender?.id ?? "",
                        //     edit.idnumber.text,
                        //     edit.imcno.text,
                        //     filepath,
                        //     edit.ntnnumber.text,
                        //     edit.consultancyfee.text,
                        //     edit.followupfee.text,
                        //     edit.selectedbloodgroup?.id ?? "",
                        //     edit.selectedreligion?.id ?? "",
                        //     edit.selecteddesignationIdList,
                        //   );
                        //   if (res == "true") {
                        //     Get.back(result: true);
                        //   }
                        // }
                      },
                      color: ColorManager.kPrimaryColor,
                      textcolor: ColorManager.kWhiteColor),
                  SizedBox(height: Get.height * 0.03),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
