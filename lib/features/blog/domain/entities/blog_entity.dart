class Blog {
  final String id;
  final String authorId;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> topics;
  final DateTime updatedAt;
  final String? authorName;

  Blog({
    required this.id,
    required this.authorId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.topics,
    required this.updatedAt,
    this.authorName,
  });
}
