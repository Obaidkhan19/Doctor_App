class Packages {
  int? status;
  List<LabPackages>? data;
  int? totalRecord;
  int? filterRecord;

  Packages({this.status, this.data, this.totalRecord, this.filterRecord});

  Packages.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <LabPackages>[];
      json['Data'].forEach((v) {
        data!.add( LabPackages.fromJson(v));
      });
    }
    totalRecord = json['TotalRecord'];
    filterRecord = json['FilterRecord'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['TotalRecord'] = totalRecord;
    data['FilterRecord'] = filterRecord;
    return data;
  }
}

class LabPackages {
  String? packageGroupId;
  String? packageGroupName;
  double? total;
  double? packageGroupDiscountRate;
  int? packageGroupDiscountType;
  List<DTOPackageGroupDetail>? dTOPackageGroupDetail;

  LabPackages(
      {this.packageGroupId,
      this.packageGroupName,
      this.total,
      this.packageGroupDiscountRate,
      this.packageGroupDiscountType,
      this.dTOPackageGroupDetail});

  LabPackages.fromJson(Map<String, dynamic> json) {
    packageGroupId = json['PackageGroupId'];
    packageGroupName = json['PackageGroupName'];
    total = json['Total'];
    packageGroupDiscountRate = json['PackageGroupDiscountRate'];
    packageGroupDiscountType = json['PackageGroupDiscountType'];
    if (json['DTOPackageGroupDetail'] != null) {
      dTOPackageGroupDetail = <DTOPackageGroupDetail>[];
      json['DTOPackageGroupDetail'].forEach((v) {
        dTOPackageGroupDetail!.add(DTOPackageGroupDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PackageGroupId'] = packageGroupId;
    data['PackageGroupName'] = packageGroupName;
    data['Total'] = total;
    data['PackageGroupDiscountRate'] = packageGroupDiscountRate;
    data['PackageGroupDiscountType'] = packageGroupDiscountType;
    if (dTOPackageGroupDetail != null) {
      data['DTOPackageGroupDetail'] =
          dTOPackageGroupDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DTOPackageGroupDetail {
  String? id;
  String? patientId;
  String? branchId;
  String? name;
  String? packageGroupId;
  String? packageGroupName;
  String? subServiceName;
  String? deliveryDateTime;
  String? date;
  int? start;
  int? length;
  String? search;
  String? orderDir;
  int? orderColumn;
  int? patientVisitType;
  String? isForPublicDisplay;
  double? total;
  String? packageGroupDiscountRate;
  String? packageGroupDiscountType;
  String? chargeTypeName;
  String? chargeIntervalName;
  String? serviceId;
  String? service;
  String? intervalDuration;

  DTOPackageGroupDetail(
      {this.id,
      this.patientId,
      this.branchId,
      this.name,
      this.packageGroupId,
      this.packageGroupName,
      this.subServiceName,
      this.deliveryDateTime,
      this.date,
      this.start,
      this.length,
      this.search,
      this.orderDir,
      this.orderColumn,
      this.patientVisitType,
      this.isForPublicDisplay,
      this.total,
      this.packageGroupDiscountRate,
      this.packageGroupDiscountType,
      this.chargeTypeName,
      this.chargeIntervalName,
      this.serviceId,
      this.service,
      this.intervalDuration});

  DTOPackageGroupDetail.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    patientId = json['PatientId'];
    branchId = json['BranchId'];
    name = json['Name'];
    packageGroupId = json['PackageGroupId'];
    packageGroupName = json['PackageGroupName'];
    subServiceName = json['SubServiceName'];
    deliveryDateTime = json['DeliveryDateTime'];
    date = json['Date'];
    start = json['Start'];
    length = json['Length'];
    search = json['Search'];
    orderDir = json['OrderDir'];
    orderColumn = json['OrderColumn'];
    patientVisitType = json['PatientVisitType'];
    isForPublicDisplay = json['IsForPublicDisplay'];
    total = json['Total'];
    packageGroupDiscountRate = json['PackageGroupDiscountRate'];
    packageGroupDiscountType = json['PackageGroupDiscountType'];
    chargeTypeName = json['ChargeTypeName'];
    chargeIntervalName = json['ChargeIntervalName'];
    serviceId = json['ServiceId'];
    service = json['Service'];
    intervalDuration = json['IntervalDuration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['PatientId'] = patientId;
    data['BranchId'] = branchId;
    data['Name'] = name;
    data['PackageGroupId'] = packageGroupId;
    data['PackageGroupName'] = packageGroupName;
    data['SubServiceName'] = subServiceName;
    data['DeliveryDateTime'] = deliveryDateTime;
    data['Date'] = date;
    data['Start'] = start;
    data['Length'] = length;
    data['Search'] = search;
    data['OrderDir'] = orderDir;
    data['OrderColumn'] = orderColumn;
    data['PatientVisitType'] = patientVisitType;
    data['IsForPublicDisplay'] = isForPublicDisplay;
    data['Total'] = total;
    data['PackageGroupDiscountRate'] = packageGroupDiscountRate;
    data['PackageGroupDiscountType'] = packageGroupDiscountType;
    data['ChargeTypeName'] = chargeTypeName;
    data['ChargeIntervalName'] = chargeIntervalName;
    data['ServiceId'] = serviceId;
    data['Service'] = service;
    data['IntervalDuration'] = intervalDuration;
    return data;
  }
}
