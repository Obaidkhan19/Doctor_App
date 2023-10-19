import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCustomTile extends StatefulWidget {
  final Widget title;
  final List<Widget> children;
  final bool initiallyExpanded;
  final ValueChanged<bool> onExpansionChanged;

  const MyCustomTile({
    super.key,
    required this.title,
    required this.children,
    this.initiallyExpanded = false,
    required this.onExpansionChanged,
  });

  @override
  _MyCustomTileState createState() => _MyCustomTileState();
}

class _MyCustomTileState extends State<MyCustomTile> {
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
