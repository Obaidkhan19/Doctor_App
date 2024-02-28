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
  final String? Status;
  const HoldQueueDataList({super.key, this.Status});

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
            color: ColorManager.kPrimaryColor,
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
                                                              RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(
                                                                    Get.width *
                                                                        0.04)),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: Get.height *
                                                                  0.02,
                                                              bottom:
                                                                  Get.height *
                                                                      0.02,
                                                              left: Get.height *
                                                                  0.01,
                                                              right:
                                                                  Get.height *
                                                                      0.01,
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                ListTile(
                                                                  leading:
                                                                      CircleAvatar(
                                                                    backgroundColor:
                                                                        const Color
                                                                            .fromARGB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    radius: 30,
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              27),
                                                                      child: manageAppointment.patientImagePath !=
                                                                              null
                                                                          ? CachedNetworkImage(
                                                                              imageUrl: baseURL + manageAppointment.patientImagePath,
                                                                              imageBuilder: (context, imageProvider) => Container(
                                                                                decoration: BoxDecoration(
                                                                                  shape: BoxShape.circle,
                                                                                  image: DecorationImage(
                                                                                    image: imageProvider,
                                                                                    fit: BoxFit.fill,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              errorWidget: (context, url, error) => Image.asset(Images.avator),
                                                                            )
                                                                          : Image.asset(
                                                                              Images.avator),
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
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          manageAppointment.patientName ??
                                                                              "",
                                                                          style:
                                                                              GoogleFonts.poppins(
                                                                            fontSize:
                                                                                13,
                                                                            color:
                                                                                ColorManager.kPrimaryColor,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          manageAppointment.mRNO ??
                                                                              "",
                                                                          style:
                                                                              GoogleFonts.poppins(
                                                                            fontSize:
                                                                                10,
                                                                            color:
                                                                                ColorManager.kPrimaryColor,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          '${'visitNumber'.tr} ${manageAppointment.visitNo ?? ""}',
                                                                          style:
                                                                              GoogleFonts.poppins(
                                                                            fontSize:
                                                                                10,
                                                                            color:
                                                                                ColorManager.kblackColor,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  trailing: manageAppointment
                                                                              .chatURL ==
                                                                          null
                                                                      ? Padding(
                                                                          padding:
                                                                              EdgeInsets.only(right: Get.width * 0.01),
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () async {
                                                                              bool res = await Get.to(() => PrescribeMedicineScreen(
                                                                                    checkfirst: "0",
                                                                                    patientstatusvalue: manageAppointment.patientStatusValue.toString(),
                                                                                    patientid: manageAppointment.patientId,
                                                                                    visitno: manageAppointment.visitNo,
                                                                                    prescribedvalue: manageAppointment.prescribedInValue,
                                                                                    chaturl: manageAppointment.chatURL,
                                                                                  ));
                                                                              if (res == true) {
                                                                                callback();
                                                                                setState(() {});
                                                                              }
                                                                            },
                                                                            child:
                                                                                SizedBox(
                                                                              height: Get.width * 0.09,
                                                                              child: Image.asset(
                                                                                Images.rxedit,
                                                                                color: ColorManager.kPrimaryColor,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : Padding(
                                                                          padding:
                                                                              EdgeInsets.only(right: Get.width * 0.01),
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () async {
                                                                              Get.to(() => MyHomePage(
                                                                                    data: manageAppointment,
                                                                                    checkfirst: "1",
                                                                                    patientstatusvalue: manageAppointment.patientStatusValue.toString(),
                                                                                    patientid: manageAppointment.patientId,
                                                                                    visitno: manageAppointment.visitNo,
                                                                                    prescribedvalue: manageAppointment.prescribedInValue.toString(),
                                                                                    title: manageAppointment.chatURL,
                                                                                    url: manageAppointment.chatURL,
                                                                                  ));
                                                                            },
                                                                            child:
                                                                                SizedBox(
                                                                              height: Get.width * 0.09,
                                                                              child: Image.asset(
                                                                                Images.videocall,
                                                                              ),
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
                                                                          '${'waitingSince'.tr} ${contr.startTimeshold[index]}',
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
                                                      : Container());
                                                }
                                              }),
                                        )
                                      : (((ConsultingQueueController.i
                                                          .HoldDataList.queue !=
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
                                          : Container()),
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
