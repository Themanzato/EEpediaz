class Review {
  final String id;
  final String userId;
  final String userName;
  final String userAvatar;
  final String mapId;
  final String mapName;
  final double rating;
  final String comment;
  final DateTime date;
  final List<String> likes;
  final List<ReviewComment> comments;

  const Review({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.mapId,
    required this.mapName,
    required this.rating,
    required this.comment,
    required this.date,
    required this.likes,
    required this.comments,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userAvatar: json['userAvatar'] as String,
      mapId: json['mapId'] as String,
      mapName: json['mapName'] as String,
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String,
      date: DateTime.parse(json['date'] as String),
      likes: List<String>.from(json['likes'] as List),
      comments: (json['comments'] as List)
          .map((e) => ReviewComment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userAvatar': userAvatar,
      'mapId': mapId,
      'mapName': mapName,
      'rating': rating,
      'comment': comment,
      'date': date.toIso8601String(),
      'likes': likes,
      'comments': comments.map((e) => e.toJson()).toList(),
    };
  }

  Review copyWith({
    String? id,
    String? userId,
    String? userName,
    String? userAvatar,
    String? mapId,
    String? mapName,
    double? rating,
    String? comment,
    DateTime? date,
    List<String>? likes,
    List<ReviewComment>? comments,
  }) {
    return Review(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      mapId: mapId ?? this.mapId,
      mapName: mapName ?? this.mapName,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      date: date ?? this.date,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
    );
  }
}

class ReviewComment {
  final String id;
  final String userId;
  final String userName;
  final String userAvatar;
  final String text;
  final DateTime date;
  final List<String> likes;

  const ReviewComment({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.text,
    required this.date,
    required this.likes,
  });

  factory ReviewComment.fromJson(Map<String, dynamic> json) {
    return ReviewComment(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userAvatar: json['userAvatar'] as String,
      text: json['text'] as String,
      date: DateTime.parse(json['date'] as String),
      likes: List<String>.from(json['likes'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userAvatar': userAvatar,
      'text': text,
      'date': date.toIso8601String(),
      'likes': likes,
    };
  }
}
