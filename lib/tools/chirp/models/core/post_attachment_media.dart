class PostAttachmentMedia {
  final String id;
  final String image;
  final DateTime createdAt;
  final String post;

  PostAttachmentMedia({
    required this.id,
    required this.image,
    required this.createdAt,
    required this.post,
  });

  factory PostAttachmentMedia.fromJson(Map<String, dynamic> json) {
    return PostAttachmentMedia(
      id: json['id'] as String,
      image: json['image'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      post: json['post'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'created_at': createdAt.toIso8601String(),
      'post': post,
    };
  }
}
