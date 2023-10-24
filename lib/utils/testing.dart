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


import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

call() async{
   var options = JitsiMeetConferenceOptions(room:widget.title);
   await jitsiMeet.join(options,JitsiMeetEventListener());
   Get.back();
}
  @override
  void initState() {
    log(widget.title);
   call();
    
    super.initState();
  }
  final meetingNameController = TextEditingController();
  final jitsiMeet = JitsiMeet();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: CircularProgressIndicator(color: Colors.blue,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(onPressed: (){}),
    );
  }
}