import 'dart:math';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:doctormobileapplication/components/custom_checkbox_dropdown.dart';
import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/doted_line.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/data/repositories/Consulting_Queue_repo/consultingQueue_repo.dart';
import 'package:doctormobileapplication/models/consultingqueuewaithold.dart';
import 'package:doctormobileapplication/models/cosultingqueuepatient.dart';
import 'package:doctormobileapplication/screens/Consulting_Queue/ConsultingQueue.dart';
import 'package:doctormobileapplication/screens/Consulting_Queue/Prescribe_Medicine.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/CustomFormField.dart';
import '../../components/images.dart';
import '../../data/controller/ConsultingQueue_Controller.dart';
import '../../helpers/color_manager.dart';
import '../../helpers/font_manager.dart';
import '../../helpers/values_manager.dart';
import '../../utils/AppImages.dart';
import 'History_eRX.dart';

class ClinicalPracticeQueueDataList extends StatefulWidget {
  String? Status;
  ClinicalPracticeQueueDataList({super.key, this.Status});

  @override
  State<ClinicalPracticeQueueDataList> createState() =>
      _ClinicalPracticeQueueDataListState();
}

class _ClinicalPracticeQueueDataListState
    extends State<ClinicalPracticeQueueDataList> {
  TextEditingController SearchFieldController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final GlobalKey<_ClinicalPracticeQueueDataListState>
      SearchFieldControllerKey = GlobalKey();
  @override
  void dispose() {
    _scrollController.dispose();
    ConsultingQueueController.i.clearAllLists(widget.Status.toString());
    super.dispose();
  }

  int length = 10;

  callback() async {
    ConsultingQueueRepo.GetConsultingQueuewaitinghold(consultingqueuepatients(
        branchId: await LocalDb().getBranchId(),
        doctorId: await LocalDb().getDoctorId(),
        search: SearchFieldController.text.isEmpty
            ? ""
            : SearchFieldController.text,
        workLocationId: "",
        status: "1",
        fromDate: DateTime.now().toString().split(' ')[0],
        toDate: DateTime.now().toString().split(' ')[0],
        isOnline: "false",
        token: "",
        start: "0",
        length: length.toString(),
        orderColumn: "0",
        orderDir: "desc"));

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
  }

  @override
  void initState() {
    callback();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var contr = Get.put<ConsultingQueueController>(ConsultingQueueController());
    return GetBuilder<ConsultingQueueController>(
      builder: (cont) => BlurryModalProgressHUD(
          inAsyncCall: ConsultingQueueController.i.isclinicLoading,
          blurEffectIntensity: 4,
          progressIndicator: const SpinKitSpinningLines(
            color: Color(0xfff1272d3),
            size: 60,
          ),
          dismissible: false,
          opacity: 0.4,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.helpful_background_logo),
                  alignment: Alignment.centerLeft,
                ),
              ),
              child: SafeArea(
                minimum: const EdgeInsets.all(AppPadding.p14)
                    .copyWith(top: 0, bottom: -10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextField(
                        onSubmitted: (String value) {
                          SearchFieldController.text = value;
                          callback();
                          //  setState(() {});
                        },
                        prefixIcon: const Icon(
                          Icons.search_outlined,
                          color: ColorManager.kPrimaryColor,
                          size: 35,
                        ),
                        controller: SearchFieldController,
                        hintText: 'Search',
                      ),
                      SizedBox(
                        height: Get.height * 0.68,
                        child: ConsultingQueueController
                                .i.consultingqueuewait.isNotEmpty
                            ? ListView.builder(
                                controller: _scrollController,
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: ConsultingQueueController
                                    .i.consultingqueuewait.length,
                                itemBuilder: (context, index) {
                                  final manageAppointment =
                                      ConsultingQueueController
                                              .i.consultingqueuewait.isNotEmpty
                                          ? ConsultingQueueController
                                              .i.consultingqueuewait[index]
                                          : null;
                                  // FILTER CODE
                                  // if (ConsultingQueueController.i.date
                                  //         .toString()
                                  //         .split(' ')[0] ==
                                  //     ConsultingQueueController
                                  //         .i
                                  //         .ClinicalPracticeDataList
                                  //         .queue?[index]
                                  //         .visitTime
                                  //         .toString()
                                  //         .split('T')[0])
                                  {
                                    return ((manageAppointment != null &&
                                            (manageAppointment
                                                    .patientStatusValue
                                                    .toString() ==
                                                widget.Status.toString()))
                                        ? Card(
                                            elevation: 4,
                                            surfaceTintColor:
                                                ColorManager.kWhiteColor,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: Get.height * 0.02,
                                                  bottom: Get.height * 0.02),
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    leading: SizedBox(
                                                      height: 380,
                                                      width: 71,
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            const Color
                                                                .fromRGBO(
                                                                0, 0, 0, 0),
                                                        radius: 30,
                                                        child: ClipOval(
                                                          child: manageAppointment
                                                                      .patientImagePath ==
                                                                  null
                                                              ? Image.asset(
                                                                  Images.avator)
                                                              : Image.network(AppConstants
                                                                      .baseURL +
                                                                  manageAppointment
                                                                      .patientImagePath),
                                                        ),
                                                      ),
                                                    ),
                                                    title: Transform.translate(
                                                      offset:
                                                          const Offset(-0, 0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            manageAppointment
                                                                    .patientName ??
                                                                "",
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 13,
                                                              color: ColorManager
                                                                  .kPrimaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            manageAppointment
                                                                    .mRNO ??
                                                                "",
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 10,
                                                              color: ColorManager
                                                                  .kPrimaryColor,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Visit No: ${manageAppointment.visitNo ?? ""}',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 10,
                                                              color: ColorManager
                                                                  .kblackColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    trailing: InkWell(
                                                      onTap: () {
                                                        Get.to(() =>
                                                            //  HistoryeRXConsultingQueue());

                                                            PrescribeMedicineScreen(
                                                              patientid:
                                                                  manageAppointment
                                                                      .patientId,
                                                              visitno:
                                                                  manageAppointment
                                                                      .visitNo,
                                                              // ernsbit: manageAppointment.er,
                                                              // currentvisit: manageAppointment.,
                                                              // checkintypevalue: manageAppointment.ch,
                                                              prescribedvalue:
                                                                  manageAppointment
                                                                      .prescribedInValue,
                                                            ));
                                                      },
                                                      child: Image.asset(
                                                        Images.rxedit,
                                                        color: ColorManager
                                                            .kPrimaryColor,
                                                        width: Get.width * 0.09,
                                                        height:
                                                            Get.height * 0.1,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: Get.width * 0.08,
                                                        right:
                                                            Get.width * 0.06),
                                                    child: const MySeparator(
                                                      color: ColorManager
                                                          .kblackColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.01,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: Get.width * 0.08,
                                                        right:
                                                            Get.width * 0.06),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Waiting Since ${manageAppointment.waitingTime ?? ""}',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 10,
                                                            color: ColorManager
                                                                .kblackColor,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${manageAppointment.status ?? ""}',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 10,
                                                            color: ColorManager
                                                                .kblackColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container());
                                  }
                                })
                            : (((ConsultingQueueController.i
                                                    .ClinicalPracticeDataList !=
                                                null) &&
                                            (ConsultingQueueController
                                                    .i
                                                    .ClinicalPracticeDataList
                                                    .queue !=
                                                null))
                                        ? ConsultingQueueController
                                            .i
                                            .ClinicalPracticeDataList
                                            .queue
                                            ?.length
                                        : 0) ==
                                    0
                                ? const Center(
                                    child: Text('No Record Found!'),
                                  )
                                : Container(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
