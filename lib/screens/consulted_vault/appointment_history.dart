import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/searchable_dropdown.dart';
import 'package:doctormobileapplication/data/controller/ConsultingQueue_Controller.dart';
import 'package:doctormobileapplication/data/controller/appointment_history.dart';
import 'package:doctormobileapplication/data/repositories/Consulting_Queue_repo/consultingQueue_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/branch.dart';
import 'package:doctormobileapplication/models/hospital_clinic.dart';
import 'package:doctormobileapplication/screens/Consulting_Queue/pdfview.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AppointmentHistoryscreen extends StatefulWidget {
  static bool? switchvalue;
  const AppointmentHistoryscreen({super.key});

  @override
  State<AppointmentHistoryscreen> createState() =>
      _AppointmentHistoryscreenState();
}

class _AppointmentHistoryscreenState extends State<AppointmentHistoryscreen> {
  @override
  String status = "";
  final dateFormat = DateFormat('yyyy-MM-dd');
  DateTime dateTime = DateTime.now().subtract(const Duration(days: 30));
  DateTime dateTime2 = DateTime.now();

  String formatDatabaseTime(String databaseTime) {
    final parsedTime = DateTime.parse(databaseTime);
    final formattedDate = DateFormat('dd MMM y').format(parsedTime);
    final formattedTime = DateFormat('hh:mm a').format(parsedTime);

    return '$formattedDate | $formattedTime';
  }

  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  int length = 10;

