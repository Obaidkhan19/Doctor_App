import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../helpers/color_manager.dart';
import '../../helpers/font_manager.dart';
import '../../utils/AppImages.dart';

class CustomDialog_DatePicker extends StatefulWidget {
  DateTime dateTime;
  TextEditingController controller;
  final VoidCallback? onPressed;

  CustomDialog_DatePicker({super.key, 
    required this.dateTime,
    required this.controller,
    this.onPressed,
  });

  @override
  State<CustomDialog_DatePicker> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog_DatePicker> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
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
                    'Appointment Reschedule',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.020,
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
                      width: 20,
                      height: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.065,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                child: CupertinoTextField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: DateFormat('yyyy-MM-dd').format(widget.dateTime),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                        //     color: Colors.black,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent),
                  prefix: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.04),
                    child: const Icon(
                        Icons
                            .calendar_month, // You can replace this with your desired icon
                        color: CupertinoColors.black),
                  ),
                  style: const TextStyle(
                    fontSize: 18,
                    color: CupertinoColors.black,
                  ),
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) => Center(
                        child: SizedBox(
                          height: 200,
                          child: CupertinoDatePicker(
                            backgroundColor: Colors.white,
                            initialDateTime: widget.dateTime,
                            onDateTimeChanged: (DateTime newTime) {
                              widget.controller.text = DateFormat('yyyy-MM-dd')
                                  .format(newTime)
                                  .toString();
                              setState(() => widget.dateTime = newTime);
                            },
                            use24hFormat: true,
                            mode: CupertinoDatePickerMode.date,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Navigator.of(context).pop();
              InkWell(
                onTap: widget.onPressed,
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
                        'Ok',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            color: ColorManager.kWhiteColor,
                            fontWeight: FontWeightManager.bold),
                      ))),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
