class Finding {
  String? id;
  String? name;

  Finding({this.id, this.name});

  factory Finding.fromJson(Map<String, dynamic> json) {
    return Finding(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