  Future<void> callback() async {
    await ConsultingQueueController.i.updateIsloading(true);
    await ConsultingQueueController.i.getpastconsultation(length);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        var isCallToFetchData =
            ConsultingQueueController.i.SetStartToFetchNextData();
        if (isCallToFetchData) {
          length = length + 10;
          callback();
        }
      }
    });
    await ConsultingQueueController.i.updateIsloading(false);
  }

  _getBranch() async {
    ConsultingQueueRepo cqr = ConsultingQueueRepo();
    AppointmentHistoryController.i.updatebranchlist(
      await cqr.getBranch(),
    );
  }

  _getHospital() async {
    ConsultingQueueRepo cqr = ConsultingQueueRepo();
    AppointmentHistoryController.i.updatehospitallist(
      await cqr.getHospitalORClinic(),
    );
  }

  @override
  void initState() {
    callback();
    _getBranch();
    _getHospital();
    super.initState();
  }

  DateFormat format = DateFormat.yMMMMd();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConsultingQueueController>(builder: (cont) {
      return GetBuilder<AppointmentHistoryController>(
        builder: (contr) => Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: ColorManager.kPrimaryColor,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'pastconsultation'.tr,
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.kPrimaryColor,
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(
                      right: Get.width * 0.07, top: Get.height * 0.01),
                  child: InkWell(
                    onTap: () async {
                      await _showAlertDialog(context);
                    },
                    child: SizedBox(
                      height: Get.height * 0.08,
                      width: Get.width * 0.08,
                      child: Image.asset(
                        AppImages.filterlogo,
                        color: ColorManager.kPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: RefreshIndicator(
              onRefresh: callback,
              child: BlurryModalProgressHUD(
                inAsyncCall: ConsultingQueueController.i.isLoading,
                blurEffectIntensity: 4,
                progressIndicator: const SpinKitSpinningLines(
                  color: Color(0xfff1272d3),
                  size: 60,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppImages.backgroundimage),
                        alignment: Alignment.centerLeft),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.05,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ConsultingQueueController
                                  .i.pastconsultation.isNotEmpty
                              ? ListView.builder(
                                  controller: _scrollController,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: ConsultingQueueController
                                      .i.pastconsultation.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    String consultedtime =
                                        ConsultingQueueController
                                                .i
                                                .pastconsultation[index]
                                                .consultationDetails![0]
                                                .consultedTime ??
                                            "";
                                    String formatedate =
                                        formatDatabaseTime(consultedtime);
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        top: Get.height * 0.01,
                                      ),
                                      child: Card(
                                        color: ColorManager.kPrimaryColor,
                                        elevation: 4,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: Get.height * 0.02,
                                              bottom: Get.height * 0.02,
                                              left: Get.width * 0.04,
                                              right: Get.width * 0.04),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        Images.consuledlocation,
                                                        fit: BoxFit.fill,
                                                        height:
                                                            Get.height * 0.03,
                                                      ),
                                                      Text(
                                                        " | ",
                                                        style: GoogleFonts.poppins(
                                                            color: ColorManager
                                                                .kWhiteColor),
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * 0.3,
                                                        child: Text(
                                                          ConsultingQueueController
                                                                  .i
                                                                  .pastconsultation[
                                                                      index]
                                                                  .locationName ??
                                                              "",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 10,
                                                            color: ColorManager
                                                                .kWhiteColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          // Text(
                                                          //   DateFormat.yMMMM().format(
                                                          //           DateTime.parse(
                                                          //               "${ConsultingQueueController.i.pastconsultation[index].consultationDetails![0].consultedTime.toString().split('T')[0]} ${ConsultingQueueController.i.pastconsultation[index].consultationDetails![0].consultedTime.toString().split('T')[1]}")) ??
                                                          //       "",
                                                          //   style: GoogleFonts
                                                          //       .poppins(
                                                          //     fontSize: 10,
                                                          //     color: ColorManager
                                                          //         .kWhiteColor,
                                                          //   ),
                                                          // ),
                                                          // Text(
                                                          //   " | ${ConsultingQueueController.i.pastconsultation[index].consultationDetails![0].consultedTime.toString().split('T')[1].toString().split(':')[0]}:${ConsultingQueueController.i.pastconsultation[index].consultationDetails![0].consultedTime.toString().split('T')[1].toString().split(':')[1]}",
                                                          //   style: GoogleFonts
                                                          //       .poppins(
                                                          //     fontSize: 10,
                                                          //     color: ColorManager
                                                          //         .kWhiteColor,
                                                          //   ),
                                                          // )
                                                          Text(
                                                            // ConsultingQueueController
                                                            //         .i
                                                            //         .pastconsultation[
                                                            //             index]
                                                            //         .locationName ??
                                                            //     "",
                                                            formatedate,
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 10,
                                                              color: ColorManager
                                                                  .kWhiteColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.03,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        ConsultingQueueController
                                                                .i
                                                                .pastconsultation[
                                                                    index]
                                                                .patientName ??
                                                            "",
                                                        style: GoogleFonts.poppins(
                                                            fontSize: 12,
                                                            color: ColorManager
                                                                .kWhiteColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        "${'mrno'.tr}${ConsultingQueueController.i.pastconsultation[index].mRNo}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 11,
                                                          color: ColorManager
                                                              .kWhiteColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        'visitno'.tr,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 10,
                                                          color: ColorManager
                                                              .kWhiteColor,
                                                        ),
                                                      ),
                                                      Text(
                                                        ' ${ConsultingQueueController.i.pastconsultation[index].consultationDetails?[0].visitNo}',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 10,
                                                          color: ColorManager
                                                              .kWhiteColor,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.01,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Get.to(
                                                    () => pdfviewconsulted(
                                                      url: ConsultingQueueController
                                                              .i
                                                              .pastconsultation[
                                                                  index]
                                                              .consultationDetails?[
                                                                  0]
                                                              .uRL ??
                                                          "",
                                                      name: ConsultingQueueController
                                                              .i
                                                              .pastconsultation[
                                                                  index]
                                                              .patientName ??
                                                          "",
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  height: Get.height * 0.05,
                                                  width: Get.width * 1,
                                                  decoration: BoxDecoration(
                                                    color: ColorManager
                                                        .kWhiteColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'erx'.tr,
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: ColorManager
                                                              .kPrimaryColor),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                              : Center(
                                  child: Text(
                                    "No Record Found",
                                    style: GoogleFonts.poppins(fontSize: 16),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      );
    });
  }

  _showAlertDialog(BuildContext context) {
    final AppointmentHistoryController controller =
        Get.put(AppointmentHistoryController());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GetBuilder<AppointmentHistoryController>(
          builder: (cont) => Padding(
            padding: EdgeInsets.only(
                left: Get.width * 0.05, right: Get.width * 0.05),
            child: StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                surfaceTintColor: Colors.white,
                insetPadding: EdgeInsets.zero,
                content: GetBuilder<AppointmentHistoryController>(
                  builder: (cont) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                "searchconsultancy".tr,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: ColorManager.kPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: SizedBox(
                              height: Get.height * 0.05,
                              width: Get.width * 0.05,
                              child: Image.asset(AppImages.cross),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Row(
                        children: [
                          Card(
                            elevation: 2,
                            child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: ColorManager.kWhiteColor,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  color: CupertinoColors.white,
                                ),
                                // color: ColorManager.kWhiteColor,
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: CupertinoTextField(
                                  readOnly: true,
                                  controller: TextEditingController(
                                    text: controller.dateFormatalert
                                        .format(controller.dateTimealert),
                                  ),
                                  prefix: Padding(
                                    padding:
                                        EdgeInsets.only(left: Get.width * 0.02),
                                    child: const Icon(
                                      Icons.calendar_month,
                                      color: CupertinoColors.black,
                                    ),
                                  ),
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    color: CupertinoColors.black,
                                  ),
                                  onTap: () {
                                    showCupertinoModalPopup(
                                      context: context,
                                      builder: (BuildContext context) => Center(
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          child: CupertinoDatePicker(
                                            backgroundColor: Colors.white,
                                            initialDateTime:
                                                controller.dateTimealert,
                                            onDateTimeChanged:
                                                (DateTime newTime) {
                                              setState(() => controller
                                                  .dateTimealert = newTime);
                                            },
                                            use24hFormat: true,
                                            mode: CupertinoDatePickerMode.date,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )),
                          ),
                          Text(
                            'to'.tr,
                            style: GoogleFonts.poppins(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          Card(
                            elevation: 2,
                            child: Container(
                              //  color: ColorManager.kWhiteColor,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: ColorManager.kWhiteColor,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                color: CupertinoColors.white,
                              ),
                              width: MediaQuery.of(context).size.width / 3.5,
                              child: CupertinoTextField(
                                readOnly: true,
                                controller: TextEditingController(
                                  text: controller.dateFormatalert
                                      .format(controller.dateTime2alert),
                                ),
                                prefix: Padding(
                                  padding:
                                      EdgeInsets.only(left: Get.width * 0.02),
                                  child: const Icon(
                                    Icons
                                        .calendar_month, // You can replace this with your desired icon
                                    color: CupertinoColors.black,
                                  ),
                                ),
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: CupertinoColors.black,
                                ),
                                onTap: () {
                                  showCupertinoModalPopup(
                                    context: context,
                                    builder: (BuildContext context) => Center(
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        child: CupertinoDatePicker(
                                          backgroundColor: Colors.white,
                                          initialDateTime:
                                              controller.dateTime2alert,
                                          onDateTimeChanged:
                                              (DateTime newTime) {
                                            setState(() => controller
                                                .dateTime2alert = newTime);
                                          },
                                          use24hFormat: true,
                                          mode: CupertinoDatePickerMode.date,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.009,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Adjust this as needed
                            mainAxisSize:
                                MainAxisSize.min, // Adjust this as needed
                            children: [
                              Text(
                                controller.switchText,
                                style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    color: ColorManager.kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: Get.width * 0.1,
                                height: Get.height * 0.03,
                                child: Transform.scale(
                                  scale: 0.55,
                                  child: Switch(
                                    value: controller.isOnline,
                                    activeColor: ColorManager.kPrimaryColor,
                                    onChanged: (value) {
                                      controller.updateSwitch(value);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      InkWell(
                        onTap: () async {
                          controller.selectedbranch = null;
                          BranchData generic = await searchabledropdown(
                              context, controller.branchList ?? []);
                          controller.selectedbranch = null;
                          controller.updatebranch(generic);

                          if (generic != '') {
                            controller.selectedbranch = generic;
                            controller.selectedbranch = (generic == '')
                                ? null
                                : controller.selectedbranch;
                          }
                          setState(() {});
                        },
                        child: Container(
                          width: Get.width * 1,
                          height: Get.height * 0.05,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorManager.kPrimaryColor,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.03,
                                vertical: Get.height * 0.01),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${(controller.selectedbranch != null && controller.selectedbranch?.name != null) ? (controller.selectedbranch!.name!.length > 50 ? ('${controller.selectedbranch?.name!.substring(0, 50 > controller.selectedbranch!.name!.length ? controller.selectedbranch!.name!.length : 50)}...') : controller.selectedbranch?.name) : "selectBranch".tr}",
                                  semanticsLabel:
                                      "${(controller.selectedbranch != null) ? (controller.selectedbranch!.name!.length > 50 ? ('${controller.selectedbranch?.name!.substring(0, 50 > controller.selectedbranch!.name!.length ? controller.selectedbranch!.name!.length : 50)}...') : controller.selectedbranch) : "selectBranch".tr}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    color:
                                        controller.selectedbranch?.name != null
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
                        height: Get.height * 0.02,
                      ),
                      InkWell(
                        onTap: () async {
                          controller.selectedhospital = null;
                          HospitalORClinics generic = await searchabledropdown(
                              context, controller.hospitalList ?? []);
                          controller.selectedhospital = null;
                          controller.updatehospital(generic);

                          if (generic != '') {
                            controller.selectedhospital = generic;
                            controller.selectedhospital = (generic == '')
                                ? null
                                : controller.selectedhospital;
                          }
                          setState(() {});
                        },
                        child: Container(
                          width: Get.width * 1,
                          height: Get.height * 0.05,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorManager.kPrimaryColor,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.03,
                                vertical: Get.height * 0.01),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${(controller.selectedhospital != null && controller.selectedhospital?.name != null) ? (controller.selectedhospital!.name!.length > 50 ? ('${controller.selectedhospital?.name!.substring(0, 50 > controller.selectedhospital!.name!.length ? controller.selectedhospital!.name!.length : 50)}...') : controller.selectedhospital?.name) : "selectHospitalClinic".tr}",
                                  semanticsLabel:
                                      "${(controller.selectedhospital != null) ? (controller.selectedhospital!.name!.length > 50 ? ('${controller.selectedhospital?.name!.substring(0, 50 > controller.selectedhospital!.name!.length ? controller.selectedhospital!.name!.length : 50)}...') : controller.selectedhospital) : "selectHospitalClinic".tr}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    color: controller.selectedhospital?.name !=
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
                        height: Get.height * 0.02,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Get.back(result: "true");
                          await callback();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.kPrimaryColor,
                          fixedSize: Size(Get.width * 0.8, Get.height * 0.06),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Set the border radius here
                          ),
                        ),
                        child: Text(
                          'search'.tr,
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
