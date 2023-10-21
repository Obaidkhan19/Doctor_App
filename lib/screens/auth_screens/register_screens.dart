import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
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
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/auth_screens/login.dart';
import 'package:flutter/material.dart';
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
          return BlurryModalProgressHUD(
            inAsyncCall: controller.isSavingPath,
            blurEffectIntensity: 4,
            progressIndicator: const SpinKitSpinningLines(
              color: Color(0xfff1272d3),
              size: 60,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: Get.width * 0.06,
                  right: Get.width * 0.06,
                  top: Get.height * 0.05),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      RegisterCustomTextField(
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
                                controller.selectedpersonalTitle =
                                    (generic == '')
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
                                controller.selectedmaritalStatus =
                                    (generic == '')
                                        ? null
                                        : controller.selectedmaritalStatus;
                              }
                            },
                            icon: Image.asset(Images.dropdown)),
                        hintText: controller.selectedmaritalStatus == null
                            ? 'maritalstatus'.tr
                            : controller.selectedmaritalStatus!.name.toString(),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      //  Text(
                      //   'prescribedby'.tr,
                      //   style: GoogleFonts.poppins(
                      //       fontSize: 15,
                      //       color: ColorManager.kPrimaryColor,
                      //       fontWeight: FontWeight.bold),
                      // ),
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
                      SizedBox(height: Get.height * 0.02),
                      AuthTextField(
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'enteryouridnumber'.tr;
                          }
                          return null;
                        },
                        controller: controller.idnumber,
                        hintText: 'idnumber'.tr,
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      AuthTextField(
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
                          height: Get.height * 0.08,
                          decoration: BoxDecoration(
                            color: ColorManager.kPrimaryColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              'Add LMPC',
                              style: GoogleFonts.poppins(
                                color: ColorManager.kWhiteColor,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      RegisterCustomTextField(
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
                                controller.selectedspecialities =
                                    (generic == '')
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
                                  context,
                                  controller.subspecialitiesList ?? []);
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
                            : controller.selectedsubspecialities!.name
                                .toString(),
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
                          height: Get.height * 0.08,
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
                                left: Get.width * 0.03,
                                right: Get.width * 0.01),
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
                        showDropdownIcon: true,
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
                        disableLengthCheck: true,
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
                        validator: (value) {
                          if (value == "Country") {
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
                        validator: (value) {
                          if (value == "Province") {
                            return 'Please select your State'.tr;
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
                            ? 'State'
                            : controller.selectedprovince!.name.toString(),
                      ),
                      RegisterCustomTextField(
                        validator: (value) {
                          if (value == "City") {
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
                            controller.selectedcity = (generic == '')
                                ? null
                                : controller.selectedcity;
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
                                (controller.file != null &&
                                    controller.pmcfile != null &&
                                    controller.selectedcity?.id != null &&
                                    controller.selectedprovince?.id != null &&
                                    controller.selectedcountry?.id != null &&
                                    controller.selectedpersonalTitle?.id !=
                                        null &&
                                    controller.selectedgender?.id != null &&
                                    controller.selectedmaritalStatus?.id !=
                                        null)) {
                              // controller.updateIsSavingPath(true);
                              // AuthRepo ar = AuthRepo();

                              // String path =
                              //     await ar.uploadPicture(controller.file!);

                              // String filepath =
                              //     await ar.uploadFile(controller.pmcfile!);
                              // controller.updatefilepath(filepath);
                              // controller.updateimagepath(path);

                              // controller.updateIsSavingPath(false);
                              showSnackbar(context, 'saveRecord'.tr);
                              controller.setPageIndexofDayPersonal(1);
                            } else {
                              if (controller.file == null) {
                                showSnackbar(context, 'addpicture'.tr);
                              } else if (controller.pmcfile == null) {
                                showSnackbar(context, 'Add LMPC Certificate');
                              } else if (controller.selectedpersonalTitle?.id ==
                                  null) {
                                showSnackbar(context, 'selecttitle'.tr);
                              } else if (controller.selectedgender?.id ==
                                  null) {
                                showSnackbar(context, 'selectgender'.tr);
                              } else if (controller.selectedmaritalStatus?.id ==
                                  null) {
                                showSnackbar(context, 'Select Marital Status');
                              } else if (controller.selectedcountry?.id ==
                                  null) {
                                showSnackbar(
                                    context, 'pleaseselectyourcountry'.tr);
                              } else if (controller.selectedprovince?.id ==
                                  null) {
                                showSnackbar(
                                    context, 'pleaseselectyourprovince'.tr);
                              } else if (controller.selectedcity?.id == null) {
                                showSnackbar(
                                    context, 'pleaseselectyourcity'.tr);
                              }
                            }
                          },
                          color: ColorManager.kPrimaryColor,
                          textcolor: ColorManager.kWhiteColor),
                      SizedBox(
                        height: Get.height * 0.03,
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
            ),
          );
        }),
      ),
    );
  }
}
