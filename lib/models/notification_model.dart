class NotificationModel {
  String? id;
  String? title;
  String? body;
  String? uRL;
  String? icon;
  dynamic deviceToken;
  String? activity;
  String? dateTime;
  dynamic webToken;
  dynamic userName;
  String? userId;
  int? notificationType;
  bool? isViewed;
  dynamic email;
  NotificationModel(
      {this.id,
      this.title,
      this.body,
      this.uRL,
      this.icon,
      this.deviceToken,
      this.activity,
      this.dateTime,
      this.webToken,
      this.userName,
      this.userId,
      this.notificationType,
      this.isViewed,
      this.email});
  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    title = json['Title'];
    body = json['Body'];
    uRL = json['URL'];
    icon = json['Icon'];
    deviceToken = json['DeviceToken'];
    activity = json['Activity'];
    dateTime = json['DateTime'];
    webToken = json['WebToken'];
    userName = json['UserName'];
    userId = json['UserId'];
    notificationType = json['NotificationType'];
    isViewed = json['IsViewed'];
    email = json['email'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Title'] = title;
    data['Body'] = body;
    data['URL'] = uRL;
    data['Icon'] = icon;
    data['DeviceToken'] = deviceToken;
    data['Activity'] = activity;
    data['DateTime'] = dateTime;
    data['WebToken'] = webToken;
    data['UserName'] = userName;
    data['UserId'] = userId;
    data['NotificationType'] = notificationType;
    data['IsViewed'] = isViewed;
    data['email'] = email;
    return data;
  }
}
