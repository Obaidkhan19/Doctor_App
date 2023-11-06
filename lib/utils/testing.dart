// // Copyright 2013 The Flutter Authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.

// // ignore_for_file: public_member_api_docs

// import 'package:doctormobileapplication/components/custom_checkbox_dropdown.dart';
// import 'package:doctormobileapplication/components/images.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// // #docregion platform_imports
// // Import for Android features.
// import 'package:webview_flutter_android/webview_flutter_android.dart';
// // Import for iOS features.
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// // #enddocregion platform_imports

// const String kNavigationExamplePage = '''
// <!DOCTYPE html><html>
// <head><title>Navigation Delegate Example</title></head>
// <body>
// <p>
// The navigation delegate is set to block navigation to the youtube website.
// </p>
// <ul>
// <ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
// <ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
// </ul>
// </body>
// </html>
// ''';

// const String kLocalExamplePage = '''
// <!DOCTYPE html>
// <html lang="en">
// <head>
// <title>Load file or HTML string example</title>
// </head>
// <body>

// <h1>Local demo page</h1>
// <p>
//   This is an example page used to demonstrate how to load a local file or HTML
//   string using the <a href="https://pub.dev/packages/webview_flutter">Flutter
//   webview</a> plugin.
// </p>

// </body>
// </html>
// ''';

// const String kTransparentBackgroundPage = '''
//   <!DOCTYPE html>
//   <html>
//   <head>
//     <title>Transparent background test</title>
//   </head>
//   <style type="text/css">
//     body { background: transparent; margin: 0; padding: 0; }
//     #container { position: relative; margin: 0; padding: 0; width: 100vw; height: 100vh; }
//     #shape { background: red; width: 200px; height: 200px; margin: 0; padding: 0; position: absolute; top: calc(50% - 100px); left: calc(50% - 100px); }
//     p { text-align: center; }
//   </style>
//   <body>
//     <div id="container">
//       <p>Transparent background test</p>
//       <div id="shape"></div>
//     </div>
//   </body>
//   </html>
// ''';

// const String kLogExamplePage = '''
// <!DOCTYPE html>
// <html lang="en">
// <head>
// <title>Load file or HTML string example</title>
// </head>
// <body onload="console.log('Logging that the page is loading.')">

// <h1>Local demo page</h1>
// <p>
//   This page is used to test the forwarding of console logs to Dart.
// </p>

// <style>
//     .btn-group button {
//       padding: 24px; 24px;
//       display: block;
//       width: 25%;
//       margin: 5px 0px 0px 0px;
//     }
// </style>

// <div class="btn-group">
//     <button onclick="console.error('This is an error message.')">Error</button>
//     <button onclick="console.warn('This is a warning message.')">Warning</button>
//     <button onclick="console.info('This is a info message.')">Info</button>
//     <button onclick="console.debug('This is a debug message.')">Debug</button>
//     <button onclick="console.log('This is a log message.')">Log</button>
// </div>

// </body>
// </html>
// ''';

// class WebViewExample extends StatefulWidget {
//   String url;
//   WebViewExample({super.key, required this.url});

//   @override
//   State<WebViewExample> createState() => _WebViewExampleState();
// }

// class _WebViewExampleState extends State<WebViewExample> {
//   late final WebViewController _controller;

//   @override
//   void initState() {
//     super.initState();

//     // #docregion platform_features
//     late final PlatformWebViewControllerCreationParams params;
//     if (WebViewPlatform.instance is WebKitWebViewPlatform) {
//       params = WebKitWebViewControllerCreationParams(
//         allowsInlineMediaPlayback: true,
//         mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
//       );
//     } else {
//       params = const PlatformWebViewControllerCreationParams();
//     }

//     final WebViewController controller =
//         WebViewController.fromPlatformCreationParams(params);
//     // #enddocregion platform_features

