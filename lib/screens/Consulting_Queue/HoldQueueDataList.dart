import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/data/repositories/Consulting_Queue_repo/consultingQueue_repo.dart';
import 'package:doctormobileapplication/models/cosultingqueuepatient.dart';
import 'package:doctormobileapplication/screens/Consulting_Queue/new_consulting_queue/Prescribe_Medicine.dart';
import 'package:doctormobileapplication/screens/appointment_configuration/configure_appointment_listtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../components/CustomFormField.dart';
import '../../components/images.dart';
import '../../data/controller/ConsultingQueue_Controller.dart';
import '../../helpers/color_manager.dart';
import '../../helpers/font_manager.dart';
import '../../helpers/values_manager.dart';
import '../../utils/AppImages.dart';
import 'History_eRX.dart';

class HoldQueueDataList extends StatefulWidget {
  String? Status;
  HoldQueueDataList({super.key, this.Status});

  @override
  State<HoldQueueDataList> createState() => _HoldQueueDataListState();
}

class _HoldQueueDataListState extends State<HoldQueueDataList> {
  TextEditingController SearchFieldController = TextEditingController();

  final GlobalKey<_HoldQueueDataListState> SearchFieldControllerKey =
      GlobalKey();
  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  int length=10;
callback() async
{
      ConsultingQueueRepo.GetConsultingQueuewaitinghold(
        consultingqueuepatients(
           branchId: "",
            doctorId: await LocalDb().getDoctorId(),
            search: "",
            workLocationId: "",
            status: "2",
            fromDate: DateTime.now().toString().split(' ')[0],
            toDate: DateTime.now().toString().split(' ')[0],
            isOnline: "false",
            token: "",
            start: "0",
            length: length.toString(),
            orderColumn: "0",
            orderDir: "desc"));
}

