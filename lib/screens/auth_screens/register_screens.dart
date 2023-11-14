import 'package:doctormobileapplication/components/code_picker.dart';
import 'package:doctormobileapplication/components/custom_radio.dart';
import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/components/searchable_dropdown.dart';
import 'package:doctormobileapplication/components/snackbar.dart';
import 'package:doctormobileapplication/data/controller/registration_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/auth_repo.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/models/cities_model.dart';
import 'package:doctormobileapplication/models/countries_model.dart';
import 'package:doctormobileapplication/models/genders_model.dart';
import 'package:doctormobileapplication/models/marital_status.dart';
import 'package:doctormobileapplication/models/person_title.dart';
import 'package:doctormobileapplication/models/provinces_model.dart';
import 'package:doctormobileapplication/models/speciality.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/auth_screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreens extends StatefulWidget {
  const RegisterScreens({super.key});

  @override
  State<RegisterScreens> createState() => _RegisterScreensState();
}

class _RegisterScreensState extends State<RegisterScreens> {
  @override
  int selectedIndex = 0;

  void selectScreen(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  var controller = Get.put<RegistrationController>(RegistrationController());

  @override
  void initState() {
    super.initState();
    _getSpeciality();
    _getGenders();
    _getCountries();
    _getMaritalStatus();
    _getTitle();
  }

  _getTitle() async {
    AuthRepo ar = AuthRepo();
    RegistrationController.i.updatepersonalTitleList(
      await ar.getPersonalTitle(),
    );
  }

  _getSpeciality() async {
    AuthRepo ar = AuthRepo();
    RegistrationController.i.updatespecialitiesList(
      await ar.getSpecialities(),
    );
  }

  _getSubSpeciality(id) async {
    AuthRepo ar = AuthRepo();
    RegistrationController.i.selectedsubspecialities = null;
    RegistrationController.i.updatesubspecialitiesList(
      await ar.getSubSpecialities(id),
    );
  }

  _getMaritalStatus() async {
    AuthRepo ar = AuthRepo();
    RegistrationController.i.updatemaritalStatusList(
      await ar.getMaritalStatus(),
    );
  }

  _getGenders() async {
    AuthRepo ar = AuthRepo();
    RegistrationController.i.updategenderList(
      await ar.getGendersList(),
    );
  }

  _getCountries() async {
    ProfileRepo pr = ProfileRepo();
    RegistrationController.i.updatecountriesList(
      await pr.getCountries(),
    );
  }

  _getProvinces(cid) async {
    ProfileRepo pr = ProfileRepo();
    RegistrationController.i.updateprovinceList(
      await pr.getProvinces(cid),
    );
  }

  _getCities(cid) async {
    ProfileRepo pr = ProfileRepo();
    RegistrationController.i.updatecitiesList(
      await pr.getCities(cid),
    );
  }

  FocusNode focusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 1.8,
      child: Scaffold(
        body: GetBuilder<RegistrationController>(builder: (cont) {
          return Padding(
            padding: EdgeInsets.only(
                left: Get.width * 0.05,
                right: Get.width * 0.05,
                top: Get.height * 0.02),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    RegisterCustomTextField(
                      validator: (value) {
                        if (controller.selectedpersonalTitle == null) {
                          return 'selectpersonaltitle'.tr;
                        } else {
                          return null;
                        }
                      },
                      onTap: () async {
                        controller.selectedpersonalTitle = null;
                        PTitle generic = await searchabledropdown(
                            context, controller.personalTitleList ?? []);
                        controller.selectedpersonalTitle = null;
                        controller.updateselectedpersonalTitle(generic);

                        if (generic != '') {
                          controller.selectedpersonalTitle = generic;
                          controller.selectedpersonalTitle = (generic == '')
                              ? null
                              : controller.selectedpersonalTitle;
                        }
                      },
                      readonly: true,
                      suffixIcon: IconButton(
                          onPressed: () async {
                            controller.selectedpersonalTitle = null;
                            PTitle generic = await searchabledropdown(
                                context, controller.personalTitleList ?? []);
                            controller.selectedpersonalTitle = null;
                            controller.updateselectedpersonalTitle(generic);

                            if (generic != '') {
                              controller.selectedpersonalTitle = generic;
                              controller.selectedpersonalTitle = (generic == '')
                                  ? null
                                  : controller.selectedpersonalTitle;
                            }
                          },
                          icon: Image.asset(Images.dropdown)),
                      hintText: controller.selectedpersonalTitle == null
                          ? 'title'.tr
                          : controller.selectedpersonalTitle!.name.toString(),
                    ),

                    AuthTextField(
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'enteryourfirstname'.tr;
                        }
                        return null;
                      },
                      controller: controller.firstname,
                      hintText: 'firstname'.tr,
                    ),

                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    AuthTextField(
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'enteryourlastname'.tr;
                        }
                        return null;
                      },
                      controller: controller.lastname,
                      hintText: 'lastname'.tr,
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    RegisterCustomTextField(
                      validator: (p0) {
                        if (controller.selectedgender == null) {
                          return 'selectgender'.tr;
                        }
                        return null;
                      },
                      onTap: () async {
                        controller.selectedgender = null;
                        GendersData generic = await searchabledropdown(
                            context, controller.genderList ?? []);
                        controller.selectedgender = null;
                        controller.updateselectedgender(generic);

                        if (generic != '') {
                          controller.selectedgender = generic;
                          controller.selectedgender = (generic == '')
                              ? null
                              : controller.selectedgender;
                        }
                      },
                      readonly: true,
                      suffixIcon: IconButton(
                          onPressed: () async {
                            controller.selectedgender = null;
                            GendersData generic = await searchabledropdown(
                                context, controller.genderList ?? []);
                            controller.selectedgender = null;
                            controller.updateselectedgender(generic);

                            if (generic != '') {
                              controller.selectedgender = generic;
                              controller.selectedgender = (generic == '')
                                  ? null
                                  : controller.selectedgender;
                            }
                          },
                          icon: Image.asset(Images.dropdown)),
                      hintText: controller.selectedgender == null
                          ? 'gender'.tr
                          : controller.selectedgender!.name.toString(),
                    ),
                    RegisterCustomTextField(
                      validator: (p0) {
                        if (controller.selectedmaritalStatus == null) {
                          return 'selectmaritalstatus'.tr;
                        }
                        return null;
                      },
                      onTap: () async {
                        controller.selectedmaritalStatus = null;
                        MSData generic = await searchabledropdown(
                            context, controller.maritalStatusList ?? []);
                        controller.selectedmaritalStatus = null;
                        controller.updateselectedmaritalStatus(generic);

                        if (generic != '') {
                          controller.selectedmaritalStatus = generic;
                          controller.selectedmaritalStatus = (generic == '')
                              ? null
                              : controller.selectedmaritalStatus;
                        }
                      },
                      readonly: true,
                      suffixIcon: IconButton(
                          onPressed: () async {
                            controller.selectedmaritalStatus = null;
                            MSData generic = await searchabledropdown(
                                context, controller.maritalStatusList ?? []);
                            controller.selectedmaritalStatus = null;
                            controller.updateselectedmaritalStatus(generic);

                            if (generic != '') {
                              controller.selectedmaritalStatus = generic;
                              controller.selectedmaritalStatus = (generic == '')
                                  ? null
                                  : controller.selectedmaritalStatus;
                            }
                          },
                          icon: Image.asset(Images.dropdown)),
                      hintText: controller.selectedmaritalStatus == null
                          ? 'maritalstatus'.tr
                          : controller.selectedmaritalStatus!.name.toString(),
                    ),

                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomRadioTile(
                            title: 'nationalid'.tr,
                            value: 'idno',
                            groupValue: controller.selectedRadioValue,
                            onChanged: (value) {
                              // setState(() {
                              //   selectedRadioValue = value!;
                              // });
                              controller.updateRadioValue(value);
                            },
                          ),
                          CustomRadioTile(
                            title: 'passport'.tr,
                            value: 'passport',
                            groupValue: controller.selectedRadioValue,
                            onChanged: (value) {
                              // setState(() {
                              //   selectedRadioValue = value!;
                              // });
                              controller.updateRadioValue(value);
                            },
                          ),
                        ],
                      ),
                    ),

                    Visibility(
                      visible: controller.selectedRadioValue == "idno",
                      child: IdNoAuthTextField(
                        onChangedwidget: (value) {
                          AuthRepo ar = AuthRepo();
                          ar.pmdcAvaibility(controller.imcno.text);
                        },
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'EnterIDNumber'.tr;
                          }
                          return null;
                        },
                        controller: controller.idnumber,
                        hintText: 'nationalid'.tr,
                      ),
                    ),
                    Visibility(
                      visible: controller.selectedRadioValue == "passport",
                      child: AuthTextField(
                        onChangedwidget: (value) {
                          AuthRepo ar = AuthRepo();
                          ar.pmdcAvaibility(controller.imcno.text);
                        },
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'EnterPassportNumber'.tr;
                          }
                          return null;
                        },
                        controller: controller.idnumber,
                        hintText: 'passportNumber'.tr,
                      ),
                    ),
                    // IdNoAuthTextField(
                    //   onChangedwidget: (value) {
                    //     AuthRepo ar = AuthRepo();
                    //     if (controller.selectedRadioValue == "idno") {
                    //       ar.cnicAvaibility(controller.idnumber.text);
                    //     } else if (controller.selectedRadioValue ==
                    //         "passport") {
                    //       ar.passportAvaibility(controller.idnumber.text);
                    //     }
                    //   },
                    //   validator: (p0) {
                    //     if (p0!.isEmpty) {
                    //       if (controller.selectedRadioValue == "idno") {
                    //         return 'enteryouridnumber'.tr;
                    //       } else {
                    //         return 'Enter Your Passport No';
                    //       }
                    //     }
                    //     return null;
                    //   },
                    //   controller: controller.idnumber,
                    //   hintText: controller.selectedRadioValue == "idno"
                    //       ? 'idnumber'.tr
                    //       : 'passport'.tr,
                    // ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    AuthTextField(
                      onChangedwidget: (value) {
                        AuthRepo ar = AuthRepo();
                        ar.pmdcAvaibility(controller.imcno.text);
                      },
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'enteryourimcno'.tr;
                        }
                        return null;
                      },
                      controller: controller.imcno,
                      hintText: 'imcno'.tr,
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    InkWell(
                      onTap: () {
                        controller.picksinglefile();
                      },
                      child: Container(
                        width: Get.width * 1, // Adjust the width as needed
                        height: Get.height * 0.06,
                        decoration: BoxDecoration(
                          color: ColorManager.kPrimaryColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                            child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'add'.tr,
                                style: const TextStyle(
                                    color: ColorManager.kWhiteColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: 'legalmedicalpractisingcertificate'.tr,
                                style: const TextStyle(
                                  color: ColorManager.kWhiteColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        )

                            //  Text(
                            //   'Add (legal medical practising certificate)',
                            //   style: GoogleFonts.poppins(
                            //     color: ColorManager.kWhiteColor,
                            //     fontSize: 12,
                            //   ),
                            // ),
                            ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    RegisterCustomTextField(
                      validator: (p0) {
                        if (controller.selectedspecialities == null) {
                          return 'SelectSpeciality'.tr;
                        }
                        return null;
                      },
                      onTap: () async {
                        controller.selectedspecialities = null;
                        Specialities1 generic = await searchabledropdown(
                            context, controller.specialitiesList ?? []);
                        controller.selectedspecialities = null;
                        controller.updateselectedspeciality(generic);

                        if (generic != '') {
                          controller.selectedspecialities = generic;
                          controller.selectedspecialities = (generic == '')
                              ? null
                              : controller.selectedspecialities;
                        }

                        setState(() {
                          _getSubSpeciality(generic.id);
                        });
                      },
                      readonly: true,
                      suffixIcon: IconButton(
                          onPressed: () async {
                            controller.selectedspecialities = null;
                            Specialities1 generic = await searchabledropdown(
                                context, controller.specialitiesList ?? []);
                            controller.selectedspecialities = null;
                            controller.updateselectedspeciality(generic);

                            if (generic != '') {
                              controller.selectedspecialities = generic;
                              controller.selectedspecialities = (generic == '')
                                  ? null
                                  : controller.selectedspecialities;
                            }

                            setState(() {
                              _getSubSpeciality(generic.id);
                            });
                          },
                          icon: Image.asset(Images.dropdown)),
                      hintText: controller.selectedspecialities == null
                          ? 'speciality'.tr
                          : controller.selectedspecialities!.name.toString(),
                    ),
                    // SizedBox(
                    //   height: Get.height * 0.02,
                    // ),

                    // SUB
                    RegisterCustomTextField(
                      validator: (p0) {
                        if (controller.selectedsubspecialities == null) {
                          return 'SelectSubSpeciality'.tr;
                        }
                        return null;
                      },
                      onTap: () async {
                        controller.selectedsubspecialities = null;
                        Specialities1 generic = await searchabledropdown(
                            context, controller.subspecialitiesList ?? []);
                        controller.selectedsubspecialities = null;
                        controller.updateselectedspeciality(generic);

                        if (generic != '') {
                          controller.selectedsubspecialities = generic;
                          controller.selectedsubspecialities = (generic == '')
                              ? null
                              : controller.selectedsubspecialities;
                        }
                      },
                      readonly: true,
                      suffixIcon: IconButton(
                          onPressed: () async {
                            controller.selectedsubspecialities = null;
                            Specialities1 generic = await searchabledropdown(
                                context, controller.subspecialitiesList ?? []);
                            controller.selectedsubspecialities = null;
                            controller.updateselectedspeciality(generic);

                            if (generic != '') {
                              controller.selectedsubspecialities = generic;
                              controller.selectedsubspecialities =
                                  (generic == '')
                                      ? null
                                      : controller.selectedsubspecialities;
                            }
                          },
                          icon: Image.asset(Images.dropdown)),
                      hintText: controller.selectedsubspecialities == null
                          ? 'subspeciality'.tr
                          : controller.selectedsubspecialities!.name.toString(),
                    ),
                    // SizedBox(
                    //   height: Get.height * 0.02,
                    // ),
                    InkWell(
                      onTap: () {
                        controller.ontap = true;
                        RegistrationController.i.selectDateAndTime(
                            context,
                            RegistrationController.arrival,
                            controller.formatearrival);
                      },
                      child: Container(
                        width: Get.width * 1, // Adjust the width as needed
                        height: Get.height * 0.06,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorManager.kGreyColor,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                          color: ColorManager.kWhiteColor,
                        ),

                        child: Padding(
                          padding: EdgeInsets.only(
                              left: Get.width * 0.03, right: Get.width * 0.01),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.ontap == true
                                    ? RegistrationController.i.formatearrival
                                        .toString()
                                    : "dateofbirth".tr,
                                style: GoogleFonts.poppins(
                                  color: ColorManager.kGreyColor,
                                  fontSize: 12,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.ontap = true;
                                  RegistrationController.i.selectDateAndTime(
                                      context,
                                      RegistrationController.arrival,
                                      controller.formatearrival);
                                },
                                icon: Image.asset(
                                  AppImages.schedule,
                                  height: 25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    // RegisterCustomTextField(
                    //   readonly: true,
                    //   hintText: controller.userage == ''
                    //       ? 'age'.tr
                    //       : controller.userage,
                    // ),

                    CustomIntlPhoneField(
                      onChanged: (phone) {
                        controller.updatecountryfullno(phone.completeNumber);
                      },
                      style: GoogleFonts.poppins(
                          color: ColorManager.kGreyColor, fontSize: 12),
                      // showDropdownIcon: true,
                      dropdownIcon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                        size: 10,
                      ),

                      dropdownTextStyle: GoogleFonts.poppins(
                          color: ColorManager.kGreyColor, fontSize: 12),
                      showCountryFlag: false,
                      initialCountryCode: 'AE',
                      controller: controller.phone,
                      disableLengthCheck: false,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: ColorManager.kGreyColor)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: ColorManager.kGreyColor)),
                          border: InputBorder.none),
                      languageCode: "en",
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    AuthTextField(
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'enteryouremail'.tr;
                        }
                        return null;
                      },
                      controller: controller.email,
                      hintText: 'email'.tr,
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    RegisterCustomTextField(
                      validator: (p0) {
                        if (controller.selectedcountry == null) {
                          return 'pleaseselectyourcountry'.tr;
                        }
                        return null;
                      },
                      onTap: () async {
                        controller.selectedcountry = null;
                        controller.selectedcity = null;
                        controller.citiesList.clear();
                        controller.selectedprovince = null;

                        Countries generic = await searchabledropdown(
                            context, controller.countriesList ?? []);
                        controller.selectedcountry = null;
                        controller.updateselectedCountry(generic);

                        if (generic != '') {
                          controller.selectedcountry = generic;
                          controller.selectedcountry = (generic == '')
                              ? null
                              : controller.selectedcountry;
                        }
                        String cid = RegistrationController
                            .i.selectedcountry!.id
                            .toString();
                        setState(() {
                          _getProvinces(cid);
                        });
                      },
                      readonly: true,
                      suffixIcon: IconButton(
                          onPressed: () async {
                            controller.selectedcountry = null;
                            controller.selectedcity = null;
                            controller.citiesList.clear();
                            controller.selectedprovince = null;

                            Countries generic = await searchabledropdown(
                                context, controller.countriesList ?? []);
                            controller.selectedcountry = null;
                            controller.updateselectedCountry(generic);

                            if (generic != '') {
                              controller.selectedcountry = generic;
                              controller.selectedcountry = (generic == '')
                                  ? null
                                  : controller.selectedcountry;
                            }
                            String cid = RegistrationController
                                .i.selectedcountry!.id
                                .toString();
                            setState(() {
                              _getProvinces(cid);
                            });
                          },
                          icon: Image.asset(Images.dropdown)),
                      hintText: controller.selectedcountry == null
                          ? 'country'.tr
                          : controller.selectedcountry!.name.toString(),
                    ),
                    RegisterCustomTextField(
                      validator: (p0) {
                        if (controller.selectedprovince == null) {
                          return 'pleaseselectyourprovince'.tr;
                        }
                        return null;
                      },
                      readonly: true,
                      onTap: () async {
                        controller.selectedprovince = null;
                        controller.selectedcity = null;
                        Provinces generic = await searchabledropdown(
                            context, controller.provinceList ?? []);
                        controller.selectedprovince = null;
                        controller.updateselectedprovince(generic);

                        if (generic != '') {
                          controller.selectedprovince = generic;
                          controller.selectedprovince = (generic == '')
                              ? null
                              : controller.selectedprovince;
                        }
                        String cid = RegistrationController
                            .i.selectedprovince!.id
                            .toString();
                        setState(() {
                          _getCities(cid);
                        });
                      },
                      suffixIcon: IconButton(
                          onPressed: () async {
                            controller.selectedprovince = null;
                            controller.selectedcity = null;
                            Provinces generic = await searchabledropdown(
                                context, controller.provinceList ?? []);
                            controller.selectedprovince = null;
                            controller.updateselectedprovince(generic);

                            if (generic != '') {
                              controller.selectedprovince = generic;
                              controller.selectedprovince = (generic == '')
                                  ? null
                                  : controller.selectedprovince;
                            }
                            String cid = RegistrationController
                                .i.selectedprovince!.id
                                .toString();
                            setState(() {
                              _getCities(cid);
                            });
                          },
                          icon: Image.asset(Images.dropdown)),
                      hintText: controller.selectedprovince == null
                          ? 'state'.tr
                          : controller.selectedprovince!.name.toString(),
                    ),
                    RegisterCustomTextField(
                      validator: (p0) {
                        if (controller.selectedcity == null) {
                          return 'pleaseselectyourcity'.tr;
                        }
                        return null;
                      },
                      readonly: true,
                      onTap: () async {
                        controller.selectedcity = null;
                        Cities generic = await searchabledropdown(
                            context, controller.citiesList ?? []);
                        controller.selectedcity = null;
                        controller.updateselectedcity(generic);

                        if (generic != '') {
                          controller.selectedcity = generic;
                          controller.selectedcity =
                              (generic == '') ? null : controller.selectedcity;
                        }
                        setState(() {});
                      },
                      suffixIcon: IconButton(
                          onPressed: () async {
                            controller.selectedcity = null;
                            Cities generic = await searchabledropdown(
                                context, controller.citiesList ?? []);
                            controller.selectedcity = null;
                            controller.updateselectedcity(generic);

                            if (generic != '') {
                              controller.selectedcity = generic;
                              controller.selectedcity = (generic == '')
                                  ? null
                                  : controller.selectedcity;
                            }
                            setState(() {});
                          },
                          icon: Image.asset(Images.dropdown)),
                      hintText: controller.selectedcity == null
                          ? 'city'.tr
                          : controller.selectedcity!.name.toString(),
                    ),
                    AuthTextField(
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'pleaseselectyouraddress'.tr;
                        }
                        return null;
                      },
                      controller: controller.address,
                      hintText: 'address'.tr,
                    ),
                    SizedBox(
                      height: Get.height * 0.06,
                    ),
                    PrimaryButton(
                        title: 'saveandproceed'.tr,
                        onPressed: () async {
                          if (_formKey.currentState!.validate() &&
                                  // controller.file != null &&
                                  controller.pmcfile != null &&
                                  controller.ontap == true
                              // &&
                              // controller.selectedcity?.id != null &&
                              // controller.selectedprovince?.id != null &&
                              // controller.selectedcountry?.id != null &&
                              // controller.selectedpersonalTitle?.id != null &&
                              // controller.selectedgender?.id != null &&
                              // controller.selectedmaritalStatus?.id != null
                              ) {
                            showSnackbar(context, 'saveRecord'.tr);
                            controller.setPageIndexofDayPersonal(1);
                          } else {
                            if (controller.pmcfile == null) {
                              showSnackbar(context, 'Add LMPC Certificate');
                            }
                            if (controller.ontap == false) {
                              showSnackbar(context, 'Add Date of Birth');
                            }
                          }

                          //     {
                          //   if (RegistrationController.i.pmdcavaibility ==
                          //       false) {
                          //     showSnackbar(
                          //         context, "LMPC Number Already Taken");
                          //   }
                          //   else if (controller.selectedRadioValue ==
                          //           "idno" &&
                          //       RegistrationController.i.idnoavaibility ==
                          //           false) {
                          //     showSnackbar(context, "Id Number Already Taken");
                          //   } else if (controller.selectedRadioValue ==
                          //           "passport" &&
                          //       RegistrationController.i.passportavaibility ==
                          //           false) {
                          //     showSnackbar(
                          //         context, "Passport Number Already Taken");
                          //   } else {
                          //     showSnackbar(context, 'saveRecord'.tr);
                          //     controller.setPageIndexofDayPersonal(1);
                          //   }
                          // } else {
                          //   if (controller.file == null) {
                          //     showSnackbar(context, 'addpicture'.tr);
                          //   } else
                          //if (controller.pmcfile == null) {
                          //     showSnackbar(context, 'Add LMPC Certificate');
                          //   } else if (controller.selectedpersonalTitle?.id ==
                          //       null) {
                          //     showSnackbar(context, 'selecttitle'.tr);
                          //   } else if (controller.selectedgender?.id == null) {
                          //     showSnackbar(context, 'selectgender'.tr);
                          //   } else if (controller.selectedmaritalStatus?.id ==
                          //       null) {
                          //     showSnackbar(context, 'Select Marital Status');
                          //   } else if (controller.selectedcountry?.id == null) {
                          //     showSnackbar(
                          //         context, 'pleaseselectyourcountry'.tr);
                          //   } else if (controller.selectedprovince?.id ==
                          //       null) {
                          //     showSnackbar(
                          //         context, 'pleaseselectyourprovince'.tr);
                          //   } else if (controller.selectedcity?.id == null) {
                          //     showSnackbar(context, 'pleaseselectyourcity'.tr);
                          //   }
                          // }
                        },
                        color: ColorManager.kPrimaryColor,
                        textcolor: ColorManager.kWhiteColor),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    SignupOrLoginText(
                      pre: 'alreadyHaveAnAccount'.tr,
                      suffix: 'signin'.tr,
                      onTap: () {
                        Get.to(() => const LoginScreen());
                      },
                    ),
                    SizedBox(
                      height: Get.height * 0.04,
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
