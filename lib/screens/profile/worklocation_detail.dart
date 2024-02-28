import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:doctormobileapplication/components/image_container.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/data/controller/add_worklocation_controller.dart';
import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/repositories/ConfigureAppointment_repo/configure_appointment_repo.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/components/searchable_dropdown.dart';
import 'package:doctormobileapplication/data/repositories/Consulting_Queue_repo/consultingQueue_repo.dart';
import 'package:doctormobileapplication/models/cities_model.dart';
import 'package:doctormobileapplication/models/countries_model.dart';
import 'package:doctormobileapplication/models/hospital_clinic.dart';
import 'package:doctormobileapplication/models/provinces_model.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkLocation extends StatefulWidget {
  const WorkLocation({super.key});

  @override
  State<WorkLocation> createState() => _WorkLocationState();
}

class _WorkLocationState extends State<WorkLocation> {
  get boolisMobile => null;

  _getDoctorBasicInfo() async {
    ProfileRepo pr = ProfileRepo();
    await pr.getDoctorBasicInfo();
  }

  _getHospital() async {
    ConsultingQueueRepo cqr = ConsultingQueueRepo();
    EditProfileController.i.updatehospitallist(
      await cqr.getHospitalORClinic(),
    );
  }

  _getCountries() async {
    ProfileRepo pr = ProfileRepo();
    EditProfileController.i.updateworklocationcountriesList(
      await pr.getCountries(),
    );
  }

  _getProvinces(cid) async {
    ProfileRepo pr = ProfileRepo();
    //   cid ??= EditProfileController.i.selectedcountry?.id;
    EditProfileController.i.updateworklocationstateList(
      await pr.getProvinces(cid),
    );
  }

  _getCities(cid) async {
    ProfileRepo pr = ProfileRepo();
    // cid ??= EditProfileController.i.selectedcity?.id;
    EditProfileController.i.updateworklocationcitiesList(
      await pr.getCities(cid),
    );
  }

  _getaddHospital() async {
    ConsultingQueueRepo cqr = ConsultingQueueRepo();
    AddWorklocationController.i.updateaddworklocationhospitallist(
      await cqr.getHospitalORClinic(),
    );
  }

  _getaddCountries() async {
    ProfileRepo pr = ProfileRepo();
    AddWorklocationController.i.updateaddworklocationcountriesList(
      await pr.getCountries(),
    );
  }

  _getaddProvinces(cid) async {
    ProfileRepo pr = ProfileRepo();
    AddWorklocationController.i.updateaddworklocationstateList(
      await pr.getProvinces(cid),
    );
  }

  _getaddCities(cid) async {
    ProfileRepo pr = ProfileRepo();
    AddWorklocationController.i.updateaddworklocationcitiesList(
      await pr.getCities(cid),
    );
  }

  // top worklocations
  _getWorklocation() async {
    ConfigureAppointmentRepo car = ConfigureAppointmentRepo();
    ProfileController.i.updatedisplayprofileWorkLocationslist(
      await car.getWorklocation(),
    );
  }

  @override
  void initState() {
    _getWorklocation();
    _getaddHospital();
    _getHospital();
    _getaddCountries();
    _getCountries();
    _getDoctorBasicInfo();
    Future.delayed(Duration.zero, () async {
      ProfileController.i.updateselectedindex(9);
    });
    super.initState();
  }

  var profile = Get.put<ProfileController>(ProfileController());
  var worklocation = Get.put<ProfileController>(ProfileController());
  var add = Get.put<AddWorklocationController>(AddWorklocationController());
  var edit = Get.put<EditProfileController>(EditProfileController());

