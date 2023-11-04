class religionData {
  int? status;
  List<Religion>? religion;

  religionData({this.status, this.religion});

  religionData.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Religion'] != null) {
      religion = <Religion>[];
      json['Religion'].forEach((v) {
        religion!.add(Religion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (religion != null) {
      data['Religion'] = religion!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Religion {
  String? id;
  String? name;

  Religion({this.id, this.name});

  Religion.fromJson(Map<String, dynamic> json) {
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
