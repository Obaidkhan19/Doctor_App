import 'package:doctormobileapplication/components/Customrowdesign.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ConfigureAppointmentListTile extends StatefulWidget {
  String dayname;
  bool isOpen;
  ConfigureAppointmentListTile(
      {required this.dayname, required this.isOpen, super.key});

  @override
  State<ConfigureAppointmentListTile> createState() =>
      _ConfigureAppointmentListTileState();
}

call(cont) async {
  mycustomrow.add(configureappointrow(
    ctx: cont,
    dayindex: 0,
  ));
}

List<configureappointrow> mycustomrow = [];

class _ConfigureAppointmentListTileState
    extends State<ConfigureAppointmentListTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 1,
          color: ColorManager.kWhiteColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.dayname,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: ColorManager.kPrimaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Transform.scale(
                    scale: 0.55,
                    child: Switch(
                      value: widget.isOpen,
                      activeColor: ColorManager.kPrimaryColor,
                      onChanged: (value) {
                        setState(() {
                          widget.isOpen = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (widget.isOpen == true)
          Card(
            elevation: 1,
            color: ColorManager.kPrimaryLightColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Text(
                  "addhoursofyouravailability".tr,
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: ColorManager.kPrimaryColor,
                      fontWeight: FontWeight.w600),
                ),
                configureappointrow(
                  ctx: context,
                  dayindex: 0,
                ),
                mycustomrow.length == 1 && mycustomrow.isNotEmpty
                    ? mycustomrow.first
                    : SizedBox(
                        height: Get.height * 0.3,
                        width: Get.width * 0.9,
                        child: ListView.builder(
                            itemCount: mycustomrow.length,
                            itemBuilder: (context, index) {
                              return mycustomrow[index];
                            }),
                      ),
                InkWell(
                  onTap: () {
                    call(context);
                    setState(() {});
                  },
                  child: Text(
                    "addmorehours".tr,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: ColorManager.kblackColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