//     controller
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00FFFFFF))
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             debugPrint('WebView is loading (progress : $progress%)');
//           },
//           onPageStarted: (String url) {
//             debugPrint('Page started loading: $url');
//           },
//           onPageFinished: (String url) {
//             debugPrint('Page finished loading: $url');
//           },
//           onWebResourceError: (WebResourceError error) {
//             debugPrint('''
// Page resource error:
//   code: ${error.errorCode}
//   description: ${error.description}
//   errorType: ${error.errorType}
//   isForMainFrame: ${error.isForMainFrame}
//           ''');
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith(widget.url)) {
//               debugPrint('blocking navigation to ${request.url}');
//               return NavigationDecision.prevent;
//             }
//             debugPrint('allowing navigation to ${request.url}');
//             return NavigationDecision.navigate;
//           },
//           onUrlChange: (UrlChange change) {
//             debugPrint('url change to ${change.url}');
//           },
//         ),
//       )
//       ..addJavaScriptChannel(
//         'Toaster',
//         onMessageReceived: (JavaScriptMessage message) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(message.message)),
//           );
//         },
//       )
//       ..loadRequest(Uri.parse(widget.url));

//     // #docregion platform_features
//     if (controller.platform is AndroidWebViewController) {
//       AndroidWebViewController.enableDebugging(true);
//       (controller.platform as AndroidWebViewController)
//           .setMediaPlaybackRequiresUserGesture(false);
//     }
//     // #enddocregion platform_features

//     _controller = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       // appBar: AppBar(
//       //   automaticallyImplyLeading: false,
//       //   leading: IconButton(onPressed: (){
//       //     Get.back();
//       //   }, icon: const Icon(Icons.arrow_back_ios_new)),
//       //   centerTitle: true,
//       //   title: const Text('Flutter WebView example'),
//       //   // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
//       // ),
//       body: WebViewWidget(controller: _controller),
//       floatingActionButton: SizedBox(
//         width: Get.width*0.9,
//         child: Row(

//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//                         FloatingActionButton(onPressed: (){Get.back();},backgroundColor: Colors.red, child: const Icon(Icons.call_end,color: Colors.black,)),
//             FloatingActionButton(onPressed: (){Get.back();},backgroundColor: const Color(0xffF5F5F5),child: const Icon(Icons.chat,color: Colors.black,),
//             ),
//             favoriteButton(),

//             FloatingActionButton(onPressed: (){Get.back();},backgroundColor: const Color(0xffF5F5F5),child:  Image.asset(Images.rxeditcall,color: Colors.black,height: Get.height*0.07,),),
//           ]
//         ),

//         ),
//     );
//   }

//   Widget favoriteButton() {
//     return FloatingActionButton(
//       backgroundColor: const Color(0xffF5F5F5),
//       onPressed: () async {
//         _controller.currentUrl();
//         // if (context.mounted) {
//         //   ScaffoldMessenger.of(context).showSnackBar(
//         //     SnackBar(content: Text('Favorited $url')),
//         //   );
//         // }
//       },
//       child: const Icon(Icons.favorite,color: Colors.black,),
//     );
//   }
// }

// class NavigationControls extends StatelessWidget {
//   const NavigationControls({super.key, required this.webViewController});

//   final WebViewController webViewController;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: <Widget>[
//         IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () async {
//             if (await webViewController.canGoBack()) {
//               await webViewController.goBack();
//             } else {
//               if (context.mounted) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('No back history item')),
//                 );
//               }
//             }
//           },
//         ),
//         IconButton(
//           icon: const Icon(Icons.arrow_forward_ios),
//           onPressed: () async {
//             if (await webViewController.canGoForward()) {
//               await webViewController.goForward();
//             } else {
//               if (context.mounted) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('No forward history item')),
//                 );
//               }
//             }
//           },
//         ),
//         IconButton(
//           icon: const Icon(Icons.replay),
//           onPressed: () => webViewController.reload(),
//         ),
//       ],
//     );
//   }
// }
import 'package:doctormobileapplication/components/snackbar.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/data/controller/ConsultingQueue_Controller.dart';
import 'package:doctormobileapplication/data/repositories/callrepo.dart';
import 'package:doctormobileapplication/models/consultingqueuewaithold.dart';
import 'package:doctormobileapplication/screens/Consulting_Queue/Prescribe_Medicine.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage(
      {super.key,
      required this.data,
      required this.title,
      required this.checkfirst,
      required this.patientstatusvalue,
      required this.patientid,
      required this.visitno,
      required this.prescribedvalue});

  consultingqueuewaitholdresponse data;
  final String title;
  String checkfirst;
  String patientstatusvalue;
  String patientid;
  dynamic visitno;
  dynamic prescribedvalue;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  opencall() async {
    Callrepo().callOpenPrescription(context, widget.data);
  }

  call() async {
    //  var options = JitsiMeetConferenceOptions(room:widget.title,);
    JitsiMeetConferenceOptions options =
        JitsiMeetConferenceOptions(room: widget.title);
    await jitsiMeet.join(
      options,
      listener,
    );
  }

  dynamic listener;

  @override
  void initState() {
    opencall();
    //  listener = JitsiMeetEventListener(
    //     conferenceJoined: (url) {
    //       debugPrint("conferenceJoined: url: $url");
    //       Get.back();
    //     },
    //     readyToClose: () {
    //       debugPrint("readyToClose");
    //     },
    //   );
    //  call();
    super.initState();
  }

  @override
  void dispose() {
    ConsultingQueueController.i.updatecallresponse(false);
    super.dispose();
  }

  final meetingNameController = TextEditingController();
  final jitsiMeet = JitsiMeet();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConsultingQueueController>(builder: (cont) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: ColorManager.kPrimaryColor,
              )),
          title: Text(
            'onlineconsultation'.tr,
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: ColorManager.kPrimaryColor,
            ),
          ),
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
                        } else {
                          showSnackbar(context, "Something went wrong");
                        }
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
            : Center(
                child: SizedBox(
                  child: InAppWebView(
                      initialUrlRequest: URLRequest(
                          url: Uri.parse(
                              "${widget.title}#config.disableDeepLinking=true")),
                      initialOptions: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                          mediaPlaybackRequiresUserGesture: false,
                        ),
                      ),
                      onWebViewCreated:
                          (InAppWebViewController controller) async {
                        await Permission.camera.request();
                        await Permission.microphone.request();
                        controller;
                      },
                      androidOnPermissionRequest:
                          (InAppWebViewController controller, String origin,
                              List<String> resources) async {
                        return PermissionRequestResponse(
                            resources: resources,
                            action: PermissionRequestResponseAction.GRANT);
                      }),
                ),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton:
            ConsultingQueueController.i.checkcallresponse == true
                ? FloatingActionButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                content: PrescribeMedicineScreen(
                                  checkfirst: widget.checkfirst,
                                  patientid: widget.patientid,
                                  patientstatusvalue: widget.patientstatusvalue,
                                  prescribedvalue: widget.patientstatusvalue,
                                  visitno: widget.visitno,
                                ),
                              );
                            },
                          );
                        },
                      );
                      // showModalBottomSheet<void>(
                      //   isScrollControlled: true,
                      //   isDismissible: false,
                      //   context: context,
                      //   builder: (BuildContext context) {
                      //     return Container(
                      //       height: Get.height * 0.9,
                      //       color: Colors.amber,
                      //       child: PrescribeMedicineScreen(
                      //         checkfirst: widget.checkfirst,
                      //         patientid: widget.patientid,
                      //         patientstatusvalue: widget.patientstatusvalue,
                      //         prescribedvalue: widget.patientstatusvalue,
                      //         visitno: widget.visitno,
                      //       ),
                      //     );
                      //   },
                      // );
                      // Get.to(() => PrescribeMedicineScreen(
                      //       checkfirst: true,
                      //       patientstatusvalue: widget.patientstatusvalue.toString(),
                      //       patientid: widget.patientid,
                      //       visitno: widget.visitno,
                      //       prescribedvalue: widget.prescribedvalue,
                      //     ));
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

