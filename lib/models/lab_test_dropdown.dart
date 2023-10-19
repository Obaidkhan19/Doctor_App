class LabTestsModel {
  int? status;
  List<LabTests>? data;
  String? errorMessage;

  LabTestsModel({this.status, this.data, this.errorMessage});

  LabTestsModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <LabTests>[];
      json['Data'].forEach((v) {
        data!.add(LabTests.fromJson(v));
      });
    }
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['ErrorMessage'] = errorMessage;
    return data;
  }
}

class LabTests {
  String? labtestId;
  String? id;
  String? name;
  double? price;
  double? actualPrice;
  bool? isForSampleCollectionCharges;
  bool? isForAdditionalCharges;
  bool? isForUrgentCharges;
  bool? isAdditionalChargesForPassenger;
  bool? isForCovid;
  bool? isForAdditionalChargesForCovid;
  String? typeId;

  LabTests(
      {this.id,
      this.labtestId,
      this.name,
      this.price,
      this.actualPrice,
      this.isForSampleCollectionCharges,
      this.isForAdditionalCharges,
      this.isForUrgentCharges,
      this.isAdditionalChargesForPassenger,
      this.isForCovid,
      this.isForAdditionalChargesForCovid});

  LabTests.fromJson(Map<String, dynamic> json) {
    typeId = "2";
    id = json['Id'];
    labtestId = json['LabTestId'];
    name = json['Name'];
    price = json['Price'];
    actualPrice = json['ActualPrice'];
    isForSampleCollectionCharges = json['IsForSampleCollectionCharges'];
    isForAdditionalCharges = json['IsForAdditionalCharges'];
    isForUrgentCharges = json['IsForUrgentCharges'];
    isAdditionalChargesForPassenger = json['IsAdditionalChargesForPassenger'];
    isForCovid = json['IsForCovid'];
    isForAdditionalChargesForCovid = json['IsForAdditionalChargesForCovid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TypeBit'] = typeId;
    data['Id'] = id;
    data['LabTestId'] = id;
    data['Name'] = name;
    data['Price'] = price;
    data['ActualPrice'] = actualPrice;
    data['IsForSampleCollectionCharges'] = isForSampleCollectionCharges;
    data['IsForAdditionalCharges'] = isForAdditionalCharges;
    data['IsForUrgentCharges'] = isForUrgentCharges;
    data['IsAdditionalChargesForPassenger'] = isAdditionalChargesForPassenger;
    data['IsForCovid'] = isForCovid;
    data['IsForAdditionalChargesForCovid'] = isForAdditionalChargesForCovid;
    return data;
  }
}
