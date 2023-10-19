import 'package:doctormobileapplication/data/controller/erx_controller.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/medicines.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConsultingQueueDropDownWidget extends StatefulWidget {
  List<String> list;
  String selected;

  ConsultingQueueDropDownWidget(
      {required this.list, required this.selected, Key? key})
      : super(key: key);

  @override
  State<ConsultingQueueDropDownWidget> createState() =>
      _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends State<ConsultingQueueDropDownWidget> {
  bool isExpanded = false;

  final controller = Get.put(ERXController());
  // _getMedicinesByGroupId() async {
  //   // LocalDb localDB = LocalDb();
  //   // String? doctorId = await localDB.getDoctorId();
  //   // String? branchId = await localDB.getBranchId();
  //   // String? token = await localDB.getToken();
  //   Medicines1 m = Medicines1();
  //   controller.updateMedicinelist(
  //     await m.getMedicinesByGroupId(
  //       // doctorId,
  //       // branchId,
  //       // '850b74cd-6808-401c-bf48-b4bef57d1b7d',
  //       // token,
  //       "956315e6-4a1e-4eaa-8a40-f0e9a04609f2",
  //       "5bd60354-fefd-4bcc-a58d-b8e27d802e85",
  //       '850b74cd-6808-401c-bf48-b4bef57d1b7d',
  //       "8990de83-baed-4e26-a66e-df9f492de8e1",
  //     ),
  //   );
  // }

  // _getMedicines() async {
  //   // LocalDb localDB = LocalDb();
  //   // String? doctorId = await localDB.getDoctorId();
  //   // String? branchId = await localDB.getBranchId();
  //   // String? token = await localDB.getToken();
  //   Medicines1 m = Medicines1();
  //   controller.updateMedicinelist(
  //     await m.getMedicines(
  //       // "150",
  //       // doctorId,
  //       // '',
  //       // '',
  //       // branchId,
  //       // '',
  //       // token,
  //       "150",
  //       "956315e6-4a1e-4eaa-8a40-f0e9a04609f2",
  //       '',
  //       '',
  //       "5bd60354-fefd-4bcc-a58d-b8e27d802e85",
  //       '',
  //       "8f3609d2-0325-4c95-9af3-a872e5176497",
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Get.width * 1,
          height: Get.height * 0.06,
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorManager.kPrimaryColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(
                15.0), // Adjust the border radius as needed
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
            child: InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  isExpanded = !isExpanded;

                  setState(() {});
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.selected,
                        style: const TextStyle(
                            color: ColorManager.kblackColor, fontSize: 10),
                      ),
                    ),
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: ColorManager.kblackColor,
                    )
                  ],
                )),
          ),
        ),
        if (isExpanded)
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: widget.list
                .map((e) => InkWell(
                      onTap: () {
                        // isExpanded = false;
                        // widget.selected = e;
                        // if (widget.selected == "Med 1") {
                        //   _getMedicinesByGroupId();
                        //   controller.medicineList.length;
                        // }
                        // if (widget.selected == "Select") {
                        //   _getMedicines();
                        //   controller.medicineList.length;
                        // }
                        // setState(() {});
                      },
                      child: Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: widget.selected == e
                                ? ColorManager.kPrimaryColor
                                : Colors.grey.shade300,
                          ),
                          child: Center(
                              child: Text(
                            e.toString(),
                            style: const TextStyle(
                                color: ColorManager.kblackColor, fontSize: 10),
                          ))),
                    ))
                .toList(),
          )
      ],
    );
  }
}
