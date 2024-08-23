import 'core.dart';

class Comment {
  final String id;
  final String content;
  final bool isEdited;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final ChirpUser user;
  final Post post;
  final String? parent;
  final List<Comment> replies;

  Comment({
    required this.id,
    required this.content,
    required this.isEdited,
    required this.isDeleted,
    required this.createdAt,
    required this.modifiedAt,
    required this.user,
    required this.post,
    this.parent,
    required this.replies,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      content: json['content'],
      isEdited: json['is_edited'],
      isDeleted: json['is_deleted'],
      createdAt: DateTime.parse(json['created_at']),
      modifiedAt: DateTime.parse(json['modified_at']),
      user: ChirpUser.fromJson(json['user']),
      post: Post.fromJson(json['post']),
      parent: json['parent'],
      replies: (json['replies'] as List)
          .map((item) => Comment.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'is_edited': isEdited,
      'is_deleted': isDeleted,
      'created_at': createdAt.toIso8601String(),
      'modified_at': modifiedAt.toIso8601String(),
      'user': user.toJson(),
      'post': post.toJson(),
      'parent': parent,
      'replies': replies.map((item) => item.toJson()).toList(),
    };
  }
}
