import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helpers/font_manager.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final String? footer;
  final VoidCallback? onClosePressed;

  const CustomDialog({
    super.key,
    required this.title,
    required this.content,
    this.footer,
    this.onClosePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3), // Shadow color
                    spreadRadius: 1, // Spread radius of the shadow
                    blurRadius: 1, // Blur radius of the shadow
                    offset: const Offset(0, 1), // Offset of the shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        //fontSize: MediaQuery.of(context).size.height * 0.023,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Image.asset(
                        AppImages.cross,
                        width: 25,
                        height: 25,
                      ),
                    ),
                  )
                ],
              ),
            ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  content,
                  style: GoogleFonts.poppins(fontSize: 12
                      // fontSize: MediaQuery.of(context).size.height * 0.018
                      ),
                ),
              ),
            ),
          ),
          if (footer != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Navigator.of(context).pop();
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: MediaQuery.of(context).size.height * 0.045,
                        decoration: BoxDecoration(
                          color: const Color(
                              0xfff1272d3), // Set the background color of the container
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                            child: Text(
                          'ok'.tr,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 13,
                              // fontSize:
                              //     MediaQuery.of(context).size.width * 0.035,
                              color: ColorManager.kWhiteColor,
                              fontWeight: FontWeightManager.bold),
                        ))),
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}
