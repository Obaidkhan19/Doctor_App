import 'package:doctormobileapplication/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class pdfviewconsulted extends StatelessWidget {
  final String url;
  const pdfviewconsulted({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: IconButton(onPressed: (){
        Get.back();
      },icon: const Icon(Icons.arrow_back_ios_new),),
        body: Center(
          child: SizedBox(
              height: Get.height * 0.8,
              width: Get.width * 1,
              child: SfPdfViewer.network(AppConstants.baseURL + url),
            ),
        ));
  }
}
