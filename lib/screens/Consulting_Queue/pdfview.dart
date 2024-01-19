import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:animated_icon/animate_icon.dart';
import 'package:animated_icon/animate_icons.dart';
import 'package:doctormobileapplication/components/custom_refresh_indicator.dart';
import 'package:doctormobileapplication/data/controller/auth_controller.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class pdfviewconsulted extends StatefulWidget {
  final String url;
  final String name;
  const pdfviewconsulted({super.key, required this.url, required this.name});
  @override
  _pdfviewconsultedState createState() => _pdfviewconsultedState();
}

class _pdfviewconsultedState extends State<pdfviewconsulted>
    with TickerProviderStateMixin {
  String urlPDFPath = "";
  bool exists = true;
  bool pdfReady = false;
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

  bool isDownloaded = false;
  bool isdownloading = false;
  File? filePath;
  Future<File> downloadFile() async {
    log(widget.url.toString());
    var httpClient = HttpClient();
    try {
      var request =
          await httpClient.getUrl(Uri.parse('$baseURL/${widget.url}'));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      Directory? dir;
      if (Platform.isAndroid) {
        dir = await getDownloadsDirectory();
      }
      if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory();
      }
      log(dir!.path.toString());
      File file = File('${dir.path}/${widget.url.split('/').last}.pdf');
      await file.writeAsBytes(bytes);
      filePath = file;

      isDownloaded = true;
      Fluttertoast.showToast(
          msg: "File Downlaoded".tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kPrimaryColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      setState(() {});
      return file;
    } catch (error) {
      isDownloaded = false;
      Fluttertoast.showToast(
          msg: "Error Downloading File".tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);

      return File('');
    }
  }

  shareFile() async {
    final result = await Share.shareXFiles(
      [XFile(filePath!.path)],
    );

    if (result.status == ShareResultStatus.success) {
      Fluttertoast.showToast(
          msg: "Thank you for sharing the picture!".tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kPrimaryColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loaded) {
      return Scaffold(
        body: MyCustomRefreshIndicator(
            onRefresh: refreshscreen,
            child: Stack(
              children: [
                ListView(),
                Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.08,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios),
                            color: ColorManager.kPrimaryColor,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          isDownloaded == false
                              ? AnimateIcon(
                                  key: UniqueKey(),
                                  onTap: () async {
                                    isdownloading = true;

                                    await downloadFile();

                                    isdownloading = false;
                                    setState(() {});
                                  },
                                  iconType: isdownloading
                                      ? IconType.continueAnimation
                                      : IconType.toggleIcon,
                                  height: 50,
                                  width: 50,
                                  color: ColorManager.kPrimaryColor,
                                  animateIcon: AnimateIcons.cloud,
                                )
                              : IconButton(
                                  icon: const Icon(Icons.share),
                                  color: ColorManager.kPrimaryColor,
                                  onPressed: () {
                                    shareFile();
                                  },
                                ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SfPdfViewer.network(baseURL + widget.url),
                    ),
                  ],
                ),
              ],
            )),
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
