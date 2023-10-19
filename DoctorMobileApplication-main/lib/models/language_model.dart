import 'dart:ui';

class LanguageModel {
  int? id;
  String? name;
  String? image;
  Locale? locale;

  LanguageModel({this.id, this.name, this.image, this.locale});

  LanguageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];

    // Deserialize the 'locale' property from a String in the format 'languageCode_countryCode'
    final localeString = json['locale'];
    if (localeString != null) {
      final parts = localeString.split('_');
      if (parts.length == 2) {
        locale = Locale(parts[0], parts[1]);
      }
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      // Serialize the 'locale' property to a String
      'locale': locale != null
          ? '${locale!.languageCode}_${locale!.countryCode}'
          : null,
    };
  }
}
