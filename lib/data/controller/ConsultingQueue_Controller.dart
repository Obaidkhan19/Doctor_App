import 'dart:async';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/consultingqueueresponse.dart';
import 'package:doctormobileapplication/models/consultingqueuewaithold.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../models/ConsultingQueue.dart';
import '../../utils/constants.dart';
import '../repositories/Consulting_Queue_repo/consultingQueue_repo.dart';

class ConsultingQueueController extends GetxController implements GetxService {
//
  bool showPrescriptionScreen = false;
  updateshowprescription() {
    showPrescriptionScreen = !showPrescriptionScreen;
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  int tabindex = 0;
  bool checkcallresponse = false;
  updatecallresponse(bool x) {
    checkcallresponse = x;
    update();
  }

  updateselectedindex(int ind) {
    tabindex = ind;
    update();
  }

  updateIsloading(bool value) {
    _isLoading = value;
    update();
  }

  bool _isclinicLoading = false;
  bool get isclinicLoading => _isclinicLoading;
  updateIsclinicloading(bool value) {
    _isclinicLoading = value;
    update();
  }

  int _index = 0;
  int get index => _index;
  List<consultingqueuewaitholdresponse> response = [];
  List<consultingqueuewaitholdresponse> consultingqueuewait = [];
  List<consultingqueuewaitholdresponse> consultingqueuehold = [];

  getPageIndexofAll() {
    return _index;
  }

// WAITING

  RxList<String> startTimeswait = <String>[].obs;
  List<Timer> timerswait = [];
  List<String> stwait = [];

  updateconsultingqueuewait(List<consultingqueuewaitholdresponse> wait) {
    consultingqueuewait = wait;

    stopAndClearTimerswait();
    stwait.clear();
    for (int i = 0; i < wait.length; i++) {
      stwait.add(wait[i].waitingTime);
    }
    starttimerswait();
    update();

    update();
  }

  starttimerswait() {
    startTimeswait.assignAll(stwait);
    startTimerswait();
  }

  void stopAndClearTimerswait() {
    for (var timer in timerswait) {
      timer.cancel();
    }
    timerswait.clear();
  }

  void startTimerswait() {
    stopAndClearTimerswait();
    for (int i = 0; i < startTimeswait.length; i++) {
      timerswait.add(Timer.periodic(const Duration(seconds: 1), (timer) {
        startTimeswait[i] = incrementTimeByOneSecondwait(startTimeswait[i]);
        update();
      }));
    }
  }

  String incrementTimeByOneSecondwait(String time) {
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

// HOLD

  RxList<String> startTimeshold = <String>[].obs;
  List<Timer> timershold = [];
  List<String> sthold = [];

  updateconsultingqueuehold(List<consultingqueuewaitholdresponse> wait) {
    consultingqueuehold = wait;
    stopAndClearTimersHold();
    sthold.clear();
    for (int i = 0; i < wait.length; i++) {
      sthold.add(wait[i].waitingTime);
    }
    starttimershold();
    update();
  }

  starttimershold() {
    startTimeshold.assignAll(sthold);
    startTimershold();
  }

  void stopAndClearTimersHold() {
    for (var timer in timershold) {
      timer.cancel();
    }
    timershold.clear();
  }

  void startTimershold() {
    stopAndClearTimersHold();
    for (int i = 0; i < startTimeshold.length; i++) {
      timershold.add(Timer.periodic(const Duration(seconds: 1), (timer) {
        startTimeshold[i] = incrementTimeByOneSecondHold(startTimeshold[i]);
        update();
      }));
    }
  }

  String incrementTimeByOneSecondHold(String time) {
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

  //CONSULTED
  RxList<String> startTimesconsulted = <String>[].obs;
  List<Timer> timersconsulted = [];
  List<String> stconsulted = [];
  updateconsultinglist(List<consultingqueuewaitholdresponse> data) {
    response = data;
    stopAndClearTimersConsulted();
    stconsulted.clear();
    for (int i = 0; i < data.length; i++) {
      stconsulted.add(data[i].waitingTime);
    }
    starttimersconsulted();
    update();
  }

  starttimersconsulted() {
    startTimesconsulted.assignAll(stconsulted);
    startTimersconsulted();
  }

  void stopAndClearTimersConsulted() {
    for (var timer in timersconsulted) {
      timer.cancel();
    }
    timersconsulted.clear();
  }

  void startTimersconsulted() {
    stopAndClearTimersConsulted();

    for (int i = 0; i < startTimesconsulted.length; i++) {
      timersconsulted.add(Timer.periodic(const Duration(seconds: 1), (timer) {
        startTimesconsulted[i] =
            incrementTimeByOneSecondconsulted(startTimesconsulted[i]);
        update();
      }));
    }
  }

  String incrementTimeByOneSecondconsulted(String time) {
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

// CONSULTED VAULT
  List<consultingqueuereponse> pastconsultation = [];
  updatepastconsultinglist(List<consultingqueuereponse> data) {
    pastconsultation.clear();
    pastconsultation = data;
    update();
  }

  setPageIndexofDayAll(int ind) {
    _index = ind;
    update();
  }

  final ConsultingQueueModel _consultingQueueList = ConsultingQueueModel();
  ConsultingQueueModel get consultingQueueList => _consultingQueueList;
  DateTime? date; // filter

  final ConsultingQueueModel _ClinicalPracticeDataList = ConsultingQueueModel();
  ConsultingQueueModel get ClinicalPracticeDataList =>
      _ClinicalPracticeDataList;

  final ConsultingQueueModel _HoldDataList = ConsultingQueueModel();
  ConsultingQueueModel get HoldDataList => _HoldDataList;

  final ConsultingQueueModel _ConsultedDataList = ConsultingQueueModel();
  ConsultingQueueModel get ConsultedDataList => _ConsultedDataList;

  bool? isLoadingDataClinicalPracticeDataList = false;
  bool? isLoadingDataClinicalPracticeDataListmore = false;
  int startIndexToFetchData = 0;
  int TotalRecordsData = 0;

  SetStartToFetchNextData() {
    if ((startIndexToFetchData + AppConstants.maximumDataTobeFetched) <
        TotalRecordsData) {
      startIndexToFetchData =
          startIndexToFetchData + AppConstants.maximumDataTobeFetched;
      return true;
    } else {
      Fluttertoast.showToast(
          msg: "allrecordsarefetched".tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kPrimaryColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);

      return false;
    }
  }

  clearAllLists(String? Status) {
    startIndexToFetchData = 0;
    TotalRecordsData = 0;
    if (Status.toString() == "1") {
      if (_ClinicalPracticeDataList.queue != null &&
          _ClinicalPracticeDataList.queue!.isNotEmpty) {
        _ClinicalPracticeDataList.queue!.clear();
      }
    } else if (Status.toString() == "2") {
      if (_HoldDataList.queue != null && _HoldDataList.queue!.isNotEmpty) {
        _HoldDataList.queue!.clear();
      }
    } else if (Status.toString() == "3") {
      if (_ConsultedDataList.queue != null &&
          _ConsultedDataList.queue!.isNotEmpty) {
        _ConsultedDataList.queue!.clear();
      }
    }
  }

  getpastconsultation(int length) async {
    await ConsultingQueueRepo.GetConsultingQueue(length);
  }

  // getConsultingQueueData(String? Search, String? Status) async {
  //   if (startIndexToFetchData == 0) {
  //     isLoadingDataClinicalPracticeDataList = true;
  //   } else {
  //     isLoadingDataClinicalPracticeDataListmore = true;
  //     update();
  //   }
  //   _consultingQueueList = ConsultingQueueModel();
  //   //update(); //don't remove commented lines from it if u remove it call never send to repository for data getting
  //   try {
  //     _consultingQueueList = await ConsultingQueueRepo.GetConsultingQueue(
  //         Search, Status, startIndexToFetchData);

  //     TotalRecordsData = (_consultingQueueList.totalRecord != null)
  //         ? _consultingQueueList.totalRecord!.toInt()
  //         : TotalRecordsData;

  //     if (Status.toString() == "1") {
  //       if (_consultingQueueList.queue != null) {
  //         _ClinicalPracticeDataList.queue ??= [];
  //         for (var element in _consultingQueueList.queue!) {
  //           _ClinicalPracticeDataList.queue!.add(element);
  //         }
  //       }
  //       //  _ClinicalPracticeDataList = ConsultingQueueModel();
  //       // _ClinicalPracticeDataList = _consultingQueueList;
  //     } else if (Status.toString() == "2") {
  //       if (_consultingQueueList.queue != null) {
  //         _HoldDataList.queue ??= [];
  //         for (var element in _consultingQueueList.queue!) {
  //           _HoldDataList.queue!.add(element);
  //         }
  //       }
  //       //   _HoldDataList = ConsultingQueueModel();
  //       //_HoldDataList = _consultingQueueList;
  //     } else if (Status.toString() == "3") {
  //       if (_consultingQueueList.queue != null) {
  //         _ConsultedDataList.queue ??= [];
  //         for (var element in _consultingQueueList.queue!) {
  //           _ConsultedDataList.queue!.add(element);
  //         }
  //       }

  //       //   _ConsultedDataList = ConsultingQueueModel();
  //       // _ConsultedDataList = _consultingQueueList;
  //     }

  //     isLoadingDataClinicalPracticeDataList = false;
  //     isLoadingDataClinicalPracticeDataListmore = false;
  //     update();
  //   } catch (e) {
  //     isLoadingDataClinicalPracticeDataList = false;
  //     isLoadingDataClinicalPracticeDataListmore = false;
  //     update();
  //   }
  //   isLoadingDataClinicalPracticeDataList = false;
  //   isLoadingDataClinicalPracticeDataListmore = false;
  //   update();
  // }

// filter
  updatedate(DateTime datetime) {
    date = datetime;
    update();
  }

  static ConsultingQueueController get i =>
      Get.put(ConsultingQueueController());
}
