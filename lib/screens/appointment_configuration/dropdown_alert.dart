import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAlertDropDownWidget extends StatefulWidget {
  List<String> list;
  String selected;
  String hinttext;
  CustomAlertDropDownWidget(
      {required this.list,
      required this.selected,
      required this.hinttext,
      Key? key})
      : super(key: key);

  @override
  State<CustomAlertDropDownWidget> createState() =>
      _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends State<CustomAlertDropDownWidget> {
  bool isExpanded = false;

  List<String> get remainingOptions =>
      widget.list.where((e) => e != widget.selected).toList();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Get.width * 1,
          height: Get.height * 0.05,
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorManager.kPrimaryColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(
                15.0), // Adjust the border radius as needed
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
            child: InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  isExpanded = !isExpanded;
                  setState(() {});
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.selected.isNotEmpty
                            ? widget.selected
                            : widget.hinttext,
                        style: const TextStyle(
                            color: ColorManager.kblackColor, fontSize: 10),
                      ),
                    ),
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: ColorManager.kblackColor,
                    )
                  ],
                )),
          ),
        ),
        if (isExpanded)
          // SizedBox(
          //   height: Get.height * 0.1,
          //   child: SingleChildScrollView(
          //     child: Column(
          //       children: widget.list
          //           .map(
          //             (e) => InkWell(
          //               onTap: () {
          //                 isExpanded = false;
          //                 widget.selected = e;
          //                 setState(() {});
          //               },
          //               child: Center(
          //                 child: Text(
          //                   e.toString(),
          //                   style: const TextStyle(
          //                     color: ColorManager.kblackColor,
          //                     fontSize: 10,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           )
          //           .toList(),
          //     ),
          //   ),
          // )
          Container(
            child: SingleChildScrollView(
              child: Column(
                children: widget.list
                    .map(
                      (e) => InkWell(
                        onTap: () {
                          setState(() {
                            isExpanded =
                                false; // Close dropdown on item selection
                            widget.selected = e;
                          });
                        },
                        child: Center(
                          child: Text(
                            e.toString(),
                            style: const TextStyle(
                              color: ColorManager.kblackColor,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          )
      ],
    );
  }
}
