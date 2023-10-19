import 'package:flutter/material.dart';
import 'package:doctormobileapplication/helpers/values_manager.dart';

import '../helpers/color_manager.dart';

class DotsIndicatorRow extends StatelessWidget {
  final int? length;
  final Color? activeColor;
  final Color? inactiveColor;
  const DotsIndicatorRow({
    Key? key,
    required this.pageIndex,
    this.activeColor = ColorManager.kblackColor,
    this.inactiveColor = ColorManager.kGreyColor,
    this.length = 4,
  }) : super(key: key);

  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
            length!,
            (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 5, left: 5),
                  child: DotsIndicator(
                    isActive: index == pageIndex,
                    activeColor: activeColor,
                    inactiveColor: inactiveColor,
                  ),
                ))
      ],
    );
  }
}

class DotsIndicator extends StatefulWidget {
  final Color? activeColor;
  final Color? inactiveColor;
  final bool isActive;
  const DotsIndicator({
    required this.isActive,
    Key? key,
    this.activeColor = ColorManager.kblackColor,
    this.inactiveColor = ColorManager.kGreyColor,
  }) : super(key: key);

  @override
  State<DotsIndicator> createState() => _DotsIndicatorState();
}

class _DotsIndicatorState extends State<DotsIndicator> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 3),
      child: Align(
          alignment: Alignment.bottomCenter,
          child: widget.isActive == true
              ? AnimatedContainer(
                  decoration: BoxDecoration(
                      color: widget.activeColor,
                      borderRadius: BorderRadius.circular(AppSize.s20)),
                  duration: const Duration(milliseconds: 3000),
                  height: 6,
                  width: 15,
                )
              : CircleAvatar(
                  radius: 4,
                  backgroundColor: widget.inactiveColor,
                )),
    );
  }
}
