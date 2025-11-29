class User {
  final String id;
  final String username;
  final String email;
  final String avatar;
  final DateTime joinDate;
  final int level;
  final int experience;
  final List<String> favoriteMaps;
  final List<String> completedEEs;
  final UserStats stats;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.avatar,
    required this.joinDate,
    required this.level,
    required this.experience,
    required this.favoriteMaps,
    required this.completedEEs,
    required this.stats,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String,
      joinDate: DateTime.parse(json['joinDate'] as String),
      level: json['level'] as int,
      experience: json['experience'] as int,
      favoriteMaps: List<String>.from(json['favoriteMaps'] as List),
      completedEEs: List<String>.from(json['completedEEs'] as List),
      stats: UserStats.fromJson(json['stats'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'avatar': avatar,
      'joinDate': joinDate.toIso8601String(),
      'level': level,
      'experience': experience,
      'favoriteMaps': favoriteMaps,
      'completedEEs': completedEEs,
      'stats': stats.toJson(),
    };
  }
}

class UserStats {
  final int totalEEsCompleted;
  final int totalMapsPlayed;
  final int totalHoursPlayed;
  final int reviewsWritten;
  final int commentsWritten;
  final int likesReceived;
  final String favoriteGame;
  final String favoriteMap;

  const UserStats({
    required this.totalEEsCompleted,
    required this.totalMapsPlayed,
    required this.totalHoursPlayed,
    required this.reviewsWritten,
    required this.commentsWritten,
    required this.likesReceived,
    required this.favoriteGame,
    required this.favoriteMap,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      totalEEsCompleted: json['totalEEsCompleted'] as int,
      totalMapsPlayed: json['totalMapsPlayed'] as int,
      totalHoursPlayed: json['totalHoursPlayed'] as int,
      reviewsWritten: json['reviewsWritten'] as int,
      commentsWritten: json['commentsWritten'] as int,
      likesReceived: json['likesReceived'] as int,
      favoriteGame: json['favoriteGame'] as String,
      favoriteMap: json['favoriteMap'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalEEsCompleted': totalEEsCompleted,
      'totalMapsPlayed': totalMapsPlayed,
      'totalHoursPlayed': totalHoursPlayed,
      'reviewsWritten': reviewsWritten,
      'commentsWritten': commentsWritten,
      'likesReceived': likesReceived,
      'favoriteGame': favoriteGame,
      'favoriteMap': favoriteMap,
    };
  }
}
