class ImagenModel {
  String? idimagen;
  String name;
  String url;

  ImagenModel({
    this.idimagen,
    required this.name,
    required this.url
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url
    };
  }
}