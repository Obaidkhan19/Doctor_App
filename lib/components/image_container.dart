import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageContainer extends StatelessWidget {
  final bool? isNetworkImage;
  final Function()? onpressed;
  final bool? isSvg;
  final Color? color;
  final Color? backgroundColor;
  final String? imagePath;
  const ImageContainer({
    super.key,
    this.imagePath,
    this.color,
    this.backgroundColor,
    this.isSvg = true,
    this.onpressed,
    this.isNetworkImage,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: backgroundColor),
        child: IconButton(
          onPressed: onpressed,
          icon: isSvg == true
              ? SvgPicture.asset(
                  imagePath ?? Images.addicon,
                  color: backgroundColor ?? ColorManager.kPrimaryColor,
                )
              : isNetworkImage == true
                  ? Image.network(
                      imagePath!,
                      color: color ?? ColorManager.kWhiteColor,
                    )
                  : Image.asset(
                      imagePath ?? Images.addicon,
                      color: color ?? ColorManager.kPrimaryColor,
                    ),
        ));
  }
}
