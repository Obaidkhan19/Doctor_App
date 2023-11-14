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
  final dynamic imageheight;
  final double? boxheight;
  final double? boxwidth;
  const ImageContainer({
    super.key,
    this.imagePath,
    this.color,
    this.backgroundColor,
    this.isSvg = true,
    this.onpressed,
    this.isNetworkImage,
    this.imageheight,
    this.boxheight,
    this.boxwidth,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
        height: boxheight,
        width: boxwidth,
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
                      height: imageheight,
                      color: color ?? ColorManager.kPrimaryColor,
                    ),
        ));
  }
}

class ImageContainerNew extends StatelessWidget {
  final bool? isNetworkImage;
  final Function()? onpressed;
  final bool? isSvg;
  final Color? color;
  final Color? backgroundColor;
  final String? imagePath;
  final dynamic imageheight;
  final double? boxheight;
  final double? boxwidth;
  const ImageContainerNew({
    super.key,
    this.imagePath,
    this.color,
    this.backgroundColor,
    this.isSvg = true,
    this.onpressed,
    this.isNetworkImage,
    this.imageheight,
    this.boxheight,
    this.boxwidth,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
        height: boxheight,
        width: boxwidth,
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(5)),
        child: InkWell(
          onTap: onpressed,
          child: isSvg == true
              ? SvgPicture.asset(
                  imagePath ?? Images.addicon,
                  color: backgroundColor ?? ColorManager.kPrimaryColor,
                )
              : isNetworkImage == true
                  ? Image.network(
                      imagePath!,
                      color: color ?? ColorManager.kWhiteColor,
                    )
                  : Padding(
                      padding: const EdgeInsets.all(2),
                      child: Image.asset(
                        imagePath ?? Images.addicon,
                        height: imageheight,
                        color: color ?? ColorManager.kPrimaryColor,
                        // fit: BoxFit.fill,
                      ),
                    ),
        ));
  }
}
