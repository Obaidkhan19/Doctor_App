import 'package:doctormobileapplication/data/controller/erx_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../helpers/color_manager.dart';

class CustomFormField2 extends StatefulWidget {
  final bool? obscureText;
  final List<TextInputFormatter>? formatters;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final String? hintText;
  final bool? readOnly;
  final int? lines;
  Function(String?)? onchange;
  final bool? focusnode;
  final FocusNode? focusNode;
  CustomFormField2(
      {super.key,
      this.hintText,
      this.lines,
      this.suffixIcon,
      this.controller,
      this.validator,
      this.readOnly,
      this.formatters,
      this.obscureText,
      this.onchange,
      this.focusnode,
      this.focusNode});

  @override
  State<CustomFormField2> createState() => _CustomFormField2State();
}

class _CustomFormField2State extends State<CustomFormField2> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      onChanged: widget.onchange,
      obscureText: widget.obscureText ?? false,
      inputFormatters: widget.formatters,
      maxLines: widget.lines,
      readOnly: widget.readOnly ?? false,
      validator: widget.validator,
      controller: widget.controller,
      autofocus: widget.focusnode ?? false,
      decoration: InputDecoration(
          errorStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: ColorManager.kRedColor, fontSize: 12),
          suffixIcon: widget.suffixIcon,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintText: widget.hintText,
          hintStyle:
              const TextStyle(color: ColorManager.kGreyColor, fontSize: 12),
          disabledBorder: const OutlineInputBorder(),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.kRedColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: ColorManager.kblackColor)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.kGreyColor))),
    );
  }
}

class CustomFormFieldNotes extends StatefulWidget {
  final bool? obscureText;
  final List<TextInputFormatter>? formatters;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final String? hintText;
  final bool? readOnly;
  final int? lines;
  Function(String?)? onchange;
  final bool? focusnode;
  final FocusNode? focusNode;
  CustomFormFieldNotes({
    super.key,
    this.hintText,
    this.lines,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.readOnly,
    this.formatters,
    this.obscureText,
    this.onchange,
    this.focusnode,
    this.focusNode,
  });

  @override
  State<CustomFormFieldNotes> createState() => _CustomFormFieldNotesState();
}

class _CustomFormFieldNotesState extends State<CustomFormFieldNotes> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      onChanged: widget.onchange,
      obscureText: widget.obscureText ?? false,
      inputFormatters: widget.formatters,
      maxLines: widget.lines,
      readOnly: widget.readOnly ?? false,
      validator: widget.validator,
      controller: widget.controller,
      autofocus: widget.focusnode ?? false,
      decoration: InputDecoration(
          errorStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: ColorManager.kRedColor, fontSize: 12),
          suffixIcon: widget.suffixIcon,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: ColorManager.kGreyColor,
            fontSize: 12,
            height: Get.height * 0.005,
          ),
          disabledBorder: const OutlineInputBorder(),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.kRedColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: ColorManager.kGreyColor)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.kGreyColor))),
    );
  }
}

class CustomFormField extends StatefulWidget {
  final bool? obscureText;
  final List<TextInputFormatter>? formatters;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final String? hintText;
  final bool? readOnly;
  final int? lines;
  Function(String?)? onchange;
  final bool? focusnode;
  final FocusNode? focusNode;
  CustomFormField({
    super.key,
    this.hintText,
    this.lines,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.readOnly,
    this.formatters,
    this.obscureText,
    this.onchange,
    this.focusnode,
    this.focusNode,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      onChanged: widget.onchange,
      obscureText: widget.obscureText ?? false,
      inputFormatters: widget.formatters,
      maxLines: widget.lines,
      readOnly: widget.readOnly ?? false,
      validator: widget.validator,
      controller: widget.controller,
      autofocus: widget.focusnode ?? false,
      decoration: InputDecoration(
          errorStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: ColorManager.kRedColor, fontSize: 12),
          suffixIcon: widget.suffixIcon,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintText: widget.hintText,
          hintStyle:
              const TextStyle(color: ColorManager.kGreyColor, fontSize: 12),
          disabledBorder: const OutlineInputBorder(),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.kRedColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: ColorManager.kGreyColor)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.kGreyColor))),
    );
  }
}

class CustomFormField1 extends StatefulWidget {
  final bool? obscureText;
  final List<TextInputFormatter>? formatters;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final String? hintText;
  final bool? readOnly;
  Function(String?)? onchange;
  final bool? focusnode;
  final FocusNode? focusNode;
  CustomFormField1({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.readOnly,
    this.formatters,
    this.obscureText,
    this.onchange,
    this.focusnode,
    this.focusNode,
  });

  @override
  State<CustomFormField1> createState() => _CustomFormField1State();
}

class _CustomFormField1State extends State<CustomFormField1> {
  @override
  final ERXController controller = Get.put(ERXController());

  @override
  Widget build(BuildContext context) {
    //  String focuse = widget.focus1!;
    return TextFormField(
      focusNode: widget.focusNode,
      onChanged: widget.onchange,
      obscureText: widget.obscureText ?? false,
      inputFormatters: widget.formatters,
      readOnly: widget.readOnly ?? false,
      validator: widget.validator,
      controller: widget.controller,
      autofocus: widget.focusnode ?? false,
      decoration: InputDecoration(
          filled: true,
          fillColor: ColorManager.kPrimaryLightColor,
          errorStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: ColorManager.kRedColor, fontSize: 12),
          suffixIcon: widget.suffixIcon,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
              color: ColorManager.kPrimaryLightColor, fontSize: 12),
          disabledBorder: const OutlineInputBorder(),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.kRedColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: ColorManager.kPrimaryLightColor)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.kPrimaryLightColor))),
    );
  }
}
