import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoDataFound extends StatelessWidget {
  final String? Title;
  const NoDataFound({super.key, this.Title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Title ?? ""),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: ColorManager.kPrimaryColor,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: const Center(
        child: Text('No data found!'),
      ),
    );
  }
}
