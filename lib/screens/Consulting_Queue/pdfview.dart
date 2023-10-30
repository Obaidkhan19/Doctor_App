import 'dart:io';

import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// class pdfviewconsulted extends StatefulWidget {
//   final String url;
//   final String name;
//   const pdfviewconsulted({super.key, required this.url, required this.name});

//   @override
//   State<pdfviewconsulted> createState() => _pdfviewconsultedState();
// }

// class _pdfviewconsultedState extends State<pdfviewconsulted> {
//   Future<void> refresh() async {
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           color: ColorManager.kPrimaryColor,
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: RefreshIndicator(
//         onRefresh: refresh,
//         child: Stack(
//           children: <Widget>[
//             ListView(),
//             Center(
//               child: SizedBox(
//                 height: Get.height * 0.8,
//                 width: Get.width * 1,
//                 child: SfPdfViewer.network(baseURL + widget.url),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class pdfviewconsulted extends StatefulWidget {
  final String url;
  final String name;
  const pdfviewconsulted({super.key, required this.url, required this.name});
  @override
  _pdfviewconsultedState createState() => _pdfviewconsultedState();
}

class _pdfviewconsultedState extends State<pdfviewconsulted> {
  String urlPDFPath = "";
  bool exists = true;
  final int _totalPages = 0;
  final int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController? _pdfViewController;
  bool loaded = false;
  Future<File> getFileFromUrl(String url, {name}) async {
    var fileName = '$name';
    if (name != null) {
      fileName = name;
    }
    try {
      var data = await http.get(Uri.parse(url));
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$fileName.pdf");
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  requestPersmission() async {
    Permission permission = Permission.storage;
    if (await permission.isGranted) {
    } else if (await permission.isDenied) {
      await permission.request();
    } else if (await permission.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  void initState() {
    requestPersmission();
    getFileFromUrl(
      baseURL + widget.url,
      name: widget.name,
    ).then(
      (value) => {
        setState(() {
          urlPDFPath = value.path;
          loaded = true;
          exists = true;
        })
      },
    );
    super.initState();
  }

  Future<void> refreshscreen() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (loaded) {
      return Scaffold(
        // appBar: AppBar(
        //   title: Text(
        //     widget.name,
        //     style: GoogleFonts.poppins(
        //       textStyle: GoogleFonts.poppins(
        //           fontSize: 17,
        //           fontWeight: FontWeight.w600,
        //           color: ColorManager.kPrimaryColor),
        //     ),
        //   ),
        //   leading: IconButton(
        //     icon: const Icon(Icons.arrow_back_ios),
        //     color: ColorManager.kPrimaryColor,
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ),

        body: RefreshIndicator(
            onRefresh: refreshscreen,
            child: Stack(
              children: [
                ListView(),
                Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.08,
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          color: ColorManager.kPrimaryColor,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Center(
                          child: Text(
                            widget.name,
                            style: GoogleFonts.poppins(
                              textStyle: GoogleFonts.poppins(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: ColorManager.kPrimaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SfPdfViewer.network(baseURL + widget.url),
                    ),
                  ],
                ),
              ],
            )),
        // floatingActionButton: Row(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: <Widget>[
        //     IconButton(
        //       icon: const Icon(Icons.chevron_left),
        //       iconSize: 50,
        //       color: Colors.black,
        //       onPressed: () {
        //         setState(() {
        //           if (_currentPage > 0) {
        //             _currentPage--;
        //             _pdfViewController?.setPage(_currentPage);
        //           }
        //         });
        //       },
        //     ),
        //     Text(
        //       "${_currentPage + 1}/$_totalPages",
        //       style: const TextStyle(color: Colors.black, fontSize: 20),
        //     ),
        //     IconButton(
        //       icon: const Icon(Icons.chevron_right),
        //       iconSize: 50,
        //       color: Colors.black,
        //       onPressed: () {
        //         setState(() {
        //           if (_currentPage < _totalPages - 1) {
        //             _currentPage++;
        //             _pdfViewController?.setPage(_currentPage);
        //           }
        //         });
        //       },
        //     ),
        //   ],
        // ),
      );
    } else {
      if (exists) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.name,
              style: GoogleFonts.poppins(
                textStyle: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.kPrimaryColor),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: ColorManager.kPrimaryColor,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        //Replace Error UI
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.name,
              style: GoogleFonts.poppins(
                textStyle: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.kPrimaryColor),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: ColorManager.kPrimaryColor,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: const Text(
            "PDF Not Available",
            style: TextStyle(fontSize: 20),
          ),
        );
      }
    }
  }
}
