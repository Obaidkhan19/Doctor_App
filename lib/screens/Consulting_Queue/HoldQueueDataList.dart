import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctormobileapplication/components/custom_refresh_indicator.dart';
import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/doted_line.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/data/repositories/Consulting_Queue_repo/consultingQueue_repo.dart';
import 'package:doctormobileapplication/models/cosultingqueuepatient.dart';
import 'package:doctormobileapplication/screens/Consulting_Queue/Prescribe_Medicine.dart';
import 'package:doctormobileapplication/screens/auth_screens/login.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:doctormobileapplication/utils/testing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/images.dart';
import '../../data/controller/ConsultingQueue_Controller.dart';
import '../../helpers/color_manager.dart';

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

  int length = 10;

  Future<void> callback() async {
    ConsultingQueueRepo.GetConsultingQueuewaitinghold(consultingqueuepatients(
        branchId: await LocalDb().getBranchId(),
        doctorId: await LocalDb().getDoctorId(),
        search: SearchFieldController.text.isEmpty
            ? ""
            : SearchFieldController.text,
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
    await ConsultingQueueController.i.clearAllLists(widget.Status.toString());
    SearchFieldController.clear();
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
    SearchFieldController.clear();
  }

  @override
  void initState() {
    callback();
    //when scroll page

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var contr = Get.put<ConsultingQueueController>(ConsultingQueueController());
    //HoldDataList
    //ConsultingQueueController.i.getConsultingQueueData('',widget.Status.toString());
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
            body: Stack(
              children: [
                const BackgroundLogoimage1(),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  // decoration: const BoxDecoration(
                  //   image: DecorationImage(
                  //     image: AssetImage(Images.logoBackground),
                  //     alignment: Alignment.centerLeft,
                  //   ),
                  // ),
                  child: SafeArea(
                    // minimum: const EdgeInsets.all(AppPadding.p14)
                    //     .copyWith(top: 0, bottom: -10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomTextField(
                            onSubmitted: (String value) {
                              SearchFieldController.text = value;
                              callback();
                              setState(() {});
                            },
                            prefixIcon: const Icon(
                              Icons.search_outlined,
                              color: ColorManager.kPrimaryColor,
                              size: 35,
                            ),
                            controller: SearchFieldController,
                            hintText: 'search'.tr,
                          ),
                          SizedBox(
                              height: Get.height * 0.68,
                              child:
                                  ConsultingQueueController
                                          .i.consultingqueuehold.isNotEmpty
                                      ? MyCustomRefreshIndicator(
                                          onRefresh: callback,
                                          child: ListView.builder(
                                              controller: _scrollController,
                                              physics:
                                                  const AlwaysScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount:
                                                  ConsultingQueueController
                                                          .i
                                                          .consultingqueuehold
                                                          .isNotEmpty
                                                      ? ConsultingQueueController
                                                          .i
                                                          .consultingqueuehold
                                                          .length
                                                      : 0,
                                              itemBuilder: (context, index) {
                                                final manageAppointment =
                                                    (ConsultingQueueController
                                                            .i
                                                            .consultingqueuehold
                                                            .isNotEmpty)
                                                        ? ConsultingQueueController
                                                                .i
                                                                .consultingqueuehold[
                                                            index]
                                                        : null;

                                                {
                                                  return ((manageAppointment !=
                                                              null &&
                                                          (manageAppointment
                                                                  .patientStatusValue
                                                                  .toString() ==
                                                              widget.Status
                                                                  .toString()))
                                                      ? Card(
                                                          elevation: 4,
                                                          surfaceTintColor:
                                                              ColorManager
                                                                  .kWhiteColor,
                                                          shape:
                                                              const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        10.0)),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.only(
                                                                top:
                                                                    Get.height *
                                                                        0.01,
                                                                bottom:
                                                                    Get.height *
                                                                        0.02),
                                                            child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          Get.width *
                                                                              0.0),
                                                                  child:
                                                                      ListTile(
                                                                    leading:
                                                                        CircleAvatar(
                                                                      backgroundColor:
                                                                          const Color
                                                                              .fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                      radius:
                                                                          30,
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(30),
                                                                        child: manageAppointment.patientImagePath !=
                                                                                null
                                                                            ? CachedNetworkImage(
                                                                                height: Get.width * 0.16,
                                                                                imageUrl: baseURL + manageAppointment.patientImagePath,
                                                                                fit: BoxFit.fill,
                                                                                errorWidget: (context, url, error) => Image.asset(Images.avator),
                                                                              )
                                                                            : Image.asset(Images.avator),
                                                                      ),
                                                                    ),
                                                                    title: Transform
                                                                        .translate(
                                                                      offset:
                                                                          const Offset(
                                                                              -0,
                                                                              0),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            manageAppointment.patientName ??
                                                                                "",
                                                                            style:
                                                                                GoogleFonts.poppins(
                                                                              fontSize: 13,
                                                                              color: ColorManager.kPrimaryColor,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            manageAppointment.mRNO ??
                                                                                "",
                                                                            style:
                                                                                GoogleFonts.poppins(
                                                                              fontSize: 10,
                                                                              color: ColorManager.kPrimaryColor,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            '${'visitNumber'.tr} ${manageAppointment.visitNo ?? ""}',
                                                                            style:
                                                                                GoogleFonts.poppins(
                                                                              fontSize: 10,
                                                                              color: ColorManager.kblackColor,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    trailing: manageAppointment.chatURL ==
                                                                            null
                                                                        ? InkWell(
                                                                            onTap:
                                                                                () async {
                                                                              bool res = await Get.to(() => PrescribeMedicineScreen(
                                                                                    checkfirst: "0",
                                                                                    patientstatusvalue: manageAppointment.patientStatusValue.toString(),
                                                                                    patientid: manageAppointment.patientId,
                                                                                    visitno: manageAppointment.visitNo,
                                                                                    prescribedvalue: manageAppointment.prescribedInValue,
                                                                                  ));
                                                                              if (res == true) {
                                                                                callback();
                                                                                setState(() {});
                                                                              }
                                                                            },
                                                                            child:
                                                                                Image.asset(
                                                                              Images.rxedit,
                                                                              color: ColorManager.kPrimaryColor,
                                                                              width: Get.width * 0.09,
                                                                              height: Get.height * 0.05,
                                                                            ),
                                                                          )
                                                                        : InkWell(
                                                                            onTap:
                                                                                () async {
                                                                              // await Get.to(() =>
                                                                              //     Callwatingscreen(
                                                                              //       data: manageAppointment,
                                                                              //     ));
                                                                              // Get.to(() =>
                                                                              //     PrescribeMedicineScreen(
                                                                              //       checkfirst: "0",
                                                                              //       patientstatusvalue: manageAppointment.patientStatusValue.toString(),
                                                                              //       patientid: manageAppointment.patientId,
                                                                              //       visitno: manageAppointment.visitNo,
                                                                              //       prescribedvalue: manageAppointment.prescribedInValue,
                                                                              //     ));
                                                                              Get.to(() => MyHomePage(
                                                                                    data: manageAppointment,
                                                                                    checkfirst: "1",
                                                                                    patientstatusvalue: manageAppointment.patientStatusValue.toString(),
                                                                                    patientid: manageAppointment.patientId,
                                                                                    visitno: manageAppointment.visitNo,
                                                                                    prescribedvalue: manageAppointment.prescribedInValue.toString(),
                                                                                    title: manageAppointment.chatURL,
                                                                                  ));
                                                                            },
                                                                            child:
                                                                                Image.asset(
                                                                              Images.videocall,
                                                                              width: Get.width * 0.09,
                                                                              height: Get.height * 0.09,
                                                                            ),
                                                                          ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      Get.height *
                                                                          0.01,
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .symmetric(
                                                                    horizontal:
                                                                        Get.width *
                                                                            0.065,
                                                                  ),
                                                                  child:
                                                                      const MySeparator(
                                                                    color: ColorManager
                                                                        .kblackColor,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      Get.height *
                                                                          0.01,
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .symmetric(
                                                                    horizontal:
                                                                        Get.width *
                                                                            0.065,
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Text(
                                                                          //   'Waiting Since ${manageAppointment.waitingTime ?? ""}',
                                                                          '${'waitingSince'.tr} ${contr.startTimeshold[index] ?? ""}',
                                                                          style:
                                                                              GoogleFonts.poppins(
                                                                            fontSize:
                                                                                10,
                                                                            color:
                                                                                ColorManager.kblackColor,
                                                                          ),
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          maxLines:
                                                                              1,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        '${manageAppointment.status ?? ""}',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              10,
                                                                          color:
                                                                              ColorManager.kblackColor,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      // Padding(
                                                      //     padding: const EdgeInsets.symmetric(
                                                      //         vertical: 5),
                                                      //     child: Container(
                                                      //       decoration: BoxDecoration(
                                                      //         color: Colors
                                                      //             .white, // Set the background color of the container
                                                      //         borderRadius:
                                                      //             BorderRadius.circular(15),
                                                      //         boxShadow: [
                                                      //           BoxShadow(
                                                      //             color: Colors.grey
                                                      //                 .withOpacity(
                                                      //                     0.2), // Shadow color
                                                      //             spreadRadius:
                                                      //                 2, // Spread radius of the shadow
                                                      //             blurRadius:
                                                      //                 2, // Blur radius of the shadow
                                                      //             offset: const Offset(0,
                                                      //                 0), // Offset of the shadow
                                                      //           ),
                                                      //         ],
                                                      //       ),
                                                      //       child: ListTile(
                                                      //         // onTap: () {},
                                                      //         shape: RoundedRectangleBorder(
                                                      //             borderRadius:
                                                      //                 BorderRadius.circular(
                                                      //                     15)),
                                                      //         leading: Image.asset(
                                                      //           Images.avator,
                                                      //           alignment:
                                                      //               Alignment.centerLeft,
                                                      //         ),
                                                      //         title: Text(
                                                      //           manageAppointment
                                                      //                   .patientName ??
                                                      //               "",
                                                      //           style: Theme.of(context)
                                                      //               .textTheme
                                                      //               .bodyMedium!
                                                      //               .copyWith(
                                                      //                   color: const Color(
                                                      //                       0xfff1272d3),
                                                      //                   fontWeight:
                                                      //                       FontWeightManager
                                                      //                           .bold),
                                                      //         ),
                                                      //         subtitle: Column(
                                                      //           crossAxisAlignment:
                                                      //               CrossAxisAlignment.start,
                                                      //           children: [
                                                      //             Text(
                                                      //               manageAppointment.mRNO ??
                                                      //                   "",
                                                      //               style: Theme.of(context)
                                                      //                   .textTheme
                                                      //                   .bodyMedium!
                                                      //                   .copyWith(
                                                      //                       color: const Color(
                                                      //                           0xfff1272d3),
                                                      //                       fontWeight:
                                                      //                           FontWeightManager
                                                      //                               .light,
                                                      //                       fontSize: 12),
                                                      //             ),
                                                      //             Text(
                                                      //               'Visit No: ${manageAppointment.visitNo ?? ""}',
                                                      //               style: Theme.of(context)
                                                      //                   .textTheme
                                                      //                   .bodyMedium!
                                                      //                   .copyWith(
                                                      //                       color: const Color(
                                                      //                           0xfff1272d3),
                                                      //                       fontWeight:
                                                      //                           FontWeightManager
                                                      //                               .light,
                                                      //                       fontSize: 12),
                                                      //             ),
                                                      //             SizedBox(
                                                      //               height:
                                                      //                   MediaQuery.of(context)
                                                      //                           .size
                                                      //                           .height *
                                                      //                       0.035,
                                                      //             ),
                                                      //             const Divider(
                                                      //               thickness: 1,
                                                      //               color: Colors.grey,
                                                      //             ),
                                                      //             Row(
                                                      //               mainAxisAlignment:
                                                      //                   MainAxisAlignment
                                                      //                       .spaceBetween,
                                                      //               children: [
                                                      //                 Flexible(
                                                      //                   child: Text(
                                                      //                     'Waiting Since   ${manageAppointment.waitingTime ?? ""}',
                                                      //                     style: Theme.of(
                                                      //                             context)
                                                      //                         .textTheme
                                                      //                         .bodyMedium!
                                                      //                         .copyWith(
                                                      //                             color: const Color(
                                                      //                                 0xfff1272d3),
                                                      //                             fontWeight:
                                                      //                                 FontWeightManager
                                                      //                                     .light,
                                                      //                             fontSize:
                                                      //                                 12),
                                                      //                   ),
                                                      //                 ),
                                                      //                 Flexible(
                                                      //                   child: Text(
                                                      //                     manageAppointment
                                                      //                             .status ??
                                                      //                         "",
                                                      //                     style: Theme.of(
                                                      //                             context)
                                                      //                         .textTheme
                                                      //                         .bodyMedium!
                                                      //                         .copyWith(
                                                      //                             color: const Color(
                                                      //                                 0xfff1272d3),
                                                      //                             fontWeight:
                                                      //                                 FontWeightManager
                                                      //                                     .light,
                                                      //                             fontSize:
                                                      //                                 12),
                                                      //                   ),
                                                      //                 ),
                                                      //               ],
                                                      //             ),
                                                      //           ],
                                                      //         ),
                                                      //         trailing: Column(
                                                      //           crossAxisAlignment:
                                                      //               CrossAxisAlignment.end,
                                                      //           mainAxisAlignment:
                                                      //               MainAxisAlignment.end,
                                                      //           children: [
                                                      //             Visibility(
                                                      //               visible: true,
                                                      //               child: InkWell(
                                                      //                 onTap: () {
                                                      //                   Get.to(
                                                      //                     () =>
                                                      //                         const PrescribeMedicineScreen(),
                                                      //                     // HistoryeRXConsultingQueue(
                                                      //                     //   patientId:
                                                      //                     //       manageAppointment
                                                      //                     //               .patientId ??
                                                      //                     //           "",
                                                      //                     //   doctorId:
                                                      //                     //       manageAppointment
                                                      //                     //               .doctorId ??
                                                      //                     //           "",
                                                      //                     //   visitNo:
                                                      //                     //       manageAppointment
                                                      //                     //               .visitNo ??
                                                      //                     //           "",
                                                      //                     //   branchId:
                                                      //                     //       manageAppointment
                                                      //                     //               .branchId ??
                                                      //                     //           "",
                                                      //                     // ),
                                                      //                   );
                                                      //                 },
                                                      //                 child: Image.asset(
                                                      //                   AppImages
                                                      //                       .editPrescription_logo,
                                                      //                   width: MediaQuery.of(
                                                      //                               context)
                                                      //                           .size
                                                      //                           .width *
                                                      //                       0.1,
                                                      //                 ),
                                                      //               ),
                                                      //             ),
                                                      //           ],
                                                      //         ),
                                                      //       ),
                                                      //     ),
                                                      //   )
                                                      : Container());
                                                  return null;
                                                }
                                                return null;
                                              }),
                                        )
                                      : (((ConsultingQueueController
                                                              .i.HoldDataList !=
                                                          null) &&
                                                      (ConsultingQueueController
                                                              .i
                                                              .HoldDataList
                                                              .queue !=
                                                          null))
                                                  ? ConsultingQueueController
                                                      .i
                                                      .HoldDataList
                                                      .queue
                                                      ?.length
                                                  : 0) ==
                                              0
                                          ? MyCustomRefreshIndicator(
                                              onRefresh: callback,
                                              child: Stack(
                                                children: <Widget>[
                                                  ListView(),
                                                  Center(
                                                      child: Text(
                                                          'NoRecordFound'.tr))
                                                ],
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
                ),
              ],
            ),
          )),
    );
  }
}
