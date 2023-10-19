import 'package:doctormobileapplication/data/controller/configure_appointment_controller.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomDropDownWidget extends StatefulWidget {
  List<String> list;
  String selected;
  CustomDropDownWidget({required this.list, required this.selected, Key? key})
      : super(key: key);

  @override
  State<CustomDropDownWidget> createState() => _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends State<CustomDropDownWidget> {
  bool isExpanded = false;
  var contr =
      Get.put<ConfigureAppointmentController>(ConfigureAppointmentController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Get.width * 1,
          height: Get.height * 0.06,
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
                        widget.selected,
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
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: widget.list
                .map((e) => InkWell(
                      onTap: () {
                        isExpanded = false;
                        widget.selected = e;
                        setState(() {});
                      },
                      child: Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: widget.selected == e
                                ? ColorManager.kPrimaryColor
                                : Colors.grey.shade300,
                          ),
                          child: Center(
                              child: Text(
                            e.toString(),
                            style: const TextStyle(
                                color: ColorManager.kblackColor, fontSize: 10),
                          ))),
                    ))
                .toList(),
          )
      ],
    );
  }
}
