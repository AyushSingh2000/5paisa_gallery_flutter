class ImageModel {
  final String id;
  final String downloadUrl;
  final String author;

  ImageModel(
      {required this.id, required this.downloadUrl, required this.author});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      downloadUrl: json['download_url'],
      author: json['author'],
    );
  }
}
