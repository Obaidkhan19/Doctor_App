class Diagnostics {
  int? status;
  List<Diagnostics>? diagnostics;

  Diagnostics({this.status, this.diagnostics});

  Diagnostics.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Diagnostics'] != null) {
      diagnostics = <Diagnostics>[];
      json['Diagnostics'].forEach((v) {
        diagnostics!.add(Diagnostics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (diagnostics != null) {
      data['Diagnostics'] = diagnostics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Diagnostics1 {
  String? id;
  String? name;
  String? code;
  String? comments;

  Diagnostics1({this.id, this.name, this.code, this.comments});

  Diagnostics1.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    code = json['Code'];
    comments = json['Comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['Code'] = code;
    data['Comments'] = comments;
    return data;
  }
}
