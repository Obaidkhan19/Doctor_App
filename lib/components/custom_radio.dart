import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRadioTile extends StatelessWidget {
  final String title;
  final String? value;
  final String? groupValue;
  final ValueChanged<String?>? onChanged;

  const CustomRadioTile({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged?.call(value);
      },
      child: Row(
        children: [
          Radio<String>(
            value: value!,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: ColorManager.kPrimaryColor,
            // overlayColor: ColorManager.kPrimaryColor,
          ),
          SizedBox(
            width: Get.width * 0.2,
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: GoogleFonts.poppins(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
