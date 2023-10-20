import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/components/searchable_dropdown.dart';
import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/helpers/values_manager.dart';
import 'package:doctormobileapplication/models/cities_model.dart';
import 'package:doctormobileapplication/models/countries_model.dart';
import 'package:doctormobileapplication/models/provinces_model.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfile extends StatefulWidget {
  final String? imagepath;
  final String? fullName;
  final String? dob;
  final String? cellNumber;
  final String? email;
  String? country;
  String? province;
  String? city;
  final String? address;
  String? countryid;
  String? provinceid;
  String? cityid;

  EditProfile(
      {this.dob,
      this.imagepath,
      this.cellNumber,
      this.city,
      this.email,
      this.country,
      this.province,
      this.address,
      this.fullName,
      this.cityid,
      this.countryid,
      this.provinceid,
      super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  _getCountries() async {
    ProfileRepo pr = ProfileRepo();
    EditProfileController.i.updatecountriesList(
      await pr.getCountries(),
    );
  }

  _getProvinces(cid) async {
    ProfileRepo pr = ProfileRepo();
    EditProfileController.i.updateprovinceList(
      await pr.getProvinces(cid),
    );
  }

  _getCities(cid) async {
    ProfileRepo pr = ProfileRepo();
    EditProfileController.i.updatecitiesList(
      await pr.getCities(cid),
    );
  }

  late TextEditingController nameController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController addressController = TextEditingController();
  late TextEditingController numberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    nameController.text = widget.fullName ?? "";
    emailController.text = widget.email ?? "";
    numberController.text = widget.cellNumber ?? "";
    addressController.text = widget.address ?? "";
    EditProfileController.i.cityid = widget.cityid ?? "";
    EditProfileController.i.countryid = widget.countryid ?? "";
    EditProfileController.i.provinceid = widget.cityid ?? "";
    EditProfileController.i.city = widget.city ?? "";
    EditProfileController.i.country = widget.country ?? "";
    EditProfileController.i.province = widget.province ?? "";
    EditProfileController.i.dob = widget.dob ?? "";

    if (widget.dob != null) {
      List<String> dobParts = widget.dob!.split('T');
      if (dobParts.isNotEmpty) {
        List<String> dateParts = dobParts[0].split('-');
        if (dateParts.length == 3) {
          String year = dateParts[0];
          String month = dateParts[1];
          String day = dateParts[2];
          EditProfileController.i.formatearrival!.value = '$month-$day-$year';
        }
      }
    }
    Countries c = Countries();
    c.id = widget.countryid;
    c.name = widget.country;
    EditProfileController.i.selectedcountry = c;

    Provinces p = Provinces();
    p.id = widget.provinceid;
    p.name = widget.province;
    EditProfileController.i.selectedprovince = p;

    Cities ci = Cities();
    ci.id = widget.cityid;
    ci.name = widget.city;

    EditProfileController.i.selectedcity = ci;
    _getCountries();
    _getProvinces(widget.countryid);
    _getCities(widget.provinceid);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    EditProfileController.i.disposefile();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var edit = Get.put<EditProfileController>(EditProfileController());
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Get.back();
          },
          child: Image.asset(
            AppImages.back,
            color: ColorManager.kPrimaryColor,
          ),
        ),
        title: Text(
          'editProfile'.tr,
          style: GoogleFonts.poppins(fontSize: 19, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<EditProfileController>(
        builder: (contr) => Padding(
          padding: const EdgeInsets.only(
              top: AppPadding.p20, left: AppPadding.p20, right: AppPadding.p20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GetBuilder<ProfileController>(
                    builder: (cont) {
                      return InkWell(
                        onTap: () {
                          edit.pickImage();
                        },

                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: edit.file != null
                                ? DecorationImage(
                                    image: FileImage(File(edit.file!.path)),
                                    fit: BoxFit.cover,
                                  )
                                : cont.selectedbasicInfo!.picturePath!=null
                                    ? DecorationImage(
                                        image:NetworkImage(AppConstants.baseURL+cont.selectedbasicInfo!.picturePath) ,
                                        fit: BoxFit.cover,
                                      )
                                    : DecorationImage(
                                        image: AssetImage(AppImages.doctorlogo),
                                        fit: BoxFit.cover,
                                      ),
                          ),
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.green,
                                child: IconButton(
                                    onPressed: () {
                                      edit.pickImage();
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt_outlined,
                                      size: 15,
                                    )),
                              )),
                        ),
                      );
                    }
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  EditProfileCustomTextField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'pleaseenteryourname'.tr;
                      }
                      return null;
                    },
                    hintText: 'fullName'.tr,
                    controller: nameController,
                  ),
                  EditProfileCustomTextField(
                    onTap: () {
                      EditProfileController.i.selectDateAndTime(context,
                          EditProfileController.arrival, edit.formatearrival);
                    },
                    readonly: true,
                    hintText: EditProfileController.i.formatearrival.toString(),
                  ),
                  EditProfileNumberCustomTextField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'pleaseenteryourmobilenumber'.tr;
                      }
                      return null;
                    },
                    hintText: 'mobilenumber'.tr,
                    controller: numberController,
                  ),
                  EditProfileCustomTextField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'pleaseenteryouremail'.tr;
                      }
                      return null;
                    },
                    controller: emailController,
                  ),
                  EditProfileCustomTextField(
                    onTap: () async {
                      edit.selectedcountry = null;
                      edit.selectedcity = null;
                      edit.citiesList.clear();
                      edit.selectedprovince = null;
                      //  edit.provinceList.clear();
                      widget.province = 'province'.tr;
                      widget.city = 'city'.tr;

                      Countries generic = await searchabledropdown(
                          context, edit.countriesList ?? []);
                      edit.selectedcountry = null;
                      edit.updateselectedCountry(generic);

                      if (generic != '') {
                        edit.selectedcountry = generic;
                        edit.selectedcountry =
                            (generic == '') ? null : edit.selectedcountry;
                      }
                      String cid = EditProfileController.i.selectedcountry!.id
                          .toString();
                      setState(() {
                        _getProvinces(cid);
                      });
                    },
                    validator: (value) {
                      if (value == "country".tr) {
                        return 'pleaseselectyourcountry'.tr;
                      }
                      return null;
                    },
                    readonly: true,

                    hintText: EditProfileController.i.selectedcountry == null
                        ? "country".tr
                        : EditProfileController.i.selectedcountry?.name ?? "",
                    // "${(EditProfileController.i.selectedcountry != null && EditProfileController.i.selectedcountry!.name != null) ? (EditProfileController.i.selectedcountry!.name!.length > 10 ? ('${EditProfileController.i.selectedcountry?.name!.substring(0, 10)}...') : EditProfileController.i.selectedcountry?.name) : widget.country ?? "country"}",
                  ),
                  EditProfileCustomTextField(
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
                      String cid = EditProfileController.i.selectedprovince!.id
                          .toString();
                      setState(() {
                        _getCities(cid);
                      });
                    },
                    validator: (value) {
                      if (value == "province".tr) {
                        return 'pleaseselectyourprovince';
                      }
                      return null;
                    },
                    readonly: true,

                    hintText: EditProfileController.i.selectedprovince == null
                        ? "province".tr
                        : EditProfileController.i.selectedprovince?.name ?? "",
                    //  "${(EditProfileController.i.selectedprovince != null && EditProfileController.i.selectedprovince!.name != null) ? (EditProfileController.i.selectedprovince!.name!.length > 10 ? ('${EditProfileController.i.selectedprovince?.name!.substring(0, 10)}...') : EditProfileController.i.selectedprovince?.name) : widget.province ?? "Province"}",
                  ),
                  EditProfileCustomTextField(
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
                    validator: (value) {
                      if (value == "city") {
                        return 'pleaseselectyourcity'.tr;
                      }
                      return null;
                    },
                    readonly: true,
                    hintText: EditProfileController.i.selectedcity == null
                        ? "city".tr
                        : EditProfileController.i.selectedcity?.name ?? "",
                    //  "${(EditProfileController.i.selectedcity != null && EditProfileController.i.selectedcity!.name != null) ? (EditProfileController.i.selectedcity!.name!.length > 10 ? ('${EditProfileController.i.selectedcity?.name!.substring(0, 10)}...') : EditProfileController.i.selectedcity?.name) : widget.city ?? "City"}",
                  ),
                  EditProfileCustomTextField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'pleaseselectyouraddress'.tr;
                      }
                      return null;
                    },
                    //hintText: 'Address',
                    controller: addressController,
                  ),
                  SizedBox(height: Get.height * 0.05),
                  PrimaryButton(
                      fontSize: 15,
                      title: 'update'.tr,
                      onPressed: () async {
                        String? doctorid = await LocalDb().getDoctorId();
                        String? token = await LocalDb().getToken();
                        ProfileRepo rp = ProfileRepo();
                        if (_formKey.currentState!.validate() &&
                            (edit.selectedcity?.name != "null" &&
                                edit.selectedprovince?.name != "null")) {
                          String chk = await rp.updateaccount(
                            doctorid,
                            nameController.text,
                            edit.formatearrival.toString(),
                            numberController.text,
                            emailController.text,
                            EditProfileController.i.selectedcountry!.id,
                            EditProfileController.i.selectedprovince!.id,
                            EditProfileController.i.selectedcity!.id,
                            addressController.text,
                            token,
                          );
                          // if (chk == "true") {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(
                          //       content: Text('successfullyupdate'.tr),
                          //       duration: const Duration(seconds: 3),
                          //     ),
                          //   );
                          //   Get.back(result: true);
                          // } else {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(
                          //       content: Text('failedtoupdate'.tr),
                          //       duration: const Duration(seconds: 3),
                          //     ),
                          //   );
                          // }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Failed to update'),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                      color: ColorManager.kPrimaryColor,
                      textcolor: ColorManager.kWhiteColor),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
