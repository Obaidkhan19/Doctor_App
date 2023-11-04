import 'package:doctormobileapplication/components/code_picker.dart';
import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/doted_line.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/components/searchable_dropdown.dart';
import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/auth_repo.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/cities_model.dart';
import 'package:doctormobileapplication/models/countries_model.dart';
import 'package:doctormobileapplication/models/provinces_model.dart';
import 'package:doctormobileapplication/models/relation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EditContact extends StatefulWidget {
  const EditContact({super.key});

  @override
  State<EditContact> createState() => _EditContactState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _EditContactState extends State<EditContact> {
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

  _getDoctorBasicInfo() async {
    ProfileRepo pr = ProfileRepo();
    await pr.getDoctorBasicInfo();
  }

  @override
  void initState() {
    // TODO: implement initState
    _getCountries();
    _getProvinces(EditProfileController.i.selectedcountry?.id);
    _getCities(EditProfileController.i.selectedcity?.id);
    _getDoctorBasicInfo();
    _getNOKRelation();
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
          'Edit Contact',
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
                  Center(
                    child: Text(
                      'Contact Information',
                      style: GoogleFonts.poppins(
                        textStyle: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.kPrimaryColor),
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
                      color: ColorManager.kPrimaryColor,
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
                        edit.selectedcountry =
                            (generic == '') ? null : edit.selectedcountry;
                      }
                      String cid = edit.selectedcountry?.id.toString() ?? "";
                      setState(() {
                        _getProvinces(cid);
                      });
                    },
                    readonly: true,
                    hintText: edit.selectedcountry?.name == ""
                        ? 'country'.tr
                        : edit.selectedcountry?.name ?? "Select country",
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
                        edit.selectedprovince =
                            (generic == '') ? null : edit.selectedprovince;
                      }
                      String cid = edit.selectedprovince?.id.toString() ?? "";
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
                  CustomIntlPhoneField(
                    onChanged: (phone) {
                      edit.updatepublicno(phone.completeNumber);
                    },
                    style: GoogleFonts.poppins(
                        color: ColorManager.kPrimaryColor, fontSize: 12),
                    showDropdownIcon: true,
                    dropdownIcon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                      size: 10,
                    ),
                    dropdownTextStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        color: ColorManager.kPrimaryColor,
                        fontWeight: FontWeight.w700),
                    showCountryFlag: false,
                    initialCountryCode: 'AE',
                    controller: edit.publicmobileno,
                    disableLengthCheck: true,
                    keyboardType: TextInputType.phone,
                    fieldfilled: true,
                    fieldsColor: ColorManager.kPrimaryLightColor,
                    fieldsborderColor: ColorManager.kWhiteColor,
                    decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: ColorManager.kPrimaryColor)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: ColorManager.kPrimaryColor)),
                        border: InputBorder.none),
                    languageCode: "en",
                  ),
                  SizedBox(height: Get.height * 0.02),
                  CustomIntlPhoneField(
                    onChanged: (phone) {
                      edit.updateprivateno(phone.completeNumber);
                    },
                    style: GoogleFonts.poppins(
                        color: ColorManager.kPrimaryColor, fontSize: 12),
                    showDropdownIcon: true,
                    dropdownIcon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                      size: 10,
                    ),
                    dropdownTextStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        color: ColorManager.kPrimaryColor,
                        fontWeight: FontWeight.w700),
                    showCountryFlag: false,
                    initialCountryCode: 'AE',
                    controller: edit.privatemobileno,
                    disableLengthCheck: true,
                    keyboardType: TextInputType.phone,
                    fieldfilled: true,
                    fieldsColor: ColorManager.kPrimaryLightColor,
                    fieldsborderColor: ColorManager.kWhiteColor,
                    decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: ColorManager.kPrimaryColor)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: ColorManager.kPrimaryColor)),
                        border: InputBorder.none),
                    languageCode: "en",
                  ),
                  SizedBox(height: Get.height * 0.02),
                  CustomIntlPhoneField(
                    onChanged: (phone) {
                      edit.updatetelephonenumber(phone.completeNumber);
                    },
                    style: GoogleFonts.poppins(
                        color: ColorManager.kPrimaryColor, fontSize: 12),
                    showDropdownIcon: true,
                    dropdownIcon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                      size: 10,
                    ),
                    dropdownTextStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        color: ColorManager.kPrimaryColor,
                        fontWeight: FontWeight.w700),
                    showCountryFlag: false,
                    initialCountryCode: 'AE',
                    controller: edit.telephone,
                    disableLengthCheck: true,
                    keyboardType: TextInputType.phone,
                    fieldfilled: true,
                    fieldsColor: ColorManager.kPrimaryLightColor,
                    fieldsborderColor: ColorManager.kWhiteColor,
                    decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: ColorManager.kPrimaryColor)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: ColorManager.kPrimaryColor)),
                        border: InputBorder.none),
                    languageCode: "en",
                  ),
                  SizedBox(height: Get.height * 0.02),
                  EditProfileCustomTextField(
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return 'Enter Email';
                      }
                      return null;
                    },
                    controller: edit.emailController,
                    hintText: 'Email',
                  ),
                  Center(
                    child: Text(
                      'Next of Kin',
                      style: GoogleFonts.poppins(
                        textStyle: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.kPrimaryColor),
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
                      color: ColorManager.kPrimaryColor,
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
                        edit.selectednokrelation =
                            (generic == '') ? null : edit.selectednokrelation;
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
                    hintText: 'First Name',
                  ),
                  EditProfileCustomTextField(
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return 'Enter NOK Last Name';
                      }
                      return null;
                    },
                    controller: edit.noklastname,
                    hintText: 'Last Name',
                  ),
                  EditProfileCustomTextField(
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return 'Enter NOK ID NO';
                      }
                      return null;
                    },
                    controller: edit.nokidno,
                    hintText: 'ID Number',
                  ),
                  CustomIntlPhoneField(
                    onChanged: (phone) {
                      edit.updatenoknumber(phone.completeNumber);
                    },
                    style: GoogleFonts.poppins(
                        color: ColorManager.kPrimaryColor, fontSize: 12),
                    showDropdownIcon: true,
                    dropdownIcon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                      size: 10,
                    ),
                    dropdownTextStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        color: ColorManager.kPrimaryColor,
                        fontWeight: FontWeight.w700),
                    showCountryFlag: false,
                    initialCountryCode: 'AE',
                    controller: edit.nokmobileno,
                    disableLengthCheck: true,
                    keyboardType: TextInputType.phone,
                    fieldfilled: true,
                    fieldsColor: ColorManager.kPrimaryLightColor,
                    fieldsborderColor: ColorManager.kWhiteColor,
                    decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: ColorManager.kPrimaryColor)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: ColorManager.kPrimaryColor)),
                        border: InputBorder.none),
                    languageCode: "en",
                  ),
                  SizedBox(height: Get.height * 0.03),
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
                            edit.privatenumber,
                            edit.telephonenumber,
                            edit.publicnumber,
                            edit.nokfirstname.text,
                            edit.noklastname.text,
                            edit.selectednokrelation?.id,
                            edit.nokidno.text,
                            edit.nokmobilenumber,
                            edit.emailController.text);
                        if (res == "true") {
                          Get.back(result: true);
                        }
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
