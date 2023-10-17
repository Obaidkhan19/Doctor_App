import 'dart:math';
import 'dart:ui';

import 'package:doctormobileapplication/models/consultingqueueresponse.dart';
import 'package:get/get.dart';

import '../../components/snackbar.dart';
import '../../models/ConsultingQueue.dart';
import '../../utils/constants.dart';
import '../repositories/Consulting_Queue_repo/consultingQueue_repo.dart';

class ConsultingQueueController extends GetxController implements GetxService {
  int _index = 0;
  int get index => _index;
  List<consultingqueuereponse> response = [];

  getPageIndexofAll() {
    return _index;
  }

  updateconsultinglist(List<consultingqueuereponse> data) {
    response = data;
    update();
  }

  setPageIndexofDayAll(int ind) {
    _index = ind;
    update();
  }

  ConsultingQueueModel _consultingQueueList = ConsultingQueueModel();
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
      showSnackbar(Get.context!, 'All records are fetched!',
          color: const Color(0xfff1272d3));
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

  getConsultingQueueData(String? Search, String? Status) async {
    if (startIndexToFetchData == 0) {
      isLoadingDataClinicalPracticeDataList = true;
    } else {
      isLoadingDataClinicalPracticeDataListmore = true;
      update();
    }
    _consultingQueueList = ConsultingQueueModel();
    //update(); //don't remove commented lines from it if u remove it call never send to repository for data getting
    try {
      _consultingQueueList = await ConsultingQueueRepo.GetConsultingQueue(
          Search, Status, startIndexToFetchData);

      TotalRecordsData = (_consultingQueueList.totalRecord != null)
          ? _consultingQueueList.totalRecord!.toInt()
          : TotalRecordsData;

      if (Status.toString() == "1") {
        if (_consultingQueueList.queue != null) {
          _ClinicalPracticeDataList.queue ??= [];
          for (var element in _consultingQueueList.queue!) {
            _ClinicalPracticeDataList.queue!.add(element);
          }
        }
        //  _ClinicalPracticeDataList = ConsultingQueueModel();
        // _ClinicalPracticeDataList = _consultingQueueList;
      } else if (Status.toString() == "2") {
        if (_consultingQueueList.queue != null) {
          _HoldDataList.queue ??= [];
          for (var element in _consultingQueueList.queue!) {
            _HoldDataList.queue!.add(element);
          }
        }
        //   _HoldDataList = ConsultingQueueModel();
        //_HoldDataList = _consultingQueueList;
      } else if (Status.toString() == "3") {
        if (_consultingQueueList.queue != null) {
          _ConsultedDataList.queue ??= [];
          for (var element in _consultingQueueList.queue!) {
            _ConsultedDataList.queue!.add(element);
          }
        }

        //   _ConsultedDataList = ConsultingQueueModel();
        // _ConsultedDataList = _consultingQueueList;
      }

      isLoadingDataClinicalPracticeDataList = false;
      isLoadingDataClinicalPracticeDataListmore = false;
      update();
    } catch (e) {
      isLoadingDataClinicalPracticeDataList = false;
      isLoadingDataClinicalPracticeDataListmore = false;
      update();
    }
    isLoadingDataClinicalPracticeDataList = false;
    isLoadingDataClinicalPracticeDataListmore = false;
    update();
  }

// filter
  updatedate(DateTime datetime) {
    date = datetime;
    update();
  }

  static ConsultingQueueController get i =>
      Get.put(ConsultingQueueController());
}
