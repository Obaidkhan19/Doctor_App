import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/doted_line.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/components/searchable_dropdown.dart';
import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/auth_repo.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/cities_model.dart';
import 'package:doctormobileapplication/models/countries_model.dart';
import 'package:doctormobileapplication/models/provinces_model.dart';
import 'package:doctormobileapplication/models/relation.dart';
import 'package:doctormobileapplication/screens/profile/personal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactDetail extends StatefulWidget {
  const ContactDetail({super.key});

  @override
  State<ContactDetail> createState() => _ContactDetailState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _ContactDetailState extends State<ContactDetail> {
  _getDoctorBasicInfo() async {
    ProfileRepo pr = ProfileRepo();
    await pr.getDoctorBasicInfo();
  }

  var edit = Get.put<EditProfileController>(EditProfileController());

  _getCountries() async {
    ProfileRepo pr = ProfileRepo();

    EditProfileController.i.updatecountriesList(
      await pr.getCountries(),
    );
  }

  _getProvinces(cid) async {
    ProfileRepo pr = ProfileRepo();
    cid ??= EditProfileController.i.selectedcountry?.id;
    EditProfileController.i.updateprovinceList(
      await pr.getProvinces(cid),
    );
  }

  _getCities(cid) async {
    ProfileRepo pr = ProfileRepo();
    cid ??= EditProfileController.i.selectedcity?.id;
    EditProfileController.i.updatecitiesList(
      await pr.getCities(cid),
    );
  }

  _getNOKRelation() async {
    AuthRepo ar = AuthRepo();
    EditProfileController.i.updatenokrelationList(
      await ar.getNOKRelation(),
    );
  }

  updateboolval() {
    ProfileController.i.updateval(true);
  }

  @override
  void initState() {
    // TODO: implement initState

    _getCountries();
    _getProvinces(EditProfileController.i.selectedcountry?.id);
    _getCities(EditProfileController.i.selectedcity?.id);
    _getDoctorBasicInfo();
    _getNOKRelation();
    Future.delayed(Duration.zero, () async {
      ProfileController.i.updateselectedindex(1);
    });
    super.initState();
  }

  var profile = Get.put<ProfileController>(ProfileController());
  @override
  Widget build(BuildContext context) {
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
                          Center(
                            child: Text(
                              'contactInformation'.tr,
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
                            validator: (value) {
                              if (value == "Country") {
                                return 'pleaseselectyourcountry'.tr;
                              }
                              return null;
                            },
                            onTap: () async {
                              edit.selectedcountry = null;
                              edit.selectedcity = null;
                              edit.citiesList.clear();
                              edit.selectedprovince = null;

                              Countries generic = await searchabledropdown(
                                  context, edit.countriesList ?? []);
                              edit.selectedcountry = null;
                              edit.updateselectedCountry(generic);

                              if (generic != '') {
                                edit.selectedcountry = generic;
                                edit.selectedcountry = (generic == '')
                                    ? null
                                    : edit.selectedcountry;
                              }
                              String cid =
                                  edit.selectedcountry?.id.toString() ?? "";
                              setState(() {
                                _getProvinces(cid);
                              });
                            },
                            readonly: true,
                            hintText: edit.selectedcountry?.name == ""
                                ? 'country'.tr
                                : edit.selectedcountry?.name ??
                                    "Select country",
                          ),
                          EditProfileCustomTextField(
                            validator: (value) {
                              if (value == "Province") {
                                return 'Please select your State'.tr;
                              }
                              return null;
                            },
                            readonly: true,
                            onTap: () async {
                              edit.selectedprovince = null;
                              edit.selectedcity = null;
                              Provinces generic = await searchabledropdown(
                                  context, edit.provinceList ?? []);
                              edit.selectedprovince = null;
                              edit.updateselectedprovince(generic);

                              if (generic != '') {
                                edit.selectedprovince = generic;
                                edit.selectedprovince = (generic == '')
                                    ? null
                                    : edit.selectedprovince;
                              }
                              String cid =
                                  edit.selectedprovince?.id.toString() ?? "";
                              setState(() {
                                _getCities(cid);
                              });
                            },
                            hintText: edit.selectedprovince?.name == ""
                                ? 'State'
                                : edit.selectedprovince?.name == null
                                    ? 'State'
                                    : edit.selectedprovince?.name ?? "",
                          ),
                          EditProfileCustomTextField(
                            validator: (value) {
                              if (value == "City") {
                                return 'pleaseselectyourcity'.tr;
                              }
                              return null;
                            },
                            readonly: true,
                            onTap: () async {
                              edit.selectedcity = null;
                              Cities generic = await searchabledropdown(
                                  context, edit.citiesList ?? []);
                              edit.selectedcity = null;
                              edit.updateselectedcity(generic);

                              if (generic != '') {
                                edit.selectedcity = generic;
                                edit.selectedcity =
                                    (generic == '') ? null : edit.selectedcity;
                              }
                              setState(() {});
                            },
                            hintText: edit.selectedcity?.name == ""
                                ? 'City'
                                : edit.selectedcity?.name == null
                                    ? 'City'
                                    : edit.selectedcity?.name ?? "",
                          ),
                          EditProfileCustomTextField(
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'pleaseselectyouraddress'.tr;
                              }
                              return null;
                            },
                            controller: edit.addressController,
                            hintText: 'address'.tr,
                          ),

                          EditProfileCustomTextField(
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return ''.tr;
                              }
                              return null;
                            },
                            controller: edit.publicmobileno,
                            hintText: 'Public Phone Number'.tr,
                          ),
                          // CustomIntlPhoneField(
                          //   onChanged: (phone) {
                          //     edit.updatepublicno(phone.completeNumber);
                          //   },
                          //   style: GoogleFonts.poppins(
                          //       color: ColorManager.kWhiteColor, fontSize: 12),
                          //   showDropdownIcon: false,
                          //   dropdownIcon: const Icon(
                          //     Icons.arrow_drop_down,
                          //     color: Colors.white,
                          //     size: 10,
                          //   ),
                          //   dropdownTextStyle: GoogleFonts.poppins(
                          //       fontSize: 12,
                          //       color: ColorManager.kWhiteColor,
                          //       fontWeight: FontWeight.w700),
                          //   showCountryFlag: false,
                          //   initialCountryCode: 'AE',
                          //   controller: edit.publicmobileno,
                          //   disableLengthCheck: true,
                          //   keyboardType: TextInputType.phone,
                          //   fieldfilled: true,
                          //   fieldsColor: Colors.white.withOpacity(0.1),
                          //   fieldsborderColor: Colors.white.withOpacity(0.1),
                          //   decoration: InputDecoration(
                          //       disabledBorder: OutlineInputBorder(
                          //           borderRadius: BorderRadius.circular(10),
                          //           borderSide: BorderSide(
                          //             color: Colors.white.withOpacity(0.1),
                          //           )),
                          //       enabledBorder: OutlineInputBorder(
                          //           borderRadius: BorderRadius.circular(10),
                          //           borderSide: BorderSide(
                          //             color: Colors.white.withOpacity(0.1),
                          //           )),
                          //       border: InputBorder.none),
                          //   languageCode: "en",
                          // ),

                          EditProfileCustomTextField(
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return ''.tr;
                              }
                              return null;
                            },
                            controller: edit.privatemobileno,
                            hintText: 'Private Phone Number'.tr,
                          ),
                          // CustomIntlPhoneField(
                          //   onChanged: (phone) {
                          //     edit.updateprivateno(phone.completeNumber);
                          //   },
                          //   style: GoogleFonts.poppins(
                          //       color: ColorManager.kPrimaryColor,
                          //       fontSize: 12),
                          //   showDropdownIcon: true,
                          //   dropdownIcon: const Icon(
                          //     Icons.arrow_drop_down,
                          //     color: Colors.white,
                          //     size: 10,
                          //   ),
                          //   dropdownTextStyle: GoogleFonts.poppins(
                          //       fontSize: 12,
                          //       color: ColorManager.kPrimaryColor,
                          //       fontWeight: FontWeight.w700),
                          //   showCountryFlag: false,
                          //   initialCountryCode: 'AE',
                          //   controller: edit.privatemobileno,
                          //   disableLengthCheck: true,
                          //   keyboardType: TextInputType.phone,
                          //   fieldfilled: true,
                          //   fieldsColor: ColorManager.kPrimaryLightColor,
                          //   fieldsborderColor: ColorManager.kWhiteColor,
                          //   decoration: InputDecoration(
                          //       disabledBorder: OutlineInputBorder(
                          //           borderRadius: BorderRadius.circular(10),
                          //           borderSide: const BorderSide(
                          //               color: ColorManager.kPrimaryColor)),
                          //       enabledBorder: OutlineInputBorder(
                          //           borderRadius: BorderRadius.circular(10),
                          //           borderSide: const BorderSide(
                          //               color: ColorManager.kPrimaryColor)),
                          //       border: InputBorder.none),
                          //   languageCode: "en",
                          // ),

                          EditProfileCustomTextField(
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return ''.tr;
                              }
                              return null;
                            },
                            controller: edit.telephone,
                            hintText: 'Telephone Number'.tr,
                          ),
                          // CustomIntlPhoneField(
                          //   onChanged: (phone) {
                          //     edit.updatetelephonenumber(phone.completeNumber);
                          //   },
                          //   style: GoogleFonts.poppins(
                          //       color: ColorManager.kPrimaryColor,
                          //       fontSize: 12),
                          //   showDropdownIcon: true,
                          //   dropdownIcon: const Icon(
                          //     Icons.arrow_drop_down,
                          //     color: Colors.white,
                          //     size: 10,
                          //   ),
                          //   dropdownTextStyle: GoogleFonts.poppins(
                          //       fontSize: 12,
                          //       color: ColorManager.kPrimaryColor,
                          //       fontWeight: FontWeight.w700),
                          //   showCountryFlag: false,
                          //   initialCountryCode: 'AE',
                          //   controller: edit.telephone,
                          //   disableLengthCheck: true,
                          //   keyboardType: TextInputType.phone,
                          //   fieldfilled: true,
                          //   fieldsColor: ColorManager.kPrimaryLightColor,
                          //   fieldsborderColor: ColorManager.kWhiteColor,
                          //   decoration: InputDecoration(
                          //       disabledBorder: OutlineInputBorder(
                          //           borderRadius: BorderRadius.circular(10),
                          //           borderSide: const BorderSide(
                          //               color: ColorManager.kPrimaryColor)),
                          //       enabledBorder: OutlineInputBorder(
                          //           borderRadius: BorderRadius.circular(10),
                          //           borderSide: const BorderSide(
                          //               color: ColorManager.kPrimaryColor)),
                          //       border: InputBorder.none),
                          //   languageCode: "en",
                          // ),

                          EditProfileCustomTextField(
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Enter Email';
                              }
                              return null;
                            },
                            controller: edit.emailController,
                            hintText: 'email'.tr,
                          ),
                          Center(
                            child: Text(
                              'nextofKin'.tr,
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
                            onTap: () async {
                              edit.selectednokrelation = null;
                              RelationData generic = await searchabledropdown(
                                  context, edit.nokrelationList ?? []);
                              edit.selectednokrelation = null;
                              edit.updateselectednokrelation(generic);

                              if (generic != '') {
                                edit.selectednokrelation = generic;
                                edit.selectednokrelation = (generic == '')
                                    ? null
                                    : edit.selectednokrelation;
                              }
                            },
                            readonly: true,
                            hintText: edit.selectednokrelation?.name == ""
                                ? 'NOK Relation'
                                : edit.selectednokrelation?.name.toString(),
                          ),
                          EditProfileCustomTextField(
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Enter NOK First Name';
                              }
                              return null;
                            },
                            controller: edit.nokfirstname,
                            hintText: 'firstname'.tr,
                          ),
                          EditProfileCustomTextField(
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Enter NOK Last Name';
                              }
                              return null;
                            },
                            controller: edit.noklastname,
                            hintText: 'lastname'.tr,
                          ),
                          EditProfileCustomTextField(
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Enter NOK ID NO';
                              }
                              return null;
                            },
                            controller: edit.nokidno,
                            hintText: 'idnumber'.tr,
                          ),
                          // CustomIntlPhoneField(
                          //   onChanged: (phone) {
                          //     edit.updatenoknumber(phone.completeNumber);
                          //   },
                          //   style: GoogleFonts.poppins(
                          //       color: ColorManager.kPrimaryColor,
                          //       fontSize: 12),
                          //   showDropdownIcon: true,
                          //   dropdownIcon: const Icon(
                          //     Icons.arrow_drop_down,
                          //     color: Colors.white,
                          //     size: 10,
                          //   ),
                          //   dropdownTextStyle: GoogleFonts.poppins(
                          //       fontSize: 12,
                          //       color: ColorManager.kPrimaryColor,
                          //       fontWeight: FontWeight.w700),
                          //   showCountryFlag: false,
                          //   initialCountryCode: 'AE',
                          //   controller: edit.nokmobileno,
                          //   disableLengthCheck: true,
                          //   keyboardType: TextInputType.phone,
                          //   fieldfilled: true,
                          //   fieldsColor: ColorManager.kPrimaryLightColor,
                          //   fieldsborderColor: ColorManager.kWhiteColor,
                          //   decoration: InputDecoration(
                          //       disabledBorder: OutlineInputBorder(
                          //           borderRadius: BorderRadius.circular(10),
                          //           borderSide: const BorderSide(
                          //               color: ColorManager.kPrimaryColor)),
                          //       enabledBorder: OutlineInputBorder(
                          //           borderRadius: BorderRadius.circular(10),
                          //           borderSide: const BorderSide(
                          //               color: ColorManager.kPrimaryColor)),
                          //       border: InputBorder.none),
                          //   languageCode: "en",
                          // ),
                          EditProfileCustomTextField(
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Enter NOK Mobile NO';
                              }
                              return null;
                            },
                            controller: edit.nokmobileno,
                            hintText: 'NOK Mobile Number'.tr,
                          ),
                          SizedBox(height: Get.height * 0.02),
                          PrimaryButton(
                              fontSize: 15,
                              title: 'update'.tr,
                              onPressed: () async {
                                ProfileRepo pr = ProfileRepo();
                                String res = await pr.updateContact(
                                    edit.selectedcountry?.id,
                                    edit.selectedprovince?.id,
                                    edit.selectedcity?.id,
                                    edit.addressController.text,
                                    edit.privatemobileno.text,
                                    edit.telephone.text,
                                    edit.publicmobileno.text,
                                    edit.nokfirstname.text,
                                    edit.noklastname.text,
                                    edit.selectednokrelation?.id,
                                    edit.nokidno.text,
                                    edit.nokmobileno.text,
                                    edit.emailController.text);
                                if (res == "true") {
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
              padding: EdgeInsets.only(top: Get.height * 0.04),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'contactInformation'.tr,
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
                    ProfileRecordWidget(
                      title: "country".tr,
                      name: profile.selectedbasicInfo?.countryName == ""
                          ? "-"
                          : profile.selectedbasicInfo?.countryName == null
                              ? "-"
                              : profile.selectedbasicInfo?.countryName ?? "-",
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    ProfileRecordWidget(
                      title: "state".tr,
                      name: profile.selectedbasicInfo?.stateName == ""
                          ? "-"
                          : profile.selectedbasicInfo?.stateName == null
                              ? "-"
                              : profile.selectedbasicInfo?.stateName ?? "-",
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    ProfileRecordWidget(
                      title: "city".tr,
                      name: profile.selectedbasicInfo?.cityName == ""
                          ? "-"
                          : profile.selectedbasicInfo?.cityName == null
                              ? "-"
                              : profile.selectedbasicInfo?.cityName ?? "-",
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    ProfileRecordWidget(
                      title: "address".tr,
                      name: profile.selectedbasicInfo?.address == ""
                          ? "-"
                          : profile.selectedbasicInfo?.address == null
                              ? "-"
                              : profile.selectedbasicInfo?.address ?? "-",
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    ProfileRecordWidget(
                      title: "mobileNumber(Private)".tr,
                      name: profile.selectedbasicInfo?.cellNumber == ""
                          ? "-"
                          : profile.selectedbasicInfo?.cellNumber == null
                              ? "-"
                              : profile.selectedbasicInfo?.cellNumber ?? "-",
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    ProfileRecordWidget(
                      title: "mobileNumber(Public)".tr,
                      name: profile.selectedbasicInfo?.contactPublic == ""
                          ? "-"
                          : profile.selectedbasicInfo?.contactPublic == null
                              ? "-"
                              : profile.selectedbasicInfo?.contactPublic ?? "-",
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    ProfileRecordWidget(
                      title: "telephoneNumber".tr,
                      name: profile.selectedbasicInfo?.telephoneNumber == ""
                          ? "-"
                          : profile.selectedbasicInfo?.telephoneNumber == null
                              ? "-"
                              : profile.selectedbasicInfo?.telephoneNumber ??
                                  "-",
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    ProfileRecordWidget(
                      title: "email".tr,
                      name: profile.selectedbasicInfo?.email == ""
                          ? "-"
                          : profile.selectedbasicInfo?.email == null
                              ? "-"
                              : profile.selectedbasicInfo?.email ?? "-",
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Center(
                      child: Text(
                        'nextofKin'.tr,
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
                    ProfileRecordWidget(
                      title: "NOKName".tr,
                      name: profile.selectedbasicInfo?.nOKFirstName == ""
                          ? "-"
                          : profile.selectedbasicInfo?.nOKFirstName == null
                              ? "-"
                              : profile.selectedbasicInfo?.nOKFirstName ?? "-",
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    ProfileRecordWidget(
                      title: "NOKIDNumber".tr,
                      name: profile.selectedbasicInfo?.nOKCNICNumber == ""
                          ? "-"
                          : profile.selectedbasicInfo?.nOKCNICNumber == null
                              ? "-"
                              : profile.selectedbasicInfo?.nOKCNICNumber ?? "-",
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    ProfileRecordWidget(
                      title: "NOKRelation".tr,
                      name: profile.selectedbasicInfo?.nOKRelationName == ""
                          ? "-"
                          : profile.selectedbasicInfo?.nOKRelationName == null
                              ? "-"
                              : profile.selectedbasicInfo?.nOKRelationName ??
                                  "-",
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    ProfileRecordWidget(
                      title: "NOKMobileNumber".tr,
                      name: profile.selectedbasicInfo?.nOKCellNumber == ""
                          ? "-"
                          : profile.selectedbasicInfo?.nOKCellNumber == null
                              ? "-"
                              : profile.selectedbasicInfo?.nOKCellNumber ?? "-",
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