// dyeh4X8GThWroZ4c8qK_em:APA91bHo1gXBNvMwloR0vxjpMLlZ5Lauzw-v6_Zqba9Eytkzs5AYXDjxJ5m_n3ZoJyHUFEdGyl0fHgDYmOXvEmPKV2dSOPzGlvEO9twbDeVZflhb8ccC5EMJ0dsePLF8xehpNDsAoBFT
//  dQhtMIqHTcOUEcSC-UbkM8:APA91bHxglRAmbEBoWl8QgCX6e0dH_W-doUkwDAXpZtypY5EedEKdDHQedcLm78nkvb2JUtv0xg34MQ8vwlNoEVTLw5aY442f8ZO-mFwuPqq3JzQSOmnkkNply4ZRiD-sULJdDYBlfHW

// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// // #docregion platform_imports
// // Import for Android features.
// import 'package:webview_flutter_android/webview_flutter_android.dart';
// // Import for iOS features.
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// // #enddocregion platform_imports



// const String kNavigationExamplePage = '''
// <!DOCTYPE html><html>
// <head><title>Navigation Delegate Example</title></head>
// <body>
// <p>
// The navigation delegate is set to block navigation to the youtube website.
// </p>
// <ul>
// <ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
// <ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
// </ul>
// </body>
// </html>
// ''';

