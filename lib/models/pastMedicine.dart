class pastMedicine {
  dynamic status;
  List<Medicinesss1>? medicines;

  pastMedicine({this.status, this.medicines});

  pastMedicine.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Medicines'] != null) {
      medicines = <Medicinesss1>[];
      json['Medicines'].forEach((v) {
        medicines!.add(Medicinesss1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (medicines != null) {
      data['Medicines'] = medicines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Medicinesss1 {
  dynamic eRNSId;
  dynamic medicineName;
  dynamic medicineDosage;
  dynamic medicineDosageId;
  dynamic dosageValue;
  dynamic dosageName;
  dynamic medicineStrengthId;
  dynamic medicineRouteId;
  dynamic routeName;
  dynamic frequencyQuantity;
  dynamic frequencyNumeric;
  dynamic dayId;
  dynamic dateId;
  dynamic englishCounting;
  dynamic englishDay;
  dynamic medicineEventTimingId;
  dynamic medicineDurationDetail;
  dynamic medicineEnglishDescription;
  dynamic medicineEventTimingDetail;
  dynamic medicineEventTimingDisplay;
  dynamic medicineUrduDescription;
  dynamic tappedMedicinesDetail;
  dynamic type;
  dynamic urduType;

  Medicinesss1(
      {this.eRNSId,
      this.medicineName,
      this.medicineDosage,
      this.medicineDosageId,
      this.dosageValue,
      this.dosageName,
      this.medicineStrengthId,
      this.medicineRouteId,
      this.routeName,
      this.frequencyQuantity,
      this.frequencyNumeric,
      this.dayId,
      this.dateId,
      this.englishCounting,
      this.englishDay,
      this.medicineEventTimingId,
      this.medicineDurationDetail,
      this.medicineEnglishDescription,
      this.medicineEventTimingDetail,
      this.medicineEventTimingDisplay,
      this.medicineUrduDescription,
      this.tappedMedicinesDetail,
      this.type,
      this.urduType});

  Medicinesss1.fromJson(Map<String, dynamic> json) {
    eRNSId = json['ERNSId'];
    medicineName = json['MedicineName'];
    medicineDosage = json['MedicineDosage'];
    medicineDosageId = json['MedicineDosageId'];
    dosageValue = json['DosageValue'];
    dosageName = json['DosageName'];
    medicineStrengthId = json['MedicineStrengthId'];
    medicineRouteId = json['MedicineRouteId'];
    routeName = json['RouteName'];
    frequencyQuantity = json['FrequencyQuantity'];
    frequencyNumeric = json['FrequencyNumeric'];
    dayId = json['DayId'];
    dateId = json['DateId'];
    englishCounting = json['EnglishCounting'];
    englishDay = json['EnglishDay'];
    medicineEventTimingId = json['MedicineEventTimingId'];
    medicineDurationDetail = json['MedicineDurationDetail'];
    medicineEnglishDescription = json['MedicineEnglishDescription'];
    medicineEventTimingDetail = json['MedicineEventTimingDetail'];
    medicineEventTimingDisplay = json['MedicineEventTimingDisplay'];
    medicineUrduDescription = json['MedicineUrduDescription'];
    tappedMedicinesDetail = json['TappedMedicinesDetail'];
    type = json['Type'];
    urduType = json['UrduType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ERNSId'] = eRNSId;
    data['MedicineName'] = medicineName;
    data['MedicineDosage'] = medicineDosage;
    data['MedicineDosageId'] = medicineDosageId;
    data['DosageValue'] = dosageValue;
    data['DosageName'] = dosageName;
    data['MedicineStrengthId'] = medicineStrengthId;
    data['MedicineRouteId'] = medicineRouteId;
    data['RouteName'] = routeName;
    data['FrequencyQuantity'] = frequencyQuantity;
    data['FrequencyNumeric'] = frequencyNumeric;
    data['DayId'] = dayId;
    data['DateId'] = dateId;
    data['EnglishCounting'] = englishCounting;
    data['EnglishDay'] = englishDay;
    data['MedicineEventTimingId'] = medicineEventTimingId;
    data['MedicineDurationDetail'] = medicineDurationDetail;
    data['MedicineEnglishDescription'] = medicineEnglishDescription;
    data['MedicineEventTimingDetail'] = medicineEventTimingDetail;
    data['MedicineEventTimingDisplay'] = medicineEventTimingDisplay;
    data['MedicineUrduDescription'] = medicineUrduDescription;
    data['TappedMedicinesDetail'] = tappedMedicinesDetail;
    data['Type'] = type;
    data['UrduType'] = urduType;
    return data;
  }
}
