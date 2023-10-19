import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextInputField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isObsecure;
  final IconData icon;
  final bool enable;
  final Color color;
  final double radius;

  const TextInputField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.isObsecure = false,
    required this.icon,
    this.enable = true,
    required this.color,
    required this.radius,
  }) : super(key: key);

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  late FocusNode focusNode = FocusNode()
    ..addListener(() {
      setState(() {});
    });

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: widget.enable,
      focusNode: focusNode,
      cursorColor: Colors.black,
      controller: widget.controller,
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.only(left: Get.width * 0.07, right: Get.width * 0.05),
        labelText: widget.labelText,
        labelStyle: const TextStyle(fontSize: 12, color: Colors.black),
        floatingLabelStyle: TextStyle(color: widget.color),
        suffixIcon: Icon(
          widget.icon,
          color: focusNode.hasFocus ? widget.color : Colors.black,
        ),
        fillColor: widget.color,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: BorderSide(
            color: widget.color,
          ),
        ),
      ),
      obscureText: widget.isObsecure,
    );
  }
}
