class designationsData {
  int? status;
  List<Designations>? designations;

  designationsData({this.status, this.designations});

  designationsData.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Designations'] != null) {
      designations = <Designations>[];
      json['Designations'].forEach((v) {
        designations!.add(Designations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (designations != null) {
      data['Designations'] = designations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Designations {
  String? id;
  String? name;

  Designations({this.id, this.name});

  Designations.fromJson(Map<String, dynamic> json) {
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
