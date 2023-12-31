class medicinematric {
  List<MedicineFrequencies>? medicineFrequencies;
  List<DayList>? dayList;
  List<DateList>? dateList;
  List<MedicineEventList>? medicineEventList;
  List<MedicineDosages>? medicineDosages;
  List<MedicineRoutes>? medicineRoutes;

  medicinematric(
      {this.medicineFrequencies,
      this.dayList,
      this.dateList,
      this.medicineEventList,
      this.medicineDosages,
      this.medicineRoutes});

  medicinematric.fromJson(Map<String, dynamic> json) {
    if (json['MedicineFrequencies'] != null) {
      medicineFrequencies = <MedicineFrequencies>[];
      json['MedicineFrequencies'].forEach((v) {
        medicineFrequencies!.add(MedicineFrequencies.fromJson(v));
      });
    }
    if (json['DayList'] != null) {
      dayList = <DayList>[];
      json['DayList'].forEach((v) {
        dayList!.add(DayList.fromJson(v));
      });
    }
    if (json['DateList'] != null) {
      dateList = <DateList>[];
      json['DateList'].forEach((v) {
        dateList!.add(DateList.fromJson(v));
      });
    }
    if (json['MedicineEventList'] != null) {
      medicineEventList = <MedicineEventList>[];
      json['MedicineEventList'].forEach((v) {
        medicineEventList!.add(MedicineEventList.fromJson(v));
      });
    }
    if (json['MedicineDosages'] != null) {
      medicineDosages = <MedicineDosages>[];
      json['MedicineDosages'].forEach((v) {
        medicineDosages!.add(MedicineDosages.fromJson(v));
      });
    }
    if (json['MedicineRoutes'] != null) {
      medicineRoutes = <MedicineRoutes>[];
      json['MedicineRoutes'].forEach((v) {
        medicineRoutes!.add(MedicineRoutes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (medicineFrequencies != null) {
      data['MedicineFrequencies'] =
          medicineFrequencies!.map((v) => v.toJson()).toList();
    }
    if (dayList != null) {
      data['DayList'] = dayList!.map((v) => v.toJson()).toList();
    }
    if (dateList != null) {
      data['DateList'] = dateList!.map((v) => v.toJson()).toList();
    }
    if (medicineEventList != null) {
      data['MedicineEventList'] =
          medicineEventList!.map((v) => v.toJson()).toList();
    }
    if (medicineDosages != null) {
      data['MedicineDosages'] =
          medicineDosages!.map((v) => v.toJson()).toList();
    }
    if (medicineRoutes != null) {
      data['MedicineRoutes'] = medicineRoutes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MedicineFrequencies {
  dynamic quantity;
  dynamic numericDisplay;

  MedicineFrequencies({this.quantity, this.numericDisplay});

  MedicineFrequencies.fromJson(Map<String, dynamic> json) {
    quantity = json['Quantity'];
    numericDisplay = json['NumericDisplay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Quantity'] = quantity;
    data['NumericDisplay'] = numericDisplay;
    return data;
  }
}

class DayList {
  dynamic id;
  dynamic englishDay;
  dynamic urduDay;

  DayList({this.id, this.englishDay, this.urduDay});

  DayList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    englishDay = json['EnglishDay'];
    urduDay = json['UrduDay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['EnglishDay'] = englishDay;
    data['UrduDay'] = urduDay;
    return data;
  }
}

class DateList {
  dynamic id;
  dynamic englishCounting;
  dynamic urduCounting;

  DateList({this.id, this.englishCounting, this.urduCounting});

  DateList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    englishCounting = json['EnglishCounting'];
    urduCounting = json['UrduCounting'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['EnglishCounting'] = englishCounting;
    data['UrduCounting'] = urduCounting;
    return data;
  }
}

class MedicineEventList {
  dynamic id;
  dynamic code;
  dynamic display;
  dynamic description;
  dynamic urduDescription;

  MedicineEventList(
      {this.id,
      this.code,
      this.display,
      this.description,
      this.urduDescription});

  MedicineEventList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    code = json['Code'];
    display = json['Display'];
    description = json['Description'];
    urduDescription = json['UrduDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Code'] = code;
    data['Display'] = display;
    data['Description'] = description;
    data['UrduDescription'] = urduDescription;
    return data;
  }
}

class MedicineDosages {
  dynamic id;
  dynamic timeStamp;
  dynamic abbreviation;
  dynamic latin;
  dynamic englishDefinition;
  dynamic urduDefinition;
  dynamic dosageValue;
  dynamic active;
  dynamic repeatId;
  dynamic branchId;
  dynamic createdById;
  dynamic createdOn;
  dynamic modifiedById;
  dynamic modifiedOn;
  dynamic dosageName;

  MedicineDosages(
      {this.id,
      this.timeStamp,
      this.abbreviation,
      this.latin,
      this.englishDefinition,
      this.urduDefinition,
      this.dosageValue,
      this.active,
      this.repeatId,
      this.branchId,
      this.createdById,
      this.createdOn,
      this.modifiedById,
      this.modifiedOn,
      this.dosageName});

  MedicineDosages.fromJson(Map<dynamic, dynamic> json) {
    id = json['Id'];
    timeStamp = json['TimeStamp'];
    abbreviation = json['Abbreviation'];
    latin = json['Latin'];
    englishDefinition = json['EnglishDefinition'];
    urduDefinition = json['UrduDefinition'];
    dosageValue = json['DosageValue'];
    active = json['Active'];
    repeatId = json['RepeatId'];
    branchId = json['BranchId'];
    createdById = json['CreatedById'];
    createdOn = json['CreatedOn'];
    modifiedById = json['ModifiedById'];
    modifiedOn = json['ModifiedOn'];
    dosageName = json['DosageName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['TimeStamp'] = timeStamp;
    data['Abbreviation'] = abbreviation;
    data['Latin'] = latin;
    data['EnglishDefinition'] = englishDefinition;
    data['UrduDefinition'] = urduDefinition;
    data['DosageValue'] = dosageValue;
    data['Active'] = active;
    data['RepeatId'] = repeatId;
    data['BranchId'] = branchId;
    data['CreatedById'] = createdById;
    data['CreatedOn'] = createdOn;
    data['ModifiedById'] = modifiedById;
    data['ModifiedOn'] = modifiedOn;
    data['DosageName'] = dosageName;
    return data;
  }
}

class MedicineRoutes {
  dynamic id;
  dynamic abbreviation;
  dynamic englishDefinition;
  dynamic urduDefinition;

  MedicineRoutes(
      {this.id,
      this.abbreviation,
      this.englishDefinition,
      this.urduDefinition});

  MedicineRoutes.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    abbreviation = json['Abbreviation'];
    englishDefinition = json['EnglishDefinition'];
    urduDefinition = json['UrduDefinition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Abbreviation'] = abbreviation;
    data['EnglishDefinition'] = englishDefinition;
    data['UrduDefinition'] = urduDefinition;
    return data;
  }
}
