import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
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
        // floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        // floatingActionButton: IconButton(onPressed: (){},icon: Icon(Icons.arrow_back_ios_new),),
        appBar: AppBar(
          leading: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Get.back();
            },
            child: Image.asset(
              AppImages.back,
              color: ColorManager.kPrimaryColor,
            ),
          ),
        ),
        body: Center(
          child: SizedBox(
            height: Get.height * 0.8,
            width: Get.width * 1,
            child: SfPdfViewer.network(AppConstants.baseURL + url),
          ),
        ));
  }
}
