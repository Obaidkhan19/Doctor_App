class monthlyappointresponse {
  dynamic date;
  dynamic paid;
  dynamic unPaid;

  monthlyappointresponse({this.date, this.paid, this.unPaid});

  monthlyappointresponse.fromJson(Map<String, dynamic> json) {
    date = json['Date'];
    paid = json['Paid'];
    unPaid = json['UnPaid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Date'] = date;
    data['Paid'] = paid;
    data['UnPaid'] = unPaid;
    return data;
  }
}
