class WallpaperModel {
  String? photographer;
  String? photographer_url;
  int? photographer_id;
  SrcModel src;
  WallpaperModel(
      {this.photographer,
      this.photographer_id,
      this.photographer_url,
      required this.src});

  factory WallpaperModel.fromMap(Map<String, dynamic> json) {
    return WallpaperModel(
        photographer: json['photographer'],
        photographer_id: json['photographer_id'],
        photographer_url: json['photographer_url'],
        src: SrcModel.fromMap(json['src']));
  }
}

class SrcModel {
  String? original;
  String? small;
  String? portrait;
  SrcModel({this.original, this.portrait, this.small});
  factory SrcModel.fromMap(Map<String, dynamic> json) {
    return SrcModel(
        original: json['original'],
        portrait: json['portrait'],
        small: json['small']);
  }
}
