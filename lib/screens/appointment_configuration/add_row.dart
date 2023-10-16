class HoursRow {
  HoursRow({
    this.rid,
    this.startdate,
    this.enddate,
    this.day,
  });

  HoursRow.fromJson(dynamic json) {
    rid = json['RId'];
    startdate = json['StartDate'];
    enddate = json['EndDate'];
    day = json['Day'];
  }
  int? rid;
  String? startdate;
  String? enddate;
  String? day;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RId'] = rid;
    map['StartDate'] = startdate;
    map['EndDate'] = enddate;
    map['Day'] = day;
    return map;
  }
}
