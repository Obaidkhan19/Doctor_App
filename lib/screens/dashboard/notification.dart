import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:doctormobileapplication/components/custom_refresh_indicator.dart';
import 'package:doctormobileapplication/data/controller/notification_controller.dart';
import 'package:doctormobileapplication/data/repositories/notification_repo/notifications_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  TextEditingController SearchFieldController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int length = 10;

  String Status = "";
  final dateFormat = DateFormat('yyyy-MM-dd');
  DateTime dateTime = DateTime.now().subtract(const Duration(days: 30));
  DateTime dateTime2 = DateTime.now();

  @override
  void initState() {
    super.initState();
    callback();
  }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies4
  //   today = 1;
  //   yesterday = 1;
  //   previous = 1;
  //   setState(() {});
  //   super.didChangeDependencies();
  // }

  @override
  void dispose() {
    NotificationController.i.today = 1;
    NotificationController.i.yesterday = 1;
    NotificationController.i.previous = 1;
    super.dispose();
  }

  Future<void> callback() async {
    await NotificationController.i.updateIsloading(true);

    NotificationsRepo nr = NotificationsRepo();
    await nr.Getnotification(
      dateTime.toString().split(' ')[0],
      dateTime2.toString().split(' ')[0],
      length,
      SearchFieldController.text.isEmpty ? "" : SearchFieldController.text,
    );

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        var isCallToFetchData =
            NotificationController.i.SetStartToFetchNextData();
        if (isCallToFetchData) {
          length = length + 10;
          callback();
        }
      }
    });

    SearchFieldController.clear();

    await NotificationController.i.updateIsloading(false);
  }

  String datetime = DateTime.now().toString().split(' ')[0];
  String yesterdaydate =
      DateTime.now().subtract(const Duration(days: 1)).toString().split(' ')[0];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      builder: (cont) => Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: ColorManager.kPrimaryColor,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'notification'.tr,
              style: GoogleFonts.poppins(
                textStyle: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.kPrimaryColor),
              ),
            ),
          ),
          body: MyCustomRefreshIndicator(
            onRefresh: callback,
            child: BlurryModalProgressHUD(
              inAsyncCall: NotificationController.i.isLoading,
              blurEffectIntensity: 4,
              progressIndicator: const SpinKitSpinningLines(
                color: Color(0xfff1272d3),
                size: 60,
              ),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImages.backgroundimage),
                      alignment: Alignment.centerLeft),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.03,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                          child: NotificationController
                                  .i.notificationlist.isNotEmpty
                              ? ListView.builder(
                                  controller: _scrollController,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: NotificationController
                                      .i.notificationlist.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final data = NotificationController
                                        .i.notificationlist[index];
                                    if (datetime ==
                                        data.dateTime?.split('T')[0]) {
                                      if (NotificationController.i.today == 1) {
                                        NotificationController.i.today += 1;
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: Get.height * 0.02),
                                              child: Text(
                                                "Today".tr,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            datetimecheck(data),
                                          ],
                                        );
                                      } else {
                                        return datetimecheck(data);
                                      }
                                    } else if (yesterdaydate ==
                                        data.dateTime?.split('T')[0]) {
                                      if (NotificationController.i.yesterday ==
                                          1) {
                                        NotificationController.i.yesterday += 1;
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: Get.height * 0.02),
                                              child: Text(
                                                "Yesterday".tr,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            datetimecheck(data),
                                          ],
                                        );
                                      } else {
                                        return datetimecheck(data);
                                      }
                                    } else if (NotificationController
                                            .i.previous ==
                                        1) {
                                      NotificationController.i.previous += 1;
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: Get.height * 0.02),
                                            child: Text(
                                              "Previous".tr,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          datetimecheck(data),
                                        ],
                                      );
                                    } else {
                                      return datetimecheck(data);
                                    }
                                  })
                              : MyCustomRefreshIndicator(
                                  onRefresh: callback,
                                  child: Stack(
                                    children: <Widget>[
                                      ListView(),
                                      Center(
                                        child: Text(
                                          "NoRecordFound".tr,
                                          style:
                                              GoogleFonts.poppins(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  datetimecheck(data) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.02,
      ),
      child: Column(
        children: [
          ListTile(
            minVerticalPadding: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            tileColor: Colors.transparent,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title.toString(),
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
              ],
            ),
            subtitle: Column(
              children: [
                Text(
                  "${data.body!.split(" at ").first}\n${calculateTimeAgo(data.dateTime)}",
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xfff898989)),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String calculateTimeAgo(String? dateTimeString) {
  if (dateTimeString == null) {
    return "Unknown Date";
  }
  final dateTime = DateTime.parse(dateTimeString);
  final now = DateTime.now();
  final difference = now.difference(dateTime);
  final years = difference.inDays ~/ 365;
  final months = (difference.inDays % 365) ~/ 30;
  final days = (difference.inDays % 365) % 30;
  final hours = difference.inHours % 24;
  final minutes = difference.inMinutes % 60;
  String timeAgo = "";
  if (years > 0) {
    timeAgo = "$years year${years > 1 ? "s" : ""}";
  } else if (months > 0) {
    timeAgo = "$months month${months > 1 ? "s" : ""}";
  } else if (days > 0) {
    timeAgo = "$days day${days > 1 ? "s" : ""}";
  } else if (hours > 0) {
    timeAgo = "$hours hour${hours > 1 ? "s" : ""}";
  } else if (minutes > 0) {
    timeAgo = "$minutes minute${minutes > 1 ? "s" : ""}";
  } else {
    timeAgo = "Just now";
  }
  return "$timeAgo ago";
}
