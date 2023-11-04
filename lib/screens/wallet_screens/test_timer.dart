import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeController extends GetxController {
  RxList<String> startTimes = <String>[].obs;
  List<Timer> timers = [];

  @override
  void onInit() {
    super.onInit();
    startTimes.assignAll(['04:05:00', '05:30:00', '09:15:00', '14:45:00']);
    startTimers();
  }

  void startTimers() {
    for (int i = 0; i < startTimes.length; i++) {
      timers.add(Timer.periodic(const Duration(seconds: 1), (timer) {
        startTimes[i] = incrementTimeByOneSecond(startTimes[i]);
        update();
      }));
    }
  }

  String incrementTimeByOneSecond(String time) {
    final timeParts = time.split(':');
    final hours = int.parse(timeParts[0]);
    final minutes = int.parse(timeParts[1]);
    final seconds = int.parse(timeParts[2]);

    final newSeconds = seconds + 1;
    if (newSeconds >= 60) {
      final newMinutes = minutes + 1;
      final newHours = hours + (newMinutes ~/ 60);
      return '${(newHours % 24).toString().padLeft(2, '0')}:${(newMinutes % 60).toString().padLeft(2, '0')}:${(newSeconds % 60).toString().padLeft(2, '0')}';
    } else {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${newSeconds.toString().padLeft(2, '0')}';
    }
  }
}

class MyAppTimer extends StatelessWidget {
  final TimeController timeController = Get.put(TimeController());

  MyAppTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Time Display with GetX'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: timeController.startTimes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(timeController.startTimes[index]),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
