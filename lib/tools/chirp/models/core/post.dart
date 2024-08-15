import 'core.dart';

class Post {
  final String id;
  final String title;
  final String content;
  final int upvotes;
  final int downvotes;
  final bool isEdited;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final String? link;
  final ChirpUser? user;
  final List<PostAttachmentMedia> postAttachmentMedia;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.upvotes,
    required this.downvotes,
    required this.isEdited,
    required this.isDeleted,
    required this.createdAt,
    required this.modifiedAt,
    this.link,
    this.user,
    required this.postAttachmentMedia,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      upvotes: json['upvotes'] as int,
      downvotes: json['downvotes'] as int,
      isEdited: json['is_edited'] as bool,
      isDeleted: json['is_deleted'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      modifiedAt: DateTime.parse(json['modified_at'] as String),
      link: json['link'] as String?,
      user: ChirpUser.fromJson(json["user"]),
      postAttachmentMedia: (json['post_attachment_media'] as List<dynamic>)
          .map((e) => PostAttachmentMedia.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'upvotes': upvotes,
      'downvotes': downvotes,
      'is_edited': isEdited,
      'is_deleted': isDeleted,
      'created_at': createdAt.toIso8601String(),
      'modified_at': modifiedAt.toIso8601String(),
      'link': link,
      'post_attachment_media':
          postAttachmentMedia.map((e) => e.toJson()).toList(),
    };
  }
}
