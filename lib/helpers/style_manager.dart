// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:doctormobileapplication/helpers/font_manager.dart';

TextStyle _getTextStyle(
    double fontSize, String fontFamily, Color color, FontWeight fontWeight) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      fontWeight: fontWeight);
}

// regular style
TextStyle getRegularStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, color, FontWeightManager.regular);
}

TextStyle getLightTextStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, color, FontWeightManager.light);
}

TextStyle getBoldTextStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, color, FontWeightManager.bold);
}

TextStyle getMediumStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, color, FontWeightManager.medium);
}

TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, color, FontWeightManager.semiBold);
}
