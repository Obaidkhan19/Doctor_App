class institutionmodel {
  int? status;
  List<Institutions>? institutions;

  institutionmodel({this.status, this.institutions});

  institutionmodel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Institutions'] != null) {
      institutions = <Institutions>[];
      json['Institutions'].forEach((v) {
        institutions!.add(Institutions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (institutions != null) {
      data['Institutions'] = institutions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Institutions {
  String? id;
  String? name;

  Institutions({this.id, this.name});

  Institutions.fromJson(Map<String, dynamic> json) {
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
