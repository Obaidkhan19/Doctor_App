import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomExpansionTile extends StatefulWidget {
  final Widget title;
  final List<Widget> children;
  final bool initiallyExpanded;
  final ValueChanged<bool> onExpansionChanged;
  final IconData trailingIcon;

  const CustomExpansionTile({
    super.key,
    required this.title,
    required this.children,
    this.initiallyExpanded = false,
    required this.onExpansionChanged,
    this.trailingIcon = Icons.keyboard_arrow_down,
  });

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Get.height * 0.01),
        InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
              widget.onExpansionChanged(_isExpanded);
            });
          },
          child: Padding(
            padding: EdgeInsets.only(right: Get.width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.title,
                Icon(
                  _isExpanded ? Icons.keyboard_arrow_up : widget.trailingIcon,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded) ...widget.children,
        SizedBox(height: Get.height * 0.01),
      ],
    );
  }
}
