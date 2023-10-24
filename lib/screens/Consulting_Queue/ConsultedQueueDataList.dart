import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/doted_line.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/data/repositories/Consulting_Queue_repo/consultingQueue_repo.dart';
import 'package:doctormobileapplication/models/cosultingqueuepatient.dart';
import 'package:doctormobileapplication/screens/Consulting_Queue/Prescribe_Medicine.dart';
import 'package:doctormobileapplication/screens/Consulting_Queue/pdfview.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:doctormobileapplication/utils/testing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/images.dart';
import '../../data/controller/ConsultingQueue_Controller.dart';
import '../../helpers/color_manager.dart';
import '../../helpers/values_manager.dart';
import '../../utils/AppImages.dart';

class ConsultedQueueDataList extends StatefulWidget {
  String? Status;
  ConsultedQueueDataList({super.key, this.Status});

  @override
  State<ConsultedQueueDataList> createState() => _ConsultedQueueDataListState();
}

class _ConsultedQueueDataListState extends State<ConsultedQueueDataList> {
  TextEditingController SearchFieldController = TextEditingController();

  final GlobalKey<_ConsultedQueueDataListState> SearchFieldControllerKey =
      GlobalKey();

  final ScrollController _scrollController = ScrollController();
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
        status: "3",
        fromDate: DateTime.now().toString().split(' ')[0],
        toDate: DateTime.now().toString().split(' ')[0],
        isOnline: "false",
        token: "",
        start: "0",
        length: "10",
        orderColumn: "0",
        orderDir: "desc"));
    ConsultingQueueController.i.clearAllLists(widget.Status.toString());

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
  }

  @override
  void initState() {
    callback();

    super.initState();
  }

//ConsultedDataList
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
                      hintText: 'Search',
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.66,
                        child: (ConsultingQueueController.i.response.isNotEmpty)
                            ? ListView.builder(
                                controller: _scrollController,
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: ((ConsultingQueueController
                                        .i.response.isNotEmpty)
                                    ? ConsultingQueueController
                                        .i.response.length
                                    : 0),
                                itemBuilder: (context, index) {
                                  final manageAppointment =
                                      (ConsultingQueueController
                                              .i.response.isNotEmpty)
                                          ? ConsultingQueueController
                                              .i.response[index]
                                          : null;

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
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          child: manageAppointment
                                                                      .patientImagePath !=
                                                                  null
                                                              ? CachedNetworkImage(
                                                                  imageUrl:baseURL +
                                                                      manageAppointment
                                                                          .patientImagePath,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Image.asset(
                                                                          Images
                                                                              .avator),
                                                                )
                                                              : Image.asset(
                                                                  Images
                                                                      .avator),
                                                        ),
                                                      ),
                                                    ),
                                                    title: Transform.translate(
                                                      offset:
                                                          const Offset(-16, 0),
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
                                                    trailing: SizedBox(
                                                      width: Get.width * 0.2,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  Get.to(
                                                                    () => pdfviewconsulted(
                                                                        url: manageAppointment
                                                                            .reportURL),
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                  child: Image
                                                                      .asset(
                                                                    Images.erx,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    color: ColorManager
                                                                        .kPrimaryColor,
                                                                    width: Get
                                                                            .width *
                                                                        0.097,
                                                                    height:
                                                                        Get.height *
                                                                            0.06,
                                                                  ),
                                                                ),
                                                              ),
                                                              manageAppointment
                                                                          .isOnline !=
                                                                      true
                                                                  ? InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Get.to(() =>
                                                                            PrescribeMedicineScreen(
                                                                              checkfirst: false,
                                                                              patientstatusvalue: manageAppointment.patientStatusValue.toString(),
                                                                              patientid: manageAppointment.patientId,
                                                                              visitno: manageAppointment.visitNo,
                                                                              prescribedvalue: manageAppointment.prescribedInValue,
                                                                            ));
                                                                      },
                                                                      child: Image
                                                                          .asset(
                                                                        Images
                                                                            .rxedit,
                                                                        color: ColorManager
                                                                            .kPrimaryColor,
                                                                        width: Get.width *
                                                                            0.097,
                                                                        height: Get.height *
                                                                            0.06,
                                                                      ),
                                                                    )
                                                                  : InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Get.to(() =>
                                                                            MyHomePage(
                                                                              title: manageAppointment.chatURL,
                                                                            ));
                                                                      },
                                                                      child: Image
                                                                          .asset(
                                                                        Images
                                                                            .videocall,
                                                                        color: ColorManager
                                                                            .kPrimaryColor,
                                                                        width: Get.width *
                                                                            0.09,
                                                                        height: Get.height *
                                                                            0.06,
                                                                      ),
                                                                    ),
                                                            ],
                                                          ),
                                                        ],
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
                                                        Expanded(
                                                          child: Text(
                                                            'Waiting Since ${manageAppointment.waitingTime ?? ""}',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 10,
                                                              color: ColorManager
                                                                  .kblackColor,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
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
                                  return null;
                                })
                            : (((ConsultingQueueController
                                                    .i.ConsultedDataList !=
                                                null) &&
                                            (ConsultingQueueController.i
                                                    .ConsultedDataList.queue !=
                                                null))
                                        ? ConsultingQueueController
                                            .i.ConsultedDataList.queue?.length
                                        : 0) ==
                                    0
                                ? const Center(
                                    child: Text('No Record Found!'),
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
        ),
      ),
    );
  }
}
