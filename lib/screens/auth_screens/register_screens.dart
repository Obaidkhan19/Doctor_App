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
import 'package:fluttertoast/fluttertoast.dart';
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
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.04,
                    ),
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
                            context, controller.personalTitleList);
                        controller.selectedpersonalTitle = null;
                        controller.updateselectedpersonalTitle(generic);

                        if (generic.id != null) {
                          controller.selectedpersonalTitle = generic;
                          controller.selectedpersonalTitle =
                              (generic.id == null)
                                  ? null
                                  : controller.selectedpersonalTitle;
                        }
                      },
                      readonly: true,
                      suffixIcon: IconButton(
                          onPressed: () async {
                            controller.selectedpersonalTitle = null;
                            PTitle generic = await searchabledropdown(
                                context, controller.personalTitleList);
                            controller.selectedpersonalTitle = null;
                            controller.updateselectedpersonalTitle(generic);

                            if (generic.id != null) {
                              controller.selectedpersonalTitle = generic;
                              controller.selectedpersonalTitle =
                                  (generic.id == null)
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
                            context, controller.genderList);
                        controller.selectedgender = null;
                        controller.updateselectedgender(generic);

                        if (generic.id != null) {
                          controller.selectedgender = generic;
                          controller.selectedgender = (generic.id == null)
                              ? null
                              : controller.selectedgender;
                        }
                      },
                      readonly: true,
                      suffixIcon: IconButton(
                          onPressed: () async {
                            controller.selectedgender = null;
                            GendersData generic = await searchabledropdown(
                                context, controller.genderList);
                            controller.selectedgender = null;
                            controller.updateselectedgender(generic);

                            if (generic.id != null) {
                              controller.selectedgender = generic;
                              controller.selectedgender = (generic.id == null)
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
                            context, controller.maritalStatusList);
                        controller.selectedmaritalStatus = null;
                        controller.updateselectedmaritalStatus(generic);

                        if (generic.id != null) {
                          controller.selectedmaritalStatus = generic;
                          controller.selectedmaritalStatus =
                              (generic.id == null)
                                  ? null
                                  : controller.selectedmaritalStatus;
                        }
                      },
                      readonly: true,
                      suffixIcon: IconButton(
                          onPressed: () async {
                            controller.selectedmaritalStatus = null;
                            MSData generic = await searchabledropdown(
                                context, controller.maritalStatusList);
                            controller.selectedmaritalStatus = null;
                            controller.updateselectedmaritalStatus(generic);

                            if (generic.id != null) {
                              controller.selectedmaritalStatus = generic;
                              controller.selectedmaritalStatus =
                                  (generic.id == null)
                                      ? null
                                      : controller.selectedmaritalStatus;
                            }
                          },
                          icon: Image.asset(Images.dropdown)),
                      hintText: controller.selectedmaritalStatus == null
                          ? 'maritalstatus'.tr
                          : controller.selectedmaritalStatus!.name.toString(),
                      isSizedBoxAvailable: false,
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

                    RegisterLMPCCustomTextField(
                      readonly: true,
                      onTap: () {
                        controller.picksinglefile();
                      },
                      validator: (p0) {
                        if (controller.pmcfile == null) {
                          return 'pleaseaddLMPC'.tr;
                        }
                        return null;
                      },
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
                            context, controller.specialitiesList);
                        controller.selectedspecialities = null;
                        controller.updateselectedspeciality(generic);

                        if (generic.id != null) {
                          controller.selectedspecialities = generic;
                          controller.selectedspecialities = (generic.id == null)
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
                                context, controller.specialitiesList);
                            controller.selectedspecialities = null;
                            controller.updateselectedspeciality(generic);

                            if (generic.id != null) {
                              controller.selectedspecialities = generic;
                              controller.selectedspecialities =
                                  (generic.id == null)
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
                        if (controller.selectedspecialities != null) {
                          controller.selectedsubspecialities = null;
                          Specialities1 generic = await searchabledropdown(
                              context, controller.subspecialitiesList);
                          controller.selectedsubspecialities = null;
                          controller.updateselectedspeciality(generic);

                          if (generic.id != null) {
                            controller.selectedsubspecialities = generic;
                            controller.selectedsubspecialities =
                                (generic.id == null)
                                    ? null
                                    : controller.selectedsubspecialities;
                          }
                        }
                      },
                      readonly: true,
                      suffixIcon: IconButton(
                          onPressed: () async {
                            if (controller.selectedspecialities != null) {
                              controller.selectedsubspecialities = null;
                              Specialities1 generic = await searchabledropdown(
                                  context, controller.subspecialitiesList);
                              controller.selectedsubspecialities = null;
                              controller.updateselectedspeciality(generic);

                              if (generic.id != null) {
                                controller.selectedsubspecialities = generic;
                                controller.selectedsubspecialities =
                                    (generic.id == null)
                                        ? null
                                        : controller.selectedsubspecialities;
                              }
                            }
                          },
                          icon: Image.asset(Images.dropdown)),
                      hintText: controller.selectedsubspecialities == null
                          ? 'subspeciality'.tr
                          : controller.selectedsubspecialities!.name.toString(),
                    ),
                    RegisterDOBCustomTextField(
                      readonly: true,
                      validator: (p0) {
                        if (controller.ontap == false) {
                          return 'PleaseselectDateofBirth'.tr;
                        }
                        return null;
                      },
                      onTap: () {
                        controller.ontap = true;
                        RegistrationController.i.selectDateAndTime(
                            context,
                            RegistrationController.arrival,
                            controller.formatearrival);
                      },
                      hintText: controller.ontap == true
                          ? RegistrationController.i.formatearrival.toString()
                          : "dateofbirth".tr,
                      suffixIcon: IconButton(
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
                    ),

                    CustomIntlPhoneField(
                      errorColor: ColorManager.kRedColor,
                      style: GoogleFonts.poppins(
                          color: ColorManager.kGreyColor, fontSize: 12),
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
                      height: Get.height * 0.01,
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
                            context, controller.countriesList);
                        controller.selectedcountry = null;
                        controller.updateselectedCountry(generic);

                        if (generic.id != null) {
                          controller.selectedcountry = generic;
                          controller.selectedcountry = (generic.id == null)
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
                                context, controller.countriesList);
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
                        if (controller.selectedcountry != null) {
                          controller.selectedprovince = null;
                          controller.selectedcity = null;
                          Provinces generic = await searchabledropdown(
                              context, controller.provinceList);
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
                        }
                      },
                      suffixIcon: IconButton(
                          onPressed: () async {
                            if (controller.selectedcountry != null) {
                              controller.selectedprovince = null;
                              controller.selectedcity = null;
                              Provinces generic = await searchabledropdown(
                                  context, controller.provinceList);
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
                            }
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
                        if (controller.selectedcountry != null &&
                            controller.selectedprovince != null) {
                          controller.selectedcity = null;
                          Cities generic = await searchabledropdown(
                              context, controller.citiesList);
                          controller.selectedcity = null;
                          controller.updateselectedcity(generic);

                          if (generic != '') {
                            controller.selectedcity = generic;
                            controller.selectedcity = (generic == '')
                                ? null
                                : controller.selectedcity;
                          }
                          setState(() {});
                        }
                      },
                      suffixIcon: IconButton(
                          onPressed: () async {
                            if (controller.selectedcountry != null &&
                                controller.selectedprovince != null) {
                              controller.selectedcity = null;
                              Cities generic = await searchabledropdown(
                                  context, controller.citiesList);
                              controller.selectedcity = null;
                              controller.updateselectedcity(generic);

                              if (generic.id != null) {
                                controller.selectedcity = generic;
                                controller.selectedcity = (generic.id == null)
                                    ? null
                                    : controller.selectedcity;
                              }
                              setState(() {});
                            }
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
                          if (_formKey.currentState!.validate()
                              //&&
                              // controller.file != null &&
                              //controller.pmcfile != null &&
                              // controller.ontap == true &&
                              // controller.phone.text == ''
                              // &&
                              // controller.selectedcity?.id != null &&
                              // controller.selectedprovince?.id != null &&
                              // controller.selectedcountry?.id != null &&
                              // controller.selectedpersonalTitle?.id != null &&
                              // controller.selectedgender?.id != null &&
                              // controller.selectedmaritalStatus?.id != null
                              ) {
                            Fluttertoast.showToast(
                                msg: 'saveRecord'.tr,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: ColorManager.KgreenColor,
                                textColor: ColorManager.kWhiteColor,
                                fontSize: 14.0);

                            controller.setPageIndexofDayPersonal(1);
                          } else {}
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