  final GlobalKey<FormState> _addformKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (contt) => BlurryModalProgressHUD(
        inAsyncCall: profile.isLoading,
        blurEffectIntensity: 4,
        progressIndicator: const SpinKitSpinningLines(
          color: ColorManager.kPrimaryColor,
          size: 60,
        ),
        child: GetBuilder<ProfileController>(
            builder: (contr) => contr.editval
                ? GetBuilder<EditProfileController>(
                    builder: (contr) => Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                EditProfileCustomTextField(
                                  onTap: () async {
                                    edit.selectedhospital = null;
                                    HospitalORClinics generic =
                                        await searchabledropdown(
                                            context, edit.hospitalList);
                                    edit.selectedhospital = null;
                                    edit.updateselectedhospital(generic);

                                    if (generic.id != null) {
                                      edit.selectedhospital = generic;
                                      edit.selectedhospital =
                                          (generic.id == null)
                                              ? null
                                              : edit.selectedhospital;
                                    }
                                    setState(() {});
                                  },
                                  readonly: true,
                                  hintText: edit.selectedhospital?.name == ""
                                      ? 'Hospital'.tr
                                      : edit.selectedhospital?.name ??
                                          "SelectHospital".tr,
                                ),
                                EditProfileCustomTextField(
                                  controller: edit.worklocationpreference,
                                  hintText: 'Preference'.tr,
                                ),
                                SizedBox(height: Get.height * 0.03),
                                PrimaryButton(
                                    fontSize: 15,
                                    title: 'edit'.tr,
                                    onPressed: () async {
                                      ProfileController.i.updateval(false);
                                      setState(() {});
                                    },
                                    color: Colors.white.withOpacity(0.7),
                                    textcolor: ColorManager.kWhiteColor),
                                SizedBox(height: Get.height * 0.03),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : contr.addval
                    ? GetBuilder<AddWorklocationController>(
                        builder: (contr) => Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.05),
                          child: SizedBox(
                            height: Get.height * 1,
                            child: SingleChildScrollView(
                              child: Form(
                                key: _addformKey,
                                child: Column(
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        Checkbox(
                                          side: MaterialStateBorderSide
                                              .resolveWith(
                                            (Set<MaterialState> states) {
                                              if (states.contains(
                                                  MaterialState.selected)) {
                                                return const BorderSide(
                                                    color: Colors.white);
                                              }
                                              return const BorderSide(
                                                  color: Colors.white);
                                            },
                                          ),
                                          value: add.newworklocationisChecked,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              add.newworklocationisChecked =
                                                  value!;
                                            });
                                          },
                                          checkColor: ColorManager.kWhiteColor,
                                          activeColor:
                                              ColorManager.kPrimaryColor,
                                        ),
                                        Text(
                                          'AddNewWorkLocation'.tr,
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: ColorManager.kWhiteColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Visibility(
                                      visible:
                                          add.newworklocationisChecked == false,
                                      child: EditProfileCustomTextField(
                                        validator: (p0) {
                                          if (add.addworklocationselectedhospital
                                                  ?.id ==
                                              null) {
                                            return 'SelectHospital'.tr;
                                          } else {
                                            return null;
                                          }
                                        },
                                        onTap: () async {
                                          add.addworklocationselectedhospital =
                                              null;
                                          HospitalORClinics generic =
                                              await searchabledropdown(context,
                                                  add.addworklocationhospitalList);
                                          add.addworklocationselectedhospital =
                                              null;
                                          add.updateaddworklocationselectedhospital(
                                              generic);

                                          if (generic.id != null) {
                                            add.addworklocationselectedhospital =
                                                generic;
                                            add.addworklocationselectedhospital =
                                                (generic.id == null)
                                                    ? null
                                                    : add
                                                        .addworklocationselectedhospital;
                                          }
                                          setState(() {});
                                        },
                                        readonly: true,
                                        hintText: add
                                                    .addworklocationselectedhospital
                                                    ?.name ==
                                                ""
                                            ? 'Hospital'.tr
                                            : add.addworklocationselectedhospital
                                                    ?.name ??
                                                "SelectHospital".tr,
                                      ),
                                    ),
                                    Visibility(
                                      visible:
                                          add.newworklocationisChecked == false,
                                      child: EditProfileCustomTextField(
                                        validator: (p0) {
                                          if (p0!.isEmpty) {
                                            return 'EnterPreference'.tr;
                                          }
                                          return null;
                                        },
                                        controller: add.worklocationpreference,
                                        hintText: 'Preference'.tr,
                                      ),
                                    ),
                                    Visibility(
                                      visible:
                                          add.newworklocationisChecked == true,
                                      child: EditProfileCustomTextField(
                                        validator: (p0) {
                                          if (p0!.isEmpty) {
                                            return 'EnterName'.tr;
                                          }
                                          return null;
                                        },
                                        controller: add.newworklocationname,
                                        hintText: 'name'.tr,
                                      ),
                                    ),
                                    Visibility(
                                      visible:
                                          add.newworklocationisChecked == true,
                                      child: EditProfileCustomTextField(
                                        validator: (value) {
                                          if (add.addselectedworklocationcountry
                                                  ?.id ==
                                              null) {
                                            return 'pleaseselectyourcountry'.tr;
                                          }
                                          return null;
                                        },
                                        onTap: () async {
                                          add.addselectedworklocationcountry =
                                              null;
                                          add.addselectedworklocationCities =
                                              null;
                                          add.addworklocationcitiesList.clear();
                                          add.addselectedworklocationstate =
                                              null;
                                          Countries generic =
                                              await searchabledropdown(context,
                                                  add.addworklocationcountriesList);
                                          add.addselectedworklocationcountry =
                                              null;
                                          add.updateaddselectedworklocationcountry(
                                              generic);

                                          if (generic.id != null) {
                                            add.addselectedworklocationcountry =
                                                generic;
                                            add.addselectedworklocationcountry =
                                                (generic.id == null)
                                                    ? null
                                                    : add
                                                        .addselectedworklocationcountry;
                                          }
                                          String cid =
                                              add.addselectedworklocationcountry
                                                      ?.id
                                                      .toString() ??
                                                  "";
                                          setState(() {
                                            _getaddProvinces(cid);
                                          });
                                        },
                                        readonly: true,
                                        hintText: add
                                                    .addselectedworklocationcountry
                                                    ?.name ==
                                                ""
                                            ? 'country'.tr
                                            : add.addselectedworklocationcountry
                                                    ?.name ??
                                                "Selectcountry".tr,
                                      ),
                                    ),
                                    Visibility(
                                      visible:
                                          add.newworklocationisChecked == true,
                                      child: EditProfileCustomTextField(
                                        validator: (value) {
                                          if (add.addselectedworklocationstate
                                                  ?.id ==
                                              null) {
                                            return 'pleaseselectyourprovince'
                                                .tr;
                                          }
                                          return null;
                                        },
                                        readonly: true,
                                        onTap: () async {
                                          if (add.addselectedworklocationcountry !=
                                              null) {
                                            add.addselectedworklocationstate =
                                                null;
                                            add.addselectedworklocationCities =
                                                null;
                                            Provinces generic =
                                                await searchabledropdown(
                                                    context,
                                                    add.addworklocationstateList);
                                            add.addselectedworklocationstate =
                                                null;
                                            add.updateaddselectedworklocationstate(
                                                generic);

                                            if (generic.id != null) {
                                              add.addselectedworklocationstate =
                                                  generic;
                                              add.addselectedworklocationstate =
                                                  (generic.id == null)
                                                      ? null
                                                      : add
                                                          .addselectedworklocationstate;
                                            }
                                            String cid =
                                                add.addselectedworklocationstate
                                                        ?.id
                                                        .toString() ??
                                                    "";
                                            setState(() {
                                              _getaddCities(cid);
                                            });
                                          }
                                        },
                                        hintText: add
                                                    .addselectedworklocationstate
                                                    ?.name ==
                                                ""
                                            ? 'state'.tr
                                            : add.addselectedworklocationstate
                                                        ?.name ==
                                                    null
                                                ? 'state'.tr
                                                : add.addselectedworklocationstate
                                                        ?.name ??
                                                    "",
                                      ),
                                    ),
                                    Visibility(
                                      visible:
                                          add.newworklocationisChecked == true,
                                      child: EditProfileCustomTextField(
                                        validator: (value) {
                                          if (add.addselectedworklocationCities
                                                  ?.id ==
                                              null) {
                                            return 'pleaseselectyourcity'.tr;
                                          }
                                          return null;
                                        },
                                        readonly: true,
                                        onTap: () async {
                                          if (add.addselectedworklocationcountry !=
                                                  null &&
                                              add.addselectedworklocationstate !=
                                                  null) {
                                            add.addselectedworklocationCities =
                                                null;
                                            Cities generic =
                                                await searchabledropdown(
                                                    context,
                                                    add.addworklocationcitiesList);
                                            add.addselectedworklocationCities =
                                                null;
                                            add.updateaddselectedworklocationCities(
                                                generic);

                                            if (generic.id != null) {
                                              add.addselectedworklocationCities =
                                                  generic;
                                              add.addselectedworklocationCities =
                                                  (generic.id == null)
                                                      ? null
                                                      : add
                                                          .addselectedworklocationCities;
                                            }
                                            setState(() {});
                                          }
                                        },
                                        hintText: add
                                                    .addselectedworklocationCities
                                                    ?.name ==
                                                ""
                                            ? 'city'.tr
                                            : add.addselectedworklocationCities
                                                        ?.name ==
                                                    null
                                                ? 'city'.tr
                                                : add.addselectedworklocationCities
                                                        ?.name ??
                                                    "",
                                      ),
                                    ),
                                    Visibility(
                                      visible:
                                          add.newworklocationisChecked == true,
                                      child: EditProfileCustomTextField(
                                        validator: (p0) {
                                          if (p0!.isEmpty) {
                                            return 'pleaseselectyouraddress'.tr;
                                          }
                                          return null;
                                        },
                                        controller:
                                            add.newworklocationnameaddress,
                                        hintText: 'address'.tr,
                                      ),
                                    ),
                                    SizedBox(height: Get.height * 0.03),
                                    InkWell(
                                      onTap: () async {
                                        ProfileRepo pr = ProfileRepo();

                                        add.updateisloading(true);
                                        if (_addformKey.currentState!
                                            .validate()) {
                                          if (add.newworklocationisChecked !=
                                              true) {
                                            String res =
                                                await pr.addOldWorklocation(
                                                    add.addworklocationselectedhospital
                                                        ?.id,
                                                    add.worklocationpreference
                                                        .text);

                                            if (res == "true") {
                                              _getDoctorBasicInfo();
                                              ProfileController.i
                                                  .updateaddval(false);
                                              setState(() {});

                                              add.updateisloading(false);
                                            }
                                            add.updateisloading(false);
                                          } else {
                                            String res = await pr.addNewWorklocation(
                                                add.newworklocationname.text,
                                                add.newworklocationnameaddress
                                                    .text,
                                                add.addselectedworklocationcountry
                                                    ?.id,
                                                add.addselectedworklocationstate
                                                    ?.id,
                                                add.addselectedworklocationCities
                                                    ?.id);

                                            if (res == "true") {
                                              _getDoctorBasicInfo();
                                              ProfileController.i
                                                  .updateaddval(false);
                                              setState(() {});

                                              add.updateisloading(false);
                                            }
                                            add.updateisloading(false);
                                          }
                                        }
                                        add.updateisloading(false);
                                      },
                                      child: Container(
                                        height: Get.height * 0.07,
                                        width: Get.width * 1,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.7),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                            child: add.isloading == false
                                                ? Text(
                                                    'add'.tr,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: ColorManager
                                                            .kWhiteColor),
                                                  )
                                                : const CircularProgressIndicator(
                                                    color: ColorManager
                                                        .kWhiteColor,
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
                    : GetBuilder<ProfileController>(
                        builder: (contr) => Container(
                          height: Get.height * 1,
                          color: ColorManager.kPrimaryColor,
                          padding: EdgeInsets.only(
                            top: Get.height * 0.02,
                            left: Get.width * 0.02,
                            right: Get.width * 0.02,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: Get.width * 0.04),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ImageContainer(
                                        onpressed: () {
                                          ProfileController.i
                                              .updateaddval(true);
                                          ProfileController.i
                                              .updateisEdit(true);
                                          setState(() {});
                                        },
                                        imagePath: Images.add,
                                        isSvg: false,
                                        color: ColorManager.kPrimaryColor,
                                        backgroundColor:
                                            ColorManager.kWhiteColor,
                                        boxheight: Get.height * 0.04,
                                        boxwidth: boolisMobile!
                                            ? Get.width * 0.08
                                            : Get.width * 0.04,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                contr.displayprofileworkLocationsList.isNotEmpty
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: Get.width * 0.65,
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  child: SizedBox(
                                                    height: Get.height * 0.04,
                                                    width: Get.width * 0.17,
                                                    child: Image.asset(
                                                      Images.edit,
                                                      color: ColorManager
                                                          .kPrimaryColor,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  'hospitalclinic'.tr,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: ColorManager
                                                        .kWhiteColor,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.2,
                                            child: Text(
                                              'preference'.tr,
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: ColorManager.kWhiteColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : const SizedBox.shrink(),
                                contr.displayprofileworkLocationsList.isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: contr
                                            .displayprofileworkLocationsList
                                            .length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: Get.height * 0.01,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: Get.width * 0.65,
                                                    child: Row(
                                                      // mainAxisAlignment:
                                                      //     MainAxisAlignment
                                                      //         .spaceBetween,
                                                      children: [
                                                        ImageContainerNew(
                                                          onpressed: () {},
                                                          imagePath:
                                                              AppImages.cross,
                                                          //  imageheight: Get.height * 0.03,
                                                          isSvg: false,
                                                          color: ColorManager
                                                              .kRedColor,
                                                          backgroundColor:
                                                              ColorManager
                                                                  .kWhiteColor,
                                                          boxheight:
                                                              Get.height * 0.03,
                                                          boxwidth:
                                                              Get.width * 0.06,
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.015,
                                                        ),
                                                        ImageContainerNew(
                                                          onpressed: () {
                                                            // send object
                                                            EditProfileController
                                                                    .i
                                                                    .editSelectedworklocation =
                                                                null;
                                                            EditProfileController
                                                                .i
                                                                .updateEditSelectedworklocation(
                                                                    worklocation
                                                                            .displayprofileworkLocationsList[
                                                                        index]);
                                                            ProfileController.i
                                                                .updateval(
                                                                    true);
                                                            ProfileController.i
                                                                .updateisEdit(
                                                                    true);
                                                            setState(() {});
                                                          },
                                                          imagePath:
                                                              AppImages.editbig,
                                                          isSvg: false,
                                                          color: ColorManager
                                                              .kPrimaryColor,
                                                          backgroundColor:
                                                              ColorManager
                                                                  .kWhiteColor,
                                                          // imageheight: Get.height * 0.02,
                                                          boxheight:
                                                              Get.height * 0.03,
                                                          boxwidth:
                                                              Get.width * 0.06,
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.03,
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.4,
                                                          child: Text(
                                                            contr
                                                                    .displayprofileworkLocationsList[
                                                                        index]
                                                                    .workLocationName ??
                                                                "",
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 11,
                                                              color: ColorManager
                                                                  .kWhiteColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: Get.width * 0.2,
                                                    child: Text(
                                                      contr
                                                          .displayprofileworkLocationsList[
                                                              index]
                                                          .preference
                                                          .toString(),
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 11,
                                                        color: ColorManager
                                                            .kWhiteColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        },
                                      )
                                    : Center(
                                        child: Text(
                                          "NoRecordFound".tr,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      )),
      ),
    );
  }

  deleteWorklocation(
    BuildContext context,
    String worklocationid,
  ) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: Get.width * 0.05),
                      Text(
                        'delete'.tr,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          textStyle: GoogleFonts.poppins(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.close_outlined,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Text(
                    'doyouwanttodeleteit'.tr,
                    style: GoogleFonts.poppins(
                      textStyle: GoogleFonts.poppins(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  PrimaryButton(
                    title: 'yes'.tr,
                    fontSize: 14,
                    height: Get.height * 0.06,
                    width: Get.width * 0.5,
                    onPressed: () async {
                      ProfileRepo pr = ProfileRepo();

                      String res = await pr.deleteBank(worklocationid);

                      if (res == "true") {
                        _getDoctorBasicInfo();

                        setState(() {});
                      }

                      // Call API
                      Get.back();
                    },
                    color: ColorManager.kPrimaryColor,
                    textcolor: ColorManager.kWhiteColor,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
