import 'package:doctormobileapplication/components/dropdown_data_widget.dart';
import 'package:doctormobileapplication/data/controller/appointment_history.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/appointment_configuration/dropdown.dart';
import 'package:doctormobileapplication/screens/appointment_configuration/dropdown_alert.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  String Status = "";
  final dateFormat = DateFormat('yyyy-MM-dd');
  DateTime dateTime = DateTime.now().subtract(const Duration(days: 30));
  DateTime dateTime2 = DateTime.now();

  bool isLoadingData = false;

  //  final AppointmentHistoryController controller = Get.put(AppointmentHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              AppImages.back,
            ),
          ),
          title: Text(
            'appointmentshistory'.tr,
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              height: 1.175,
              color: ColorManager.kblackColor,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(
                  right: Get.width * 0.07, top: Get.height * 0.01),
              child: InkWell(
                onTap: () async {
                  _showAlertDialog(context);
                },
                child: SizedBox(
                  height: Get.height * 0.08,
                  width: Get.width * 0.08,
                  child: Image.asset(
                    AppImages.filter_logo,
                    color: ColorManager.kPrimaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.background_image),
                alignment: Alignment.centerLeft),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: Get.width * 0.04,
              right: Get.width * 0.04,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 2,
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorManager.kWhiteColor,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: CupertinoColors.white,
                          ),
                          // color: ColorManager.kWhiteColor,
                          width: MediaQuery.of(context).size.width / 3.7,
                          child: CupertinoTextField(
                            readOnly: true,
                            controller: TextEditingController(
                              text: dateFormat.format(dateTime),
                            ),
                            prefix: Padding(
                              padding: EdgeInsets.only(left: Get.width * 0.02),
                              child: const Icon(
                                Icons.calendar_month,
                                color: CupertinoColors.black,
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 10,
                              color: CupertinoColors.black,
                            ),
                            onTap: () {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (BuildContext context) => Center(
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    child: CupertinoDatePicker(
                                      backgroundColor: Colors.white,
                                      initialDateTime: dateTime,
                                      onDateTimeChanged: (DateTime newTime) {
                                        setState(() => dateTime = newTime);
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
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorManager.kWhiteColor,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: CupertinoColors.white,
                          ),
                          // color: ColorManager.kWhiteColor,
                          width: MediaQuery.of(context).size.width / 3.7,
                          child: CupertinoTextField(
                            readOnly: true,
                            controller: TextEditingController(
                              text: dateFormat.format(dateTime2),
                            ),
                            prefix: Padding(
                              padding: EdgeInsets.only(left: Get.width * 0.02),
                              child: const Icon(
                                Icons.calendar_month,
                                color: CupertinoColors.black,
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 10,
                              color: CupertinoColors.black,
                            ),
                            onTap: () {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (BuildContext context) => Center(
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    child: CupertinoDatePicker(
                                      backgroundColor: Colors.white,
                                      initialDateTime: dateTime2,
                                      onDateTimeChanged: (DateTime newTime) {
                                        setState(() => dateTime2 = newTime);
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
                    GestureDetector(
                      onTap: () async {},
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Image.asset(
                          AppImages.search_image,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 7,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            top: Get.height * 0.01,
                          ),
                          child: Card(
                              color: ColorManager.kPrimaryColor,
                              elevation: 0,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                              child: ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Date",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: ColorManager.kWhiteColor,
                                          ),
                                        ),
                                        Text(
                                          "${'mrno'.tr}${123123}",
                                          style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            color: ColorManager.kWhiteColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Muhammad Obaid",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          color: ColorManager.kWhiteColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${'visitno'.tr} ${123}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: ColorManager.kWhiteColor,
                                      ),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        text: 'address|'.tr,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: ColorManager.kWhiteColor,
                                            fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(
                                              text: "Range road",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 10,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              ColorManager.kWhiteColor,
                                          fixedSize: const Size(380, 4),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                15), // Set the border radius here
                                          ),
                                        ),
                                        child: Text(
                                          'erx'.tr,
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  ColorManager.kPrimaryColor),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        );
                      }),
                ),
              ],
            ),
          ),
        ));
  }

  void _showAlertDialog(BuildContext context) {
    final dateFormatalert = DateFormat('yyyy-MM-dd');
    DateTime dateTimealert = DateTime.now().subtract(const Duration(days: 30));
    DateTime dateTime2alert = DateTime.now();

    final AppointmentHistoryController controller =
        Get.put(AppointmentHistoryController());

    // Create a simple alert dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05),
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
                        SizedBox(
                          width: Get.width * 0.10,
                        ),
                        Text(
                          "appointmentshistory".tr,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.kPrimaryColor,
                          ),
                        ),
                        // SizedBox(
                        //   width: Get.width * 0.13,
                        // ),
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
                                  text: dateFormatalert.format(dateTimealert),
                                ),
                                prefix: Padding(
                                  padding:
                                      EdgeInsets.only(left: Get.width * 0.03),
                                  child: const Icon(
                                    Icons.calendar_month,
                                    color: CupertinoColors.black,
                                  ),
                                ),
                                style: const TextStyle(
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
                                          initialDateTime: dateTimealert,
                                          onDateTimeChanged:
                                              (DateTime newTime) {
                                            setState(
                                                () => dateTimealert = newTime);
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
                                text: dateFormatalert.format(dateTime2alert),
                              ),
                              prefix: Padding(
                                padding:
                                    EdgeInsets.only(left: Get.width * 0.03),
                                child: const Icon(
                                  Icons
                                      .calendar_month, // You can replace this with your desired icon
                                  color: CupertinoColors.black,
                                ),
                              ),
                              style: const TextStyle(
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
                                        initialDateTime: dateTime2alert,
                                        onDateTimeChanged: (DateTime newTime) {
                                          setState(
                                              () => dateTime2alert = newTime);
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
                              'online'.tr,
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
                                    // setState(() {
                                    //   isOnline1 = value;
                                    // });
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
                      height: Get.height * 0.01,
                    ),
                    CustomAlertDropDownWidget(
                      list: controller.branchList,
                      selected: controller.barnchselectedoption,
                      hinttext: 'selectbranch'.tr,
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    CustomAlertDropDownWidget(
                      list: controller.hospitalList,
                      selected: controller.hospitalselectedoption,
                      hinttext: 'selecthospitalclinic'.tr,
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.kPrimaryColor,
                        fixedSize: const Size(380, 4),
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
        );
      },
    );
  }
}
