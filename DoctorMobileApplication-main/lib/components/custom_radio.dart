import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:flutter/material.dart';

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
          Text(
            title,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
