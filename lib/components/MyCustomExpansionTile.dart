import 'package:doctormobileapplication/helpers/color_manager.dart';
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
    return InkWell(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
          widget.onExpansionChanged(_isExpanded);
        });
      },
      child: SizedBox(
        width: Get.width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.01),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.title,
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: !_isExpanded,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: Get.width * 0.3,
                          height: Get.height * 0.006,
                          decoration: BoxDecoration(
                            color: ColorManager.kblackColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (_isExpanded) ...widget.children,
            SizedBox(height: Get.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: _isExpanded,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: Get.width * 0.3,
                      height: Get.height * 0.006,
                      decoration: BoxDecoration(
                        color: ColorManager.kblackColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.01),
          ],
        ),
      ),
    );
  }
}
