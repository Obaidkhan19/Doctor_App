// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final int? maxlines;
  final Widget? prefixIcon;
  final TextStyle? suffixStyle;
  final String? suffixText;
  final bool? isSizedBoxAvailable;
  final bool readonly;
  final Color? fillColor;
  final Widget? suffixIcon;
  final String? hintText;
  final Function(String)? onchanged;
  const CustomTextField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.fillColor = ColorManager.kPrimaryLightColor,
    this.readonly = false,
    this.isSizedBoxAvailable = true,
    this.suffixText,
    this.suffixStyle,
    this.prefixIcon,
    this.maxlines,
    this.padding,
    this.onTap,
    this.validator,
    this.inputFormatters,
    this.onchanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextFormField(
          controller: controller,
          onChanged: onchanged,
          validator: validator,
          onTap: onTap ?? () {},
          maxLines: maxlines ?? 1,
          readOnly: readonly,
          style: const TextStyle(
            color: ColorManager.kPrimaryColor,
          ),
          decoration: InputDecoration(
            contentPadding: padding ?? EdgeInsets.symmetric(horizontal: 20),
            hintStyle: const TextStyle(color: ColorManager.kPrimaryColor),
            hintText: hintText,
            filled: true,
            disabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: ColorManager.kPrimaryLightColor),
                borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(color: ColorManager.kPrimaryLightColor),
            ),
            fillColor: ColorManager.kPrimaryLightColor,
            suffixIcon: suffixIcon,
            suffixText: suffixText,
            suffixStyle: suffixStyle,
            prefixIcon: prefixIcon,
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.kPrimaryLightColor),
              borderRadius: BorderRadius.all(
                Radius.circular(0.0),
              ),
            ),
          ),
          inputFormatters: inputFormatters,
        ),
        isSizedBoxAvailable == true
            ? SizedBox(
                height: Get.height * 0.02,
              )
            : SizedBox.shrink()
      ],
    );
  }
}

class RegisterCustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final int? maxlines;
  final Widget? prefixIcon;
  final TextStyle? suffixStyle;
  final String? suffixText;
  final bool? isSizedBoxAvailable;
  final bool readonly;
  final Color? fillColor;
  final Widget? suffixIcon;
  final String? hintText;
  final Function(String)? onchanged;
  const RegisterCustomTextField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.fillColor = ColorManager.kPrimaryLightColor,
    this.readonly = false,
    this.isSizedBoxAvailable = true,
    this.suffixText,
    this.suffixStyle,
    this.prefixIcon,
    this.maxlines,
    this.padding,
    this.onTap,
    this.validator,
    this.inputFormatters,
    this.onchanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextFormField(
          controller: controller,
          onChanged: onchanged,
          validator: validator,
          onTap: onTap ?? () {},
          maxLines: maxlines ?? 1,
          readOnly: readonly,
          style: TextStyle(color: ColorManager.kblackColor, fontSize: 12),
          decoration: InputDecoration(
            contentPadding: padding ?? EdgeInsets.symmetric(horizontal: 20),
            hintStyle: const TextStyle(color: ColorManager.kGreyColor),
            hintText: hintText,
            filled: true,
            disabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            // focusedBorder: OutlineInputBorder(
            //     borderSide: const BorderSide(color: ColorManager.kPrimaryColor),
            //     borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: ColorManager.kGreyColor),
            ),
            fillColor: ColorManager.kWhiteColor,
            suffixIcon: suffixIcon,
            suffixText: suffixText,
            suffixStyle: suffixStyle,
            prefixIcon: prefixIcon,
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.kPrimaryLightColor),
              borderRadius: BorderRadius.all(
                Radius.circular(0.0),
              ),
            ),
          ),
          inputFormatters: inputFormatters,
        ),
        isSizedBoxAvailable == true
            ? SizedBox(
                height: Get.height * 0.02,
              )
            : SizedBox.shrink()
      ],
    );
  }
}

class EditProfileCustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final int? maxlines;
  final Widget? prefixIcon;
  final TextStyle? suffixStyle;
  final String? suffixText;
  final bool? isSizedBoxAvailable;
  final bool readonly;
  final Color? fillColor;
  final Widget? suffixIcon;
  final String? hintText;
  final Function(String)? onchanged;
  const EditProfileCustomTextField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.fillColor = ColorManager.kPrimaryLightColor,
    this.readonly = false,
    this.isSizedBoxAvailable = true,
    this.suffixText,
    this.suffixStyle,
    this.prefixIcon,
    this.maxlines,
    this.padding,
    this.onTap,
    this.validator,
    this.inputFormatters,
    this.onchanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextFormField(
          controller: controller,
          onChanged: onchanged,
          validator: validator,
          onTap: onTap ?? () {},
          maxLines: maxlines ?? 1,
          readOnly: readonly,
          style: const TextStyle(
              color: ColorManager.kPrimaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w700),
          decoration: InputDecoration(
            contentPadding: padding ?? EdgeInsets.symmetric(horizontal: 20),
            hintStyle: const TextStyle(
                fontSize: 12,
                color: ColorManager.kPrimaryColor,
                fontWeight: FontWeight.w700),
            hintText: hintText,
            filled: true,
            disabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: ColorManager.kPrimaryLightColor),
                borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(color: ColorManager.kPrimaryLightColor),
            ),
            fillColor: ColorManager.kPrimaryLightColor,
            suffixIcon: suffixIcon,
            suffixText: suffixText,
            suffixStyle: suffixStyle,
            prefixIcon: prefixIcon,
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.kPrimaryLightColor),
              borderRadius: BorderRadius.all(
                Radius.circular(0.0),
              ),
            ),
          ),
          inputFormatters: inputFormatters,
        ),
        isSizedBoxAvailable == true
            ? SizedBox(
                height: Get.height * 0.02,
              )
            : SizedBox.shrink()
      ],
    );
  }
}

class EditProfileNumberCustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final int? maxlines;
  final Widget? prefixIcon;
  final TextStyle? suffixStyle;
  final String? suffixText;
  final bool? isSizedBoxAvailable;
  final bool readonly;
  final Color? fillColor;
  final Widget? suffixIcon;
  final String? hintText;
  final Function(String)? onchanged;
  const EditProfileNumberCustomTextField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.fillColor = ColorManager.kPrimaryLightColor,
    this.readonly = false,
    this.isSizedBoxAvailable = true,
    this.suffixText,
    this.suffixStyle,
    this.prefixIcon,
    this.maxlines,
    this.padding,
    this.onTap,
    this.validator,
    this.inputFormatters,
    this.onchanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextFormField(
          controller: controller,
          onChanged: onchanged,
          validator: validator,
          keyboardType: TextInputType.number,
          onTap: () {},
          maxLines: maxlines ?? 1,
          readOnly: readonly,
          style: const TextStyle(
              color: ColorManager.kPrimaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w700),
          decoration: InputDecoration(
            contentPadding: padding ?? EdgeInsets.symmetric(horizontal: 20),
            hintStyle: const TextStyle(
                fontSize: 12,
                color: ColorManager.kPrimaryColor,
                fontWeight: FontWeight.w700),
            hintText: hintText,
            filled: true,
            disabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: ColorManager.kPrimaryLightColor),
                borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(color: ColorManager.kPrimaryLightColor),
            ),
            fillColor: ColorManager.kPrimaryLightColor,
            suffixIcon: suffixIcon,
            suffixText: suffixText,
            suffixStyle: suffixStyle,
            prefixIcon: prefixIcon,
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.kPrimaryLightColor),
              borderRadius: BorderRadius.all(
                Radius.circular(0.0),
              ),
            ),
          ),
          inputFormatters: inputFormatters,
        ),
        isSizedBoxAvailable == true
            ? SizedBox(
                height: Get.height * 0.02,
              )
            : SizedBox.shrink()
      ],
    );
  }
}
