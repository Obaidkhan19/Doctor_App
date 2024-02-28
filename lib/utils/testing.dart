import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/data/controller/ConsultingQueue_Controller.dart';
import 'package:doctormobileapplication/data/controller/erx_controller.dart';
import 'package:doctormobileapplication/data/repositories/callrepo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/consultingqueuewaithold.dart';
import 'package:doctormobileapplication/screens/Consulting_Queue/Prescribe_Medicine.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  MyHomePage(
      {super.key,
      required this.data,
      required this.title,
      required this.checkfirst,
      required this.patientstatusvalue,
      required this.patientid,
      required this.visitno,
      required this.prescribedvalue,
      this.url});

  consultingqueuewaitholdresponse data;
  final String title;
  String checkfirst;
  String patientstatusvalue;
  String patientid;
  dynamic visitno;
  dynamic prescribedvalue;

  final String? url;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  WebViewController? controller;

  opencall() async {
    Callrepo().callOpenPrescription(context, widget.data);
  }

  @override
  void initState() {
    opencall();
    controller = WebViewController(
      onPermissionRequest: (ctx) async {
        await Permission.camera.request();
        await Permission.microphone.request();
        ctx.grant();
      },
    )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onUrlChange: (change) {
            log(change.url.toString());
            if (change.url.toString() ==
                'https://meet.greenhost.net/#config.disableDeepLinking=true') {
              Get.back();
            }
          },

          // onNavigationRequest: (value) async{
          //   log(" navigationrandiaaa${value.url.toString()}");
          //   return  SizedBox.shrink() ;
          // },
          onNavigationRequest: (NavigationRequest request) {
            log('abbccc ${request.url.toString()}');
            if (request.url.toString() ==
                'https://meet.greenhost.net/#config.disableDeepLinking=true') {
              Get.back();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onProgress: (int progress) {},
          onPageStarted: (String url) async {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(
          Uri.parse("${widget.title}#config.disableDeepLinking=true"));
    super.initState();
  }

  @override
  void dispose() {
    back();
    super.dispose();
  }

  back() {
    controller = WebViewController(
      onPermissionRequest: (ctx) async {
        await Permission.camera.request();
        await Permission.microphone.request();
        ctx.deny();
      },
    )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onUrlChange: (change) {
            log(change.url.toString());
            if (change.url.toString() ==
                'https://meet.greenhost.net/#config.disableDeepLinking=true') {
              Get.back();
            }
          },

          // onNavigationRequest: (value) async{
          //   log(" navigationrandiaaa${value.url.toString()}");
          //   return  SizedBox.shrink() ;
          // },
          onNavigationRequest: (NavigationRequest request) {
            log('abbccc ${request.url.toString()}');
            if (request.url.toString() ==
                'https://meet.greenhost.net/#config.disableDeepLinking=true') {
              Get.back();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onProgress: (int progress) {},
          onPageStarted: (String url) async {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(
          Uri.parse("${widget.title}#config.disableDeepLinking=true"));
    ConsultingQueueController.i.updatecallresponse(false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConsultingQueueController>(builder: (cnt) {
      return Scaffold(
        appBar: AppBar(
          leading: const SizedBox.shrink(),
          toolbarHeight: 40,
        ),
        body: ConsultingQueueController.i.checkcallresponse == false
            ? Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    Text(
                      'waitingforpatient'.tr,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.kblackColor,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.04,
                    ),
                    SizedBox(
                        width: Get.width * 0.5,
                        child: Image.asset(Images.logo)),
                    SizedBox(
                      height: Get.height * 0.04,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20),
                      child: Container(
                        height: Get.height * 0.15,
                        width: Get.height * 0.15,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorManager.kPrimaryColor,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: widget.data.patientImagePath != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      baseURL + widget.data.patientImagePath,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    Images.avator,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              )
                            : Image.asset(Images.avator),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Text(
                      widget.data.patientName ?? "",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.kblackColor,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: ColorManager.kblackColor,
                          fontSize: 12,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'regno'.tr,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: widget.data.mRNO ?? "",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.1,
                    ),
                    InkWell(
                      onTap: () async {
                        Callrepo cr = Callrepo();
                        int res = await cr.cancelcall(
                            widget.data.doctorId,
                            widget.data.branchId,
                            widget.data.patientId,
                            widget.data.visitNo);
                        if (res == 1) {
                          Get.back();
                        } else {}
                      },
                      child: Container(
                        height: Get.height * 0.06,
                        width: Get.width * 0.7,
                        decoration: BoxDecoration(
                          color: ColorManager.kPrimaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'cancel'.tr,
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: ColorManager.kWhiteColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Stack(
                children: [
                  WebViewWidget(
                    controller: controller!,
                  ),
                ],
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton:
            ConsultingQueueController.i.checkcallresponse == true
                ? FloatingActionButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: () async {
                      showModalBottomSheet<void>(
                          isDismissible: false,
                          enableDrag: true,
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: Get.height * 0.8,
                              color: Colors.amber,
                              child: Center(
                                child: PrescribeMedicineScreen(
                                  checkfirst: widget.checkfirst,
                                  patientid: widget.patientid,
                                  patientstatusvalue: widget.patientstatusvalue,
                                  prescribedvalue: widget.patientstatusvalue,
                                  visitno: widget.visitno,
                                  chaturl: widget.url,
                                ),
                              ),
                            );
                          });
                    },
                    child: Image.asset(
                      Images.rxeditcall,
                      color: Colors.white,
                      height: Get.height * 0.05,
                    ))
                : const SizedBox.shrink(),
      );
    });
  }
}
