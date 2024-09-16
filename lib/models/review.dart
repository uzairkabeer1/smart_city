class Review {
  final String authorName;
  final int rating;
  final String text;
  final String? language;

  const Review({
    required this.authorName,
    required this.rating,
    required this.text,
    this.language,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      authorName: json['author_name'],
      rating: json['rating'],
      text: json['text'],
      language: json['language'],
    );
  }
}
