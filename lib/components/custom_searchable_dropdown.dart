import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/lab_test_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDropdown {
  searchabledropdown(BuildContext context, List<LabTests> list) async {
    TextEditingController search = TextEditingController();
    List<LabTests> selectedItems = [];
    String title = "";

    await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              width: Get.width,
              height: MediaQuery.of(context).size.height * 0.7,
              child: AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.w900,
                              color: ColorManager.kPrimaryColor),
                          hintText: 'Search',
                          filled: true,
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: ColorManager.kPrimaryLightColor),
                              borderRadius: BorderRadius.circular(8)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: ColorManager.kPrimaryLightColor),
                          ),
                          fillColor: ColorManager.kPrimaryLightColor,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: ColorManager.kPrimaryColor,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorManager.kPrimaryLightColor),
                            borderRadius: BorderRadius.all(
                              Radius.circular(0.0),
                            ),
                          ),
                        ),
                        controller: search,
                        onChanged: (val) {
                          title = val;
                          setState(() {
                            title = val;
                          });
                        },
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: ListView.builder(
                          itemCount: list.length,
                          itemBuilder: ((context, index) {
                            if (search.text.isEmpty ||
                                list[index]
                                    .name!
                                    .toLowerCase()
                                    .contains(title.toLowerCase())) {
                              return ListTile(
                                contentPadding: const EdgeInsets.only(left: 0),
                                title: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Checkbox(
                                      value:
                                          selectedItems.contains(list[index]),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value != null && value) {
                                            selectedItems.add(list[index]);
                                          } else {
                                            selectedItems.remove(list[index]);
                                          }
                                        });
                                      },
                                    ),
                                    Text(list[index].name.toString()),
                                  ],
                                ),
                              );
                            } else {
                              return Container(); // Return an empty container for items that should be hidden
                            }
                          }),
                        ),
                      ),
                      PrimaryButton(
                          title: 'Save',
                          fontSize: 14,
                          height: Get.height * 0.07,
                          width: Get.width * 0.5,
                          onPressed: () {
                            Get.back();
                          },
                          color: ColorManager.kPrimaryColor,
                          textcolor: ColorManager.kWhiteColor),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    // Return the list of selected items
    return selectedItems;
  }
}
