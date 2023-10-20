class advice {
  List<Advices>? advices;

  advice({this.advices});

  advice.fromJson(Map<String, dynamic> json) {
    if (json['Advices'] != null) {
      advices = <Advices>[];
      json['Advices'].forEach((v) {
        advices!.add(Advices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (advices != null) {
      data['Advices'] = advices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Advices {
  String? advice;
  String? doctorName;
  String? createdOn;
  int? isDeleteable;

  Advices({this.advice, this.doctorName, this.createdOn, this.isDeleteable});

  Advices.fromJson(Map<String, dynamic> json) {
    advice = json['Advice'];
    doctorName = json['DoctorName'];
    createdOn = json['CreatedOn'];
    isDeleteable = json['IsDeleteable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Advice'] = advice;
    data['DoctorName'] = doctorName;
    data['CreatedOn'] = createdOn;
    data['IsDeleteable'] = isDeleteable;
    return data;
  }
}