// const String kLocalExamplePage = '''
// <!DOCTYPE html>
// <html lang="en">
// <head>
// <title>Load file or HTML string example</title>
// </head>
// <body>

// <h1>Local demo page</h1>
// <p>
//   This is an example page used to demonstrate how to load a local file or HTML
//   string using the <a href="https://pub.dev/packages/webview_flutter">Flutter
//   webview</a> plugin.
// </p>

// </body>
// </html>
// ''';

// const String kTransparentBackgroundPage = '''
//   <!DOCTYPE html>
//   <html>
//   <head>
//     <title>Transparent background test</title>
//   </head>
//   <style type="text/css">
//     body { background: transparent; margin: 0; padding: 0; }
//     #container { position: relative; margin: 0; padding: 0; width: 100vw; height: 100vh; }
//     #shape { background: red; width: 200px; height: 200px; margin: 0; padding: 0; position: absolute; top: calc(50% - 100px); left: calc(50% - 100px); }
//     p { text-align: center; }
//   </style>
//   <body>
//     <div id="container">
//       <p>Transparent background test</p>
//       <div id="shape"></div>
//     </div>
//   </body>
//   </html>
// ''';

// const String kLogExamplePage = '''
// <!DOCTYPE html>
// <html lang="en">
// <head>
// <title>Load file or HTML string example</title>
// </head>
// <body onload="console.log('Logging that the page is loading.')">

// <h1>Local demo page</h1>
// <p>
//   This page is used to test the forwarding of console logs to Dart.
// </p>

// <style>
//     .btn-group button {
//       padding: 24px; 24px;
//       display: block;
//       width: 25%;
//       margin: 5px 0px 0px 0px;
//     }
// </style>

// <div class="btn-group">
//     <button onclick="console.error('This is an error message.')">Error</button>
//     <button onclick="console.warn('This is a warning message.')">Warning</button>
//     <button onclick="console.info('This is a info message.')">Info</button>
//     <button onclick="console.debug('This is a debug message.')">Debug</button>
//     <button onclick="console.log('This is a log message.')">Log</button>
// </div>

// </body>
// </html>
// ''';

// class WebViewExample extends StatefulWidget {
//   String title;
//    WebViewExample({super.key,required this.title});

//   @override
//   State<WebViewExample> createState() => _WebViewExampleState();
// }

// class _WebViewExampleState extends State<WebViewExample> {
//   late final WebViewController _controller;

//   @override
//   void initState() {
//     super.initState();

//     // #docregion platform_features
//     late final PlatformWebViewControllerCreationParams params;
//     if (WebViewPlatform.instance is WebKitWebViewPlatform) {
//       params = WebKitWebViewControllerCreationParams(
//         allowsInlineMediaPlayback: true,
//         mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
//       );
//     } else {
//       params = const PlatformWebViewControllerCreationParams();
//     }

//     final WebViewController controller =
//         WebViewController.fromPlatformCreationParams(params);
//     // #enddocregion platform_features

