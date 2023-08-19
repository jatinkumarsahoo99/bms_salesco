class CommercialLanguageModel {
  List<Display>? display;

  CommercialLanguageModel({this.display});

  CommercialLanguageModel.fromJson(Map<String, dynamic> json) {
    if (json['display'] != null) {
      display = <Display>[];
      json['display'].forEach((v) {
        display!.add(new Display.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.display != null) {
      data['display'] = this.display!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Display {
  bool? selectLanguage;
  bool? isSelect;
  String? languageCode;
  String? languageName;

  Display({this.selectLanguage, this.languageCode, this.languageName});

  Display.fromJson(Map<String, dynamic> json) {
    selectLanguage = json['selectLanguage'];
    isSelect = json['selectLanguage'];
    languageCode = json['languageCode'];
    languageName = json['languageName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSelect'] = this.isSelect;
    data['selectLanguage'] = this.selectLanguage;
    data['languageCode'] = this.languageCode;
    data['languageName'] = this.languageName;
    return data;
  }
}
