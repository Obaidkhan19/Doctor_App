import 'package:doctormobileapplication/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class pdfviewconsulted extends StatelessWidget {
  final String url;
  const pdfviewconsulted({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        body: Container(
          height: Get.height * 1,
          decoration: const BoxDecoration(color: Colors.white),
          child: SizedBox(
            height: Get.height * 1,
            width: Get.width * 1,
            child: SfPdfViewer.network(AppConstants.baseURL + url),
          ),
        ));
  }
}
