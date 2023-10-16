import 'package:flutter/material.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/helpers/font_manager.dart';
import 'package:doctormobileapplication/helpers/style_manager.dart';
import 'package:doctormobileapplication/helpers/values_manager.dart';

class Styles {
  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      // main Colors of the app
      primaryColor: ColorManager.kPrimaryColor,
      disabledColor: ColorManager.kGreyColor,
      fontFamily: FontConstants.fontFamily,
      // card view theme
      cardTheme: const CardTheme(
          color: Colors.white,
          shadowColor: ColorManager.kGreyColor,
          elevation: AppSize.s12),
      // App bar theme
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme:
              const IconThemeData(size: 25, color: ColorManager.kblackColor),
          toolbarHeight: 80,
          centerTitle: true,
          elevation: 0,
          titleTextStyle: getRegularStyle(
            
            color: ColorManager.kPrimaryColor,
            fontSize: FontSize.s16,
            
          ).copyWith(fontWeight: FontWeight.w900)),
      // Button theme
      buttonTheme: const ButtonThemeData(
          shape: StadiumBorder(),
          disabledColor: ColorManager.kGreyColor,
          buttonColor: ColorManager.kPrimaryColor,
          splashColor: ColorManager.kGreyColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: getRegularStyle(color: ColorManager.kblackColor),
              backgroundColor: ColorManager.kPrimaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12)))),

      // Text theme
      textTheme: TextTheme(
          titleLarge: getSemiBoldStyle(
              color: ColorManager.kPrimaryColor, fontSize: FontSize.s20),
          titleMedium: getMediumStyle(
              color: ColorManager.kGreyColor, fontSize: FontSize.s14),
          titleSmall: getRegularStyle(color: ColorManager.kGreyColor),
          bodySmall: getRegularStyle(
              color: ColorManager.kblackColor, fontSize: FontSize.s14),
          bodyMedium: getRegularStyle(
              color: ColorManager.kblackColor, fontSize: FontSize.s16),
          bodyLarge: getRegularStyle(
              color: ColorManager.kblackColor, fontSize: FontSize.s16)),

      // input decoration theme (text form field)
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(AppPadding.p8),
          hintStyle: getRegularStyle(color: ColorManager.kGreyColor),
          labelStyle: getMediumStyle(color: ColorManager.kGreyColor),
          errorStyle: getRegularStyle(color: ColorManager.kGreyColor),
          enabledBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.kGreyColor, width: AppSize.s8),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorManager.kPrimaryColor, width: AppSize.s1_5)),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorManager.kPrimaryColor, width: AppSize.s1_5))));
}
