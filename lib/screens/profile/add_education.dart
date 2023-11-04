import 'dart:developer';

import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/components/searchable_dropdown.dart';
import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/countries_model.dart';
import 'package:doctormobileapplication/models/degree.dart';
import 'package:doctormobileapplication/models/institutes.dart';
import 'package:doctormobileapplication/screens/auth_screens/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddEducation extends StatefulWidget {
  const AddEducation({super.key});

  @override
  State<AddEducation> createState() => _AddEducationState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _AddEducationState extends State<AddEducation> {
  var edit = Get.put<EditProfileController>(EditProfileController());
  _getCountries() async {
    ProfileRepo pr = ProfileRepo();
    EditProfileController.i.updatecountriesList(
      await pr.getCountries(),
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

  _getFieldofStudies() async {
    ProfileRepo pr = ProfileRepo();
    EditProfileController.i.updatefieldofstudyList(
      await pr.getFieldofStudy(),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    _getCountries();
    _getDegrees();
    _getFieldofStudies();
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
          'Add Education',
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
                RegisterCustomTextField(
                  validator: (value) {
                    if (value == "Country") {
                      return 'pleaseselectyourcountry'.tr;
                    }
                    return null;
                  },
                  onTap: () async {
                    Countries generic = await searchabledropdown(
                        context, edit.countriesList ?? []);
                    edit.educationselectedCountry = null;
                    edit.updateeducationselectedCountry(generic);

                    if (generic != '') {
                      edit.educationselectedCountry = generic;
                      edit.educationselectedCountry = (generic == '')
                          ? null
                          : edit.educationselectedCountry;
                    }
                    String cid =
                        edit.educationselectedCountry?.id.toString() ?? "";
                    setState(() {
                      _getInstitution(cid);
                    });
                  },
                  readonly: true,
                  suffixIcon: IconButton(
                      onPressed: () async {
                        Countries generic = await searchabledropdown(
                            context, edit.countriesList ?? []);
                        edit.educationselectedCountry = null;
                        edit.updateeducationselectedCountry(generic);

                        if (generic != '') {
                          edit.educationselectedCountry = generic;
                          edit.educationselectedCountry = (generic == '')
                              ? null
                              : edit.educationselectedCountry;
                        }
                        String cid =
                            edit.educationselectedCountry?.id.toString() ?? "";
                        setState(() {
                          _getInstitution(cid);
                        });
                      },
                      icon: Image.asset(Images.dropdown)),
                  hintText: edit.educationselectedCountry?.name == ""
                      ? 'country'.tr
                      : edit.educationselectedCountry?.name ?? "Select country",
                ),
                RegisterCustomTextField(
                  validator: (value) {
                    if (value == "Institution") {
                      return 'Select your institution'.tr;
                    }
                    return null;
                  },
                  onTap: () async {
                    Institutions generic = await searchabledropdown(
                        context, edit.institutionList ?? []);
                    edit.selectedinstitution = null;
                    edit.updateselectedInstitution(generic);

                    if (generic != '') {
                      edit.selectedinstitution = generic;
                      edit.selectedinstitution =
                          (generic == '') ? null : edit.selectedinstitution;
                    }
                  },
                  readonly: true,
                  suffixIcon: IconButton(
                      onPressed: () async {
                        Institutions generic = await searchabledropdown(
                            context, edit.institutionList ?? []);
                        edit.selectedinstitution = null;
                        edit.updateselectedInstitution(generic);

                        if (generic != '') {
                          edit.selectedinstitution = generic;
                          edit.selectedinstitution =
                              (generic == '') ? null : edit.selectedinstitution;
                        }
                      },
                      icon: Image.asset(Images.dropdown)),
                  hintText: edit.selectedinstitution?.name == ""
                      ? 'Institution'.tr
                      : edit.selectedinstitution?.name ?? "Select Institution",
                ),
                RegisterCustomTextField(
                  validator: (value) {
                    if (value == "Degree") {
                      return 'Select your Degree'.tr;
                    }
                    return null;
                  },
                  onTap: () async {
                    Degrees generic = await searchabledropdown(
                        context, edit.degreesList ?? []);
                    edit.selecteddegree = null;
                    edit.updateselecteddegree(generic);

                    if (generic != '') {
                      edit.selecteddegree = generic;
                      edit.selecteddegree =
                          (generic == '') ? null : edit.selecteddegree;
                    }
                  },
                  readonly: true,
                  suffixIcon: IconButton(
                      onPressed: () async {
                        Degrees generic = await searchabledropdown(
                            context, edit.degreesList ?? []);
                        edit.selecteddegree = null;
                        edit.updateselecteddegree(generic);

                        if (generic != '') {
                          edit.selecteddegree = generic;
                          edit.selecteddegree =
                              (generic == '') ? null : edit.selecteddegree;
                        }
                      },
                      icon: Image.asset(Images.dropdown)),
                  hintText: edit.selecteddegree?.name == ""
                      ? 'Degree'.tr
                      : edit.selecteddegree?.name ?? "Select Degree",
                ),
                RegisterCustomTextField(
                  validator: (value) {
                    if (value == "Fieldofstudy") {
                      return 'Select your Field of study'.tr;
                    }
                    return null;
                  },
                  onTap: () async {
                    Degrees generic = await searchabledropdown(
                        context, edit.fieldofstudyList ?? []);
                    edit.selectedfieldofstudy = null;
                    edit.updateselectedfieldofstudy(generic);

                    if (generic != '') {
                      edit.selectedfieldofstudy = generic;
                      edit.selectedfieldofstudy =
                          (generic == '') ? null : edit.selectedfieldofstudy;
                    }
                  },
                  readonly: true,
                  suffixIcon: IconButton(
                      onPressed: () async {
                        Degrees generic = await searchabledropdown(
                            context, edit.fieldofstudyList ?? []);
                        edit.selectedfieldofstudy = null;
                        edit.updateselectedfieldofstudy(generic);

                        if (generic != '') {
                          edit.selectedfieldofstudy = generic;
                          edit.selectedfieldofstudy = (generic == '')
                              ? null
                              : edit.selectedfieldofstudy;
                        }
                      },
                      icon: Image.asset(Images.dropdown)),
                  hintText: edit.selectedfieldofstudy?.name == ""
                      ? 'Field of Study'.tr
                      : edit.selectedfieldofstudy?.name ??
                          "Select Field of Study",
                ),
                RegisterCustomTextField(
                  onTap: () async {
                    await edit.selecteducationstartDateAndTime(
                        context,
                        EditProfileController.degreestart,
                        edit.formatedegreestart);
                  },
                  readonly: true,
                  hintText: edit.formatteddegreestart
                              .toString()
                              .split("T")[0] ==
                          DateTime.now().toString().split(" ")[0]
                      ? "Select Start Date"
                      : DateFormat('MM-dd-y').format(DateTime.parse(
                          edit.formatteddegreestart.toString().split(" ")[0])),
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
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
                      'In Progress',
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: ColorManager.kPrimaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Visibility(
                  visible: edit.inprogressisChecked == false,
                  child: RegisterCustomTextField(
                    onTap: () async {
                      edit.selecteducationendDateAndTime(
                          context,
                          EditProfileController.degreeend,
                          edit.formatedegreeend);
                    },
                    readonly: true,
                    hintText: edit.formatteddegreeend
                                .toString()
                                .split("T")[0] ==
                            DateTime.now().toString().split(" ")[0]
                        ? "Select End Date"
                        : DateFormat('MM-dd-y').format(DateTime.parse(
                            edit.formatteddegreeend.toString().split(" ")[0])),
                  ),
                ),
                Visibility(
                  visible: edit.inprogressisChecked == false,
                  child: RegisterCustomTextField(
                    onTap: () async {
                      edit.selecteducationissueDateAndTime(
                          context,
                          EditProfileController.degreeissue,
                          edit.formatedegreeissue);
                    },
                    readonly: true,
                    hintText:
                        edit.formatteddegreeissue.toString().split("T")[0] ==
                                DateTime.now().toString().split(" ")[0]
                            ? "Select Issue Date"
                            : DateFormat('MM-dd-y').format(DateTime.parse(edit
                                .formatteddegreeissue
                                .toString()
                                .split(" ")[0])),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Grading Scale',
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: ColorManager.kPrimaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Radio(
                      value: "CGPA",
                      groupValue: edit.radioselectedValue,
                      onChanged: (value) {
                        edit.updateradiovalue(value.toString());
                      },
                      activeColor: ColorManager.kPrimaryColor,
                    ),
                    Text(
                      "CGPA",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: ColorManager.kPrimaryColor,
                      ),
                    ),
                    Radio(
                      value: "Marks",
                      groupValue: edit.radioselectedValue,
                      onChanged: (value) {
                        edit.updateradiovalue(value.toString());
                      },
                      activeColor: ColorManager.kPrimaryColor,
                    ),
                    Text(
                      "Marks",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: ColorManager.kPrimaryColor,
                      ),
                    ),
                    Radio(
                      value: "Percentage",
                      groupValue: edit.radioselectedValue,
                      onChanged: (value) {
                        edit.updateradiovalue(value.toString());
                      },
                      activeColor: ColorManager.kPrimaryColor,
                    ),
                    Text(
                      "Percentage",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: ColorManager.kPrimaryColor,
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: edit.radioselectedValue == "CGPA" ||
                      edit.radioselectedValue == "Marks",
                  child: AuthTextField(
                    controller: edit.totalmarks,
                    hintText: 'Total',
                  ),
                ),
                Visibility(
                    visible: edit.radioselectedValue == "CGPA" ||
                        edit.radioselectedValue == "Marks",
                    child: SizedBox(
                      height: Get.height * 0.02,
                    )),
                Visibility(
                  visible: edit.radioselectedValue == "CGPA" ||
                      edit.radioselectedValue == "Marks",
                  child: AuthTextField(
                    controller: edit.obtainedmarks,
                    hintText: 'Obtained',
                  ),
                ),
                Visibility(
                    visible: edit.radioselectedValue == "CGPA" ||
                        edit.radioselectedValue == "Marks",
                    child: SizedBox(
                      height: Get.height * 0.02,
                    )),
                AuthTextField(
                  controller: edit.percentage,
                  hintText: 'Percentage',
                ),
                SizedBox(height: Get.height * 0.03),
                PrimaryButton(
                    fontSize: 15,
                    title: 'Add'.tr,
                    onPressed: () async {},
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
