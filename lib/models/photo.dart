class Photo {
  final String photoReference;
  final int height;
  final int width;

  const Photo({
    required this.photoReference,
    required this.height,
    required this.width,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      photoReference: json['photo_reference'],
      height: json['height'],
      width: json['width'],
    );
  }
}