  @override
  void initState() {
    // ConsultingQueueController.i.clearAllLists(widget.Status.toString());
    // ConsultingQueueController.i
    //     .getConsultingQueueData('', widget.Status.toString());
    SearchFieldController.clear();
callback();
    //when scroll page
    _scrollController.addListener(() {
      // var nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;
      // if (_scrollController.position.pixels > nextPageTrigger) {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        var isCallToFetchData =
            ConsultingQueueController.i.SetStartToFetchNextData();
        if (isCallToFetchData) {
          length=length+10;
         callback();
          // ConsultingQueueController.i.getConsultingQueueData(
          //     SearchFieldController.text, widget.Status.toString());
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var contr = Get.put<ConsultingQueueController>(ConsultingQueueController());
    //HoldDataList
    //ConsultingQueueController.i.getConsultingQueueData('',widget.Status.toString());
    return BlurryModalProgressHUD(
        inAsyncCall:
            ConsultingQueueController.i.isLoadingDataClinicalPracticeDataList,
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
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.helpful_background_logo),
                alignment: Alignment.centerLeft,
              ),
            ),
            child: SafeArea(
              minimum: const EdgeInsets.all(AppPadding.p14).copyWith(top: 0),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: CustomFormField(
                            focusnode: false,
                            onchange: (val) {
                              if (val!.isEmpty) {
                                ConsultingQueueController.i
                                    .clearAllLists(widget.Status.toString());
                                ConsultingQueueController.i
                                    .getConsultingQueueData(
                                        '', widget.Status.toString());
                              }
                            },
                            key: SearchFieldControllerKey,
                            controller: SearchFieldController,
                            hintText: 'Search',
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            ConsultingQueueController.i
                                .clearAllLists(widget.Status.toString());
                            ConsultingQueueController.i.getConsultingQueueData(
                                SearchFieldController.text.toString(),
                                widget.Status.toString());
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.06,
                              decoration: BoxDecoration(
                                color: const Color(0xfff1272d3),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                  child: Icon(
                                Icons.search,
                                color: ColorManager.kWhiteColor,
                                size: MediaQuery.of(context).size.height * 0.04,
                              ))),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.62,
                      child:
                          // SingleChildScrollView(
                          //   child: Column(
                          //     children: [
                          //       SizedBox(
                          //         height: Get.height * 0.015,
                          //       ),
                          ConsultingQueueController.i.consultingqueuehold.isNotEmpty
                              ? ListView.builder(
                                  controller: _scrollController,
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: ConsultingQueueController.i.consultingqueuehold.isNotEmpty
                                      ? ConsultingQueueController.i.consultingqueuehold.length
                                      : 0,
                                  itemBuilder: (context, index) {
                                    final manageAppointment =
                                        (ConsultingQueueController
                                                    .i.consultingqueuehold.isNotEmpty)
                                            ? ConsultingQueueController
                                                .i.consultingqueuehold[index]
                                            : null;
                                 
                                    {
                                      return ((manageAppointment != null &&
                                              (manageAppointment
                                                      .patientStatusValue
                                                      .toString() ==
                                                  widget.Status.toString()))
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors
                                                      .white, // Set the background color of the container
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(
                                                              0.2), // Shadow color
                                                      spreadRadius:
                                                          2, // Spread radius of the shadow
                                                      blurRadius:
                                                          2, // Blur radius of the shadow
                                                      offset: const Offset(0,
                                                          0), // Offset of the shadow
                                                    ),
                                                  ],
                                                ),
                                                child: ListTile(
                                                  // onTap: () {},
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  leading: Image.asset(
                                                    Images.avator,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                  ),
                                                  title: Text(
                                                    manageAppointment
                                                            .patientName ??
                                                        "",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            color: const Color(
                                                                0xfff1272d3),
                                                            fontWeight:
                                                                FontWeightManager
                                                                    .bold),
                                                  ),
                                                  subtitle: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        manageAppointment
                                                                .mRNO ??
                                                            "",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                                color: const Color(
                                                                    0xfff1272d3),
                                                                fontWeight:
                                                                    FontWeightManager
                                                                        .light,
                                                                fontSize: 12),
                                                      ),
                                                      Text(
                                                        'Visit No: ${manageAppointment.visitNo ?? ""}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                                color: const Color(
                                                                    0xfff1272d3),
                                                                fontWeight:
                                                                    FontWeightManager
                                                                        .light,
                                                                fontSize: 12),
                                                      ),
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.035,
                                                      ),
                                                      const Divider(
                                                        thickness: 1,
                                                        color: Colors.grey,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              'Waiting Since   ${manageAppointment.waitingTime ?? ""}',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                      color: const Color(
                                                                          0xfff1272d3),
                                                                      fontWeight:
                                                                          FontWeightManager
                                                                              .light,
                                                                      fontSize:
                                                                          12),
                                                            ),
                                                          ),
                                                          Flexible(
                                                            child: Text(
                                                              manageAppointment
                                                                      .status ??
                                                                  "",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                      color: const Color(
                                                                          0xfff1272d3),
                                                                      fontWeight:
                                                                          FontWeightManager
                                                                              .light,
                                                                      fontSize:
                                                                          12),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  trailing: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Visibility(
                                                        visible: true,
                                                        child: InkWell(
                                                          onTap: () {
                                                            Get.to(
                                                              () =>
                                                                  const PrescribeMedicineScreen(),
                                                              // HistoryeRXConsultingQueue(
                                                              //   patientId:
                                                              //       manageAppointment
                                                              //               .patientId ??
                                                              //           "",
                                                              //   doctorId:
                                                              //       manageAppointment
                                                              //               .doctorId ??
                                                              //           "",
                                                              //   visitNo:
                                                              //       manageAppointment
                                                              //               .visitNo ??
                                                              //           "",
                                                              //   branchId:
                                                              //       manageAppointment
                                                              //               .branchId ??
                                                              //           "",
                                                              // ),
                                                            );
                                                          },
                                                          child: Image.asset(
                                                            AppImages
                                                                .editPrescription_logo,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.1,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container());
                                      return null;
                                    }
                                    return null;
                                  })
                              : (((ConsultingQueueController.i.HoldDataList !=
                                                  null) &&
                                              (ConsultingQueueController
                                                      .i.HoldDataList.queue !=
                                                  null))
                                          ? ConsultingQueueController
                                              .i.HoldDataList.queue?.length
                                          : 0) ==
                                      0
                                  ? SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                      child: const Center(
                                        child: Text('No Record Found!'),
                                      ),
                                    )
                                  : Container()
                      //     ],
                      //   ),
                      // ),
                      ),
                ],
              ),
            ),
          ),
        ));
  }
}
