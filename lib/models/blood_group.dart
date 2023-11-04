class bloodGroup {
  int? status;
  List<bloodGroupData>? data;

  bloodGroup({this.status, this.data});

  bloodGroup.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <bloodGroupData>[];
      json['Data'].forEach((v) {
        data!.add(bloodGroupData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class bloodGroupData {
  String? id;
  String? name;

  bloodGroupData({this.id, this.name});

  bloodGroupData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    return data;
  }
}
