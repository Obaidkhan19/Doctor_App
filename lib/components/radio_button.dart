// ignore_for_file: library_private_types_in_public_api


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctormobileapplication/data/controller/lab_investigations_controller.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';

int? selectedValue;

class RadioButtonRow extends StatefulWidget {
  const RadioButtonRow({super.key});

  @override
  _RadioButtonRowState createState() => _RadioButtonRowState();
}

class _RadioButtonRowState extends State<RadioButtonRow> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LabInvestigationController>(builder: (cont) {
      return SizedBox(
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Radio<int>(
              fillColor: MaterialStateProperty.all(ColorManager.kPrimaryColor),
              value: 0,
              groupValue: cont.selectedalue,
              onChanged: (value) {
                cont.updateSelectedValue(value!);
                cont.updateSummaryWidgets();
              },
            ),
            Text(
              'Self',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: ColorManager.kPrimaryColor,
                  fontSize: 12),
            ),
            Radio<int>(
              fillColor: MaterialStateProperty.all(ColorManager.kPrimaryColor),
              value: 1,
              groupValue: cont.selectedalue,
              onChanged: (value) {
                cont.updateSelectedValue(value!);
                cont.updateSummaryWidgets();
              },
            ),
            Text(
              'Doctor',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: ColorManager.kPrimaryColor,
                  fontSize: 12),
            ),
            Radio<int>(
              fillColor: MaterialStateProperty.all(ColorManager.kPrimaryColor),
              value: 2,
              groupValue: cont.selectedalue,
              onChanged: (value) {
                cont.updateSelectedValue(value!);
                cont.updateSummaryWidgets();
              },
            ),
            FittedBox(
              child: Text(
                'OutDoor Doctor',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    color: ColorManager.kPrimaryColor,
                    fontSize: 12),
              ),
            ),
          ],
        ),
      );
    });
  }
}