//     controller
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             debugPrint('WebView is loading (progress : $progress%)');
//           },
//           onPageStarted: (String url) {
//             debugPrint('Page started loading: $url');
//           },
//           onPageFinished: (String url) {
//             debugPrint('Page finished loading: $url');
//           },
//           onWebResourceError: (WebResourceError error) {
//             debugPrint('''
// Page resource error:
//   code: ${error.errorCode}
//   description: ${error.description}
//   errorType: ${error.errorType}
//   isForMainFrame: ${error.isForMainFrame}
//           ''');
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('https://www.youtube.com/')) {
//               debugPrint('blocking navigation to ${request.url}');
//               return NavigationDecision.prevent;
//             }
//             debugPrint('allowing navigation to ${request.url}');
//             return NavigationDecision.navigate;
//           },
//           onUrlChange: (UrlChange change) {
//             debugPrint('url change to ${change.url}');
//           },
//         ),
//       )
//       ..addJavaScriptChannel(
//         'Toaster',
//         onMessageReceived: (JavaScriptMessage message) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(message.message)),
//           );
//         },
//       )
//       ..loadRequest(Uri.parse('${widget.title}#config.disableDeepLinking=true'));

//     // #docregion platform_features
//     if (controller.platform is AndroidWebViewController) {
//       AndroidWebViewController.enableDebugging(true);
//       (controller.platform as AndroidWebViewController)
//           .setMediaPlaybackRequiresUserGesture(false);
//     }
//     // #enddocregion platform_features

//     _controller = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green,
//       appBar: AppBar(
//         title: const Text('Flutter WebView example'),
//         // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
//         actions: <Widget>[
//           NavigationControls(webViewController: _controller),
//           SampleMenu(webViewController: _controller),
//         ],
//       ),
//       body: WebViewWidget(controller: _controller),
//       floatingActionButton: favoriteButton(),
//     );
//   }

//   Widget favoriteButton() {
//     return FloatingActionButton(
//       onPressed: () async {
//         final String? url = await _controller.currentUrl();
//         if (context.mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Favorited $url')),
//           );
//         }
//       },
//       child: const Icon(Icons.favorite),
//     );
//   }
// }

// enum MenuOptions {
//   showUserAgent,
//   listCookies,
//   clearCookies,
//   addToCache,
//   listCache,
//   clearCache,
//   navigationDelegate,
//   doPostRequest,
//   loadLocalFile,
//   loadFlutterAsset,
//   loadHtmlString,
//   transparentBackground,
//   setCookie,
//   logExample,
// }

// class SampleMenu extends StatelessWidget {
//   SampleMenu({
//     super.key,
//     required this.webViewController,
//   });

//   final WebViewController webViewController;
//   late final WebViewCookieManager cookieManager = WebViewCookieManager();

//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton<MenuOptions>(
//       key: const ValueKey<String>('ShowPopupMenu'),
//       onSelected: (MenuOptions value) {
//         switch (value) {
//           case MenuOptions.showUserAgent:
//             _onShowUserAgent();
//             break;
//           case MenuOptions.listCookies:
//             _onListCookies(context);
//             break;
//           case MenuOptions.clearCookies:
//             _onClearCookies(context);
//             break;
//           case MenuOptions.addToCache:
//             _onAddToCache(context);
//             break;
//           case MenuOptions.listCache:
//             _onListCache();
//             break;
//           case MenuOptions.clearCache:
//             _onClearCache(context);
//             break;
//           case MenuOptions.navigationDelegate:
//             _onNavigationDelegateExample();
//             break;
//           case MenuOptions.doPostRequest:
//             _onDoPostRequest();
//             break;
//           case MenuOptions.loadLocalFile:
//             _onLoadLocalFileExample();
//             break;
//           case MenuOptions.loadFlutterAsset:
//             _onLoadFlutterAssetExample();
//             break;
//           case MenuOptions.loadHtmlString:
//             _onLoadHtmlStringExample();
//             break;
//           case MenuOptions.transparentBackground:
//             _onTransparentBackground();
//             break;
//           case MenuOptions.setCookie:
//             _onSetCookie();
//             break;
//           case MenuOptions.logExample:
//             _onLogExample();
//             break;
//         }
//       },
//       itemBuilder: (BuildContext context) => <PopupMenuItem<MenuOptions>>[
//         const PopupMenuItem<MenuOptions>(
//           value: MenuOptions.showUserAgent,
//           child: Text('Show user agent'),
//         ),
//         const PopupMenuItem<MenuOptions>(
//           value: MenuOptions.listCookies,
//           child: Text('List cookies'),
//         ),
//         const PopupMenuItem<MenuOptions>(
//           value: MenuOptions.clearCookies,
//           child: Text('Clear cookies'),
//         ),
//         const PopupMenuItem<MenuOptions>(
//           value: MenuOptions.addToCache,
//           child: Text('Add to cache'),
//         ),
//         const PopupMenuItem<MenuOptions>(
//           value: MenuOptions.listCache,
//           child: Text('List cache'),
//         ),
//         const PopupMenuItem<MenuOptions>(
//           value: MenuOptions.clearCache,
//           child: Text('Clear cache'),
//         ),
//         const PopupMenuItem<MenuOptions>(
//           value: MenuOptions.navigationDelegate,
//           child: Text('Navigation Delegate example'),
//         ),
//         const PopupMenuItem<MenuOptions>(
//           value: MenuOptions.doPostRequest,
//           child: Text('Post Request'),
//         ),
//         const PopupMenuItem<MenuOptions>(
//           value: MenuOptions.loadHtmlString,
//           child: Text('Load HTML string'),
//         ),
//         const PopupMenuItem<MenuOptions>(
//           value: MenuOptions.loadLocalFile,
//           child: Text('Load local file'),
//         ),
//         const PopupMenuItem<MenuOptions>(
//           value: MenuOptions.loadFlutterAsset,
//           child: Text('Load Flutter Asset'),
//         ),
//         const PopupMenuItem<MenuOptions>(
//           key: ValueKey<String>('ShowTransparentBackgroundExample'),
//           value: MenuOptions.transparentBackground,
//           child: Text('Transparent background example'),
//         ),
//         const PopupMenuItem<MenuOptions>(
//           value: MenuOptions.setCookie,
//           child: Text('Set cookie'),
//         ),
//         const PopupMenuItem<MenuOptions>(
//           value: MenuOptions.logExample,
//           child: Text('Log example'),
//         ),
//       ],
//     );
//   }

//   Future<void> _onShowUserAgent() {
//     // Send a message with the user agent string to the Toaster JavaScript channel we registered
//     // with the WebView.
//     return webViewController.runJavaScript(
//       'Toaster.postMessage("User Agent: " + navigator.userAgent);',
//     );
//   }

//   Future<void> _onListCookies(BuildContext context) async {
//     final String cookies = await webViewController
//         .runJavaScriptReturningResult('document.cookie') as String;
//     if (context.mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             const Text('Cookies:'),
//             _getCookieList(cookies),
//           ],
//         ),
//       ));
//     }
//   }

//   Future<void> _onAddToCache(BuildContext context) async {
//     await webViewController.runJavaScript(
//       'caches.open("test_caches_entry"); localStorage["test_localStorage"] = "dummy_entry";',
//     );
//     if (context.mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text('Added a test entry to cache.'),
//       ));
//     }
//   }

//   Future<void> _onListCache() {
//     return webViewController.runJavaScript('caches.keys()'
//         // ignore: missing_whitespace_between_adjacent_strings
//         '.then((cacheKeys) => JSON.stringify({"cacheKeys" : cacheKeys, "localStorage" : localStorage}))'
//         '.then((caches) => Toaster.postMessage(caches))');
//   }

//   Future<void> _onClearCache(BuildContext context) async {
//     await webViewController.clearCache();
//     await webViewController.clearLocalStorage();
//     if (context.mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text('Cache cleared.'),
//       ));
//     }
//   }

//   Future<void> _onClearCookies(BuildContext context) async {
//     final bool hadCookies = await cookieManager.clearCookies();
//     String message = 'There were cookies. Now, they are gone!';
//     if (!hadCookies) {
//       message = 'There are no cookies.';
//     }
//     if (context.mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(message),
//       ));
//     }
//   }

//   Future<void> _onNavigationDelegateExample() {
//     final String contentBase64 = base64Encode(
//       const Utf8Encoder().convert(kNavigationExamplePage),
//     );
//     return webViewController.loadRequest(
//       Uri.parse('data:text/html;base64,$contentBase64'),
//     );
//   }

//   Future<void> _onSetCookie() async {
//     await cookieManager.setCookie(
//       const WebViewCookie(
//         name: 'foo',
//         value: 'bar',
//         domain: 'httpbin.org',
//         path: '/anything',
//       ),
//     );
//     await webViewController.loadRequest(Uri.parse(
//       'https://httpbin.org/anything',
//     ));
//   }

//   Future<void> _onDoPostRequest() {
//     return webViewController.loadRequest(
//       Uri.parse('https://httpbin.org/post'),
//       method: LoadRequestMethod.post,
//       headers: <String, String>{'foo': 'bar', 'Content-Type': 'text/plain'},
//       body: Uint8List.fromList('Test Body'.codeUnits),
//     );
//   }

//   Future<void> _onLoadLocalFileExample() async {
//     final String pathToIndex = await _prepareLocalFile();
//     await webViewController.loadFile(pathToIndex);
//   }

//   Future<void> _onLoadFlutterAssetExample() {
//     return webViewController.loadFlutterAsset('assets/www/index.html');
//   }

//   Future<void> _onLoadHtmlStringExample() {
//     return webViewController.loadHtmlString(kLocalExamplePage);
//   }

//   Future<void> _onTransparentBackground() {
//     return webViewController.loadHtmlString(kTransparentBackgroundPage);
//   }

//   Widget _getCookieList(String cookies) {
//     if (cookies == '""') {
//       return Container();
//     }
//     final List<String> cookieList = cookies.split(';');
//     final Iterable<Text> cookieWidgets =
//         cookieList.map((String cookie) => Text(cookie));
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       mainAxisSize: MainAxisSize.min,
//       children: cookieWidgets.toList(),
//     );
//   }

//   static Future<String> _prepareLocalFile() async {
//     final String tmpDir = (await getTemporaryDirectory()).path;
//     final File indexFile = File(
//         <String>{tmpDir, 'www', 'index.html'}.join(Platform.pathSeparator));

//     await indexFile.create(recursive: true);
//     await indexFile.writeAsString(kLocalExamplePage);

//     return indexFile.path;
//   }

//   Future<void> _onLogExample() {
//     webViewController
//         .setOnConsoleMessage((JavaScriptConsoleMessage consoleMessage) {
//       debugPrint(
//           '== JS == ${consoleMessage.level.name}: ${consoleMessage.message}');
//     });

//     return webViewController.loadHtmlString(kLogExamplePage);
//   }
// }

// class NavigationControls extends StatelessWidget {
//   const NavigationControls({super.key, required this.webViewController});

//   final WebViewController webViewController;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: <Widget>[
//         IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () async {
//             if (await webViewController.canGoBack()) {
//               await webViewController.goBack();
//             } else {
//               if (context.mounted) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('No back history item')),
//                 );
//               }
//             }
//           },
//         ),
//         IconButton(
//           icon: const Icon(Icons.arrow_forward_ios),
//           onPressed: () async {
//             if (await webViewController.canGoForward()) {
//               await webViewController.goForward();
//             } else {
//               if (context.mounted) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('No forward history item')),
//                 );
//               }
//             }
//           },
//         ),
//         IconButton(
//           icon: const Icon(Icons.replay),
//           onPressed: () => webViewController.reload(),
//         ),
//       ],
//     );
//   }
// }







// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   // call() async {
//   //   //  var options = JitsiMeetConferenceOptions(room:widget.title,);
//   //   JitsiMeetConferenceOptions options =
//   //       JitsiMeetConferenceOptions(room: widget.title);
//   //   await jitsiMeet.join(
//   //     options,
//   //     listener,
//   //   );
//   // }

//   // dynamic listener;

//   @override
//   void initState() {
//     //  listener = JitsiMeetEventListener(
//     //     conferenceJoined: (url) {
//     //       debugPrint("conferenceJoined: url: $url");
//     //       Get.back();
//     //     },
//     //     readyToClose: () {
//     //       debugPrint("readyToClose");
//     //     },
//     //   );

//     //  call();
//     super.initState();
//   }

//   // final meetingNameController = TextEditingController();
//   // final jitsiMeet = JitsiMeet();
// // InAppWebViewController? _webViewController;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         leading: IconButton(
//             onPressed: () {
//               // Navigator.pop(context);
//               Get.back();
//               // _webViewController?.goBack();
//             },
//             icon: const Icon(Icons.arrow_back_ios_new)),
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: WebViewWidget(
//         controller: WebViewController()
//           ..setJavaScriptMode(JavaScriptMode.unrestricted)
//           ..setBackgroundColor(const Color(0x00000000))
//           ..setNavigationDelegate(
//             NavigationDelegate(
//               onProgress: (int progress) {
//                 // Update loading bar.
//               },
//               onPageStarted: (String url) {},
//               onPageFinished: (String url) {},
//               onWebResourceError: (WebResourceError error) {},
//             ),
//           )
//           ..loadRequest(
//               Uri.parse("${widget.title}#config.disableDeepLinking=true")),

//         // URLRequest(url: Uri.parse("${widget.title}#config.disableDeepLinking=true")),
//         // initialOptions: InAppWebViewGroupOptions(
//         //   crossPlatform: InAppWebViewOptions(
//         //     mediaPlaybackRequiresUserGesture: false,
//         //   ),
//         // ),
//         // onWebViewCreated: (InAppWebViewController controller) {
//         //   _webViewController= controller;
//         // },
//         // androidOnPermissionRequest:
//         //     (InAppWebViewController controller, String origin,
//         //         List<String> resources) async {
//         //   return PermissionRequestResponse(
//         //       resources: resources,
//         //       action: PermissionRequestResponseAction.GRANT);
//         // }
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
//       floatingActionButton: FloatingActionButton(
//           onPressed: () {}, child: const Icon(Icons.block)),
//     );
//   }
// }





