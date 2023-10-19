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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Date'] = this.date;
    data['Paid'] = this.paid;
    data['UnPaid'] = this.unPaid;
    return data;
  }
}
