import 'package:doctormobileapplication/components/searchable_dropdown.dart';
import 'package:doctormobileapplication/data/controller/configure_appointment_controller.dart';
import 'package:doctormobileapplication/data/repositories/Consulting_Queue_repo/consultingQueue_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/hospital_clinic.dart';

import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interval_time_picker/interval_time_picker.dart';

class ConfigureAppointmentScreen extends StatefulWidget {
  const ConfigureAppointmentScreen({super.key});

  @override
  State<ConfigureAppointmentScreen> createState() =>
      _ConfigureAppointmentScreenState();
}

class _ConfigureAppointmentScreenState
    extends State<ConfigureAppointmentScreen> {
  var contr =
      Get.put<ConfigureAppointmentController>(ConfigureAppointmentController());
  TimeOfDay _time = const TimeOfDay(hour: 00, minute: 00);
  final int _interval = 5;
  final VisibleStep _visibleStep = VisibleStep.fifths;
  void _selectTime() async {
    final TimeOfDay? newTime = await showIntervalTimePicker(
      context: context,
      initialTime: _time,
      interval: _interval,
      visibleStep: _visibleStep,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  late BuildContext _context;

  _getHospital() async {
    ConsultingQueueRepo cqr = ConsultingQueueRepo();
    contr.updatehospitallist(
      await cqr.getHospitalORClinic(),
    );
  }

  @override
  void initState() {
    super.initState();
    _context = context;
    _getHospital();
    ConfigureAppointmentController.i.initialrows(_context);
  }

  @override
  void dispose() {
    super.dispose();
    ConfigureAppointmentController.i.clearrows();
    contr.disposefunction();
    ConfigureAppointmentController.i.falseSwitch();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConfigureAppointmentController>(
      builder: (cont) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: ColorManager.kPrimaryColor,
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            //  InkWell(
            //   splashColor: Colors.transparent,
            //   highlightColor: Colors.transparent,
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            //   child: Image.asset(
            //     AppImages.back,
            //     color: ColorManager.kPrimaryColor,
            //     fit: BoxFit.fill,
            //     height: Get.height * 0.02,
            //     width: Get.width * 0.002,
            //   ),
            // ),
            title: Text(
              'configureappointmentappbar'.tr,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                height: 1.175,
                color: ColorManager.kPrimaryColor,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImages.background_image),
                      alignment: Alignment.centerLeft),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "setyouravailabilitytostartattendingpatients".tr,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: ColorManager.kPrimaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Card(
                      elevation: 1,
                      color: ColorManager.kPrimaryLightColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "hospitalclinic".tr,
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: ColorManager.kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              InkWell(
                                onTap: () async {
                                  contr.selectedhospital = null;
                                  HospitalORClinics generic =
                                      await searchabledropdown(
                                          context, contr.hospitalList ?? []);
                                  contr.selectedhospital = null;
                                  contr.updatehospital(generic);

                                  if (generic != '') {
                                    contr.selectedhospital = generic;
                                    contr.selectedhospital = (generic == '')
                                        ? null
                                        : contr.selectedhospital;
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                  width: Get.width * 1,
                                  height: Get.height * 0.06,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: ColorManager.kPrimaryColor,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.03,
                                        vertical: Get.height * 0.01),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${(contr.selectedhospital != null && contr.selectedhospital?.name != null) ? (contr.selectedhospital!.name!.length > 50 ? ('${contr.selectedhospital?.name!.substring(0, 50 > contr.selectedhospital!.name!.length ? contr.selectedhospital!.name!.length : 50)}...') : contr.selectedhospital?.name) : "Select Hospital/Clinic"}",
                                          semanticsLabel:
                                              "${(contr.selectedhospital != null) ? (contr.selectedhospital!.name!.length > 50 ? ('${contr.selectedhospital?.name!.substring(0, 50 > contr.selectedhospital!.name!.length ? contr.selectedhospital!.name!.length : 50)}...') : contr.selectedhospital) : "Select Hospital/Clinic"}",
                                          style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            color:
                                                contr.selectedhospital?.name !=
                                                        null
                                                    ? ColorManager.kblackColor
                                                    : Colors.grey[700],
                                          ),
                                        ),
                                        const Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 20,
                                          color: ColorManager.kblackColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Card(
                      elevation: 1,
                      surfaceTintColor: ColorManager.kWhiteColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "onlinevideoconsultation".tr,
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: ColorManager.kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Transform.scale(
                              scale: 0.55,
                              child: Switch(
                                value: contr.isOnline,
                                activeColor: ColorManager.kPrimaryColor,
                                onChanged: (value) {
                                  contr.updateoOnline(value);
                                },
                              ),
                            ),
                          ],
                        )),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Row(
                      children: [
                        Text(
                          "selectdays".tr,
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: ColorManager.kPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),

                    // ConfigureAppointmentListTile(
                    //      dayname: 'Monday', isOpen: false),
                    // ConfigureAppointmentListTile(
                    //     dayname: 'Tuesday', isOpen: false),
                    // ConfigureAppointmentListTile(
                    //     dayname: 'Wednesday', isOpen: false),
                    // ConfigureAppointmentListTile(
                    //     dayname: 'Thursday', isOpen: false),
                    // ConfigureAppointmentListTile(
                    //     dayname: 'Friday', isOpen: false),
                    // ConfigureAppointmentListTile(
                    //     dayname: 'Saturday', isOpen: false),
                    // ConfigureAppointmentListTile(
                    //     dayname: 'Sunday', isOpen: false),

                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 7,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Card(
                              elevation: 1,
                              surfaceTintColor: ColorManager.kWhiteColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: Get.width * 0.03),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      contr.getDayName(index),
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: ColorManager.kPrimaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Transform.scale(
                                      scale: 0.55,
                                      child: Switch(
                                        value: contr.switchStates[index],
                                        activeColor: ColorManager.kPrimaryColor,
                                        onChanged: (value) {
                                          contr.toggleSwitch(index);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: contr.switchStates[index],
                              child: Card(
                                elevation: 1,
                                color: ColorManager.kPrimaryLightColor,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: Get.height * 0.02,
                                    ),
                                    Text(
                                      "addhoursofyouravailability".tr,
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: ColorManager.kPrimaryColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    ...contr.dayRows[index],
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        contr.addRow(index, context);
                                      },
                                      child: Text(
                                        "addmorehours".tr,
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: ColorManager.kblackColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "feetimeSlot".tr,
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: ColorManager.kPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    Card(
                      elevation: 1,
                      color: ColorManager.kPrimaryLightColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, bottom: 10, top: 10),
                        child: Row(children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "consultancyfee".tr,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: ColorManager.kPrimaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Container(
                                    height: Get.height * 0.065,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: ColorManager.kPrimaryColor,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.03,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          height: 25,
                                          width: 40,
                                          child: Center(
                                            child: Text(
                                              "aed".tr,
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: ColorManager.kblackColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: Get.width * 0.02,
                                                right: Get.width * 0.02,
                                                bottom: Get.height * 0.015),
                                            child: TextField(
                                              keyboardType: const TextInputType
                                                  .numberWithOptions(
                                                  decimal: true),
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(
                                                        r'^\d*\.?\d{0,2}')),
                                              ],
                                              controller: contr
                                                  .consultancyfeeController,
                                              // keyboardType:
                                              //     TextInputType.number,

                                              decoration: const InputDecoration(
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Text(
                                    "followupfee".tr,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: ColorManager.kPrimaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Container(
                                    height: Get.height * 0.065,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: ColorManager.kPrimaryColor,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.03,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          height: 25,
                                          width: 40,
                                          child: Center(
                                            child: Text(
                                              "aed".tr,
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: ColorManager.kblackColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: Get.width * 0.02,
                                                right: Get.width * 0.02,
                                                bottom: Get.height * 0.015),
                                            child: TextField(
                                              controller:
                                                  contr.followupfeeController,
                                              keyboardType: const TextInputType
                                                  .numberWithOptions(
                                                  decimal: true),
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(
                                                        r'^\d*\.?\d{0,2}')),
                                              ],
                                              decoration: const InputDecoration(
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "slotduration".tr,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: ColorManager.kPrimaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _selectTime();
                                    },
                                    child: TextField(
                                      enabled: false,
                                      cursorColor: ColorManager.kPrimaryColor,
                                      controller: contr.followupfeeController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Icon(CupertinoIcons.clock),
                                              Text(
                                                "${_time.hour.toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(2, '0')}",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: ColorManager
                                                        .kblackColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                            color: ColorManager.kPrimaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Text(
                                    "followupdays".tr,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: ColorManager.kPrimaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Container(
                                    height: Get.height * 0.065,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: ColorManager.kPrimaryColor,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.06,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: Get.width * 0.02,
                                                right: Get.width * 0.02,
                                                bottom: Get.height * 0.015),
                                            child: TextField(
                                              maxLength: 4,
                                              controller:
                                                  contr.followupdayController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                counterText: "",
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Card(
                      elevation: 1,
                      color: ColorManager.kPrimaryLightColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: "nonpaidappointmentapproval".tr,
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: ColorManager.kPrimaryColor,
                                      fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                        text: "approvalcriteria".tr,
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: ColorManager.kblackColor,
                                            fontWeight: FontWeight.normal)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              InkWell(
                                onTap: () async {
                                  ApprovalCriteria generic =
                                      await searchabledropdown(context,
                                          contr.approvalCriteriaList ?? []);
                                  contr.updateApprovalCriteria(generic);

                                  if (generic != '') {
                                    contr.selectedApprovalCriteria = generic;
                                    contr.selectedApprovalCriteria =
                                        (generic == '')
                                            ? null
                                            : contr.selectedApprovalCriteria;
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                  width: Get.width * 1,
                                  height: Get.height * 0.06,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: ColorManager.kPrimaryColor,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.03,
                                        vertical: Get.height * 0.01),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${(contr.selectedApprovalCriteria != null && contr.selectedApprovalCriteria?.name != null) ? (contr.selectedApprovalCriteria!.name.length > 50 ? ('${contr.selectedApprovalCriteria?.name.substring(0, 50 > contr.selectedApprovalCriteria!.name.length ? contr.selectedApprovalCriteria!.name.length : 50)}...') : contr.selectedApprovalCriteria?.name) : "Select Hospital/Clinic"}",
                                          semanticsLabel:
                                              "${(contr.selectedApprovalCriteria != null) ? (contr.selectedApprovalCriteria!.name.length > 50 ? ('${contr.selectedApprovalCriteria?.name.substring(0, 50 > contr.selectedApprovalCriteria!.name.length ? contr.selectedApprovalCriteria!.name.length : 50)}...') : contr.selectedApprovalCriteria) : "Select Hospital/Clinic"}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              color: ColorManager.kblackColor),
                                        ),
                                        const Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 20,
                                          color: ColorManager.kblackColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
