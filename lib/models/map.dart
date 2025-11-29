class ZombieMap {
  final String id;
  final String name;
  final String gameId;
  final String description;
  final String imageUrl;
  final List<EasterEgg> easterEggs;
  final List<ShieldPart> shieldParts;
  final List<SecondaryEE> secondaryEEs;
  final List<Review> reviews;
  final double rating;
  final int totalReviews;

  const ZombieMap({
    required this.id,
    required this.name,
    required this.gameId,
    required this.description,
    required this.imageUrl,
    required this.easterEggs,
    required this.shieldParts,
    required this.secondaryEEs,
    required this.reviews,
    required this.rating,
    required this.totalReviews,
  });

  factory ZombieMap.fromJson(Map<String, dynamic> json) {
    return ZombieMap(
      id: json['id'] as String,
      name: json['name'] as String,
      gameId: json['gameId'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      easterEggs: (json['easterEggs'] as List)
          .map((e) => EasterEgg.fromJson(e as Map<String, dynamic>))
          .toList(),
      shieldParts: (json['shieldParts'] as List)
          .map((e) => ShieldPart.fromJson(e as Map<String, dynamic>))
          .toList(),
      secondaryEEs: (json['secondaryEEs'] as List)
          .map((e) => SecondaryEE.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviews: (json['reviews'] as List)
          .map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      rating: (json['rating'] as num).toDouble(),
      totalReviews: json['totalReviews'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'gameId': gameId,
      'description': description,
      'imageUrl': imageUrl,
      'easterEggs': easterEggs.map((e) => e.toJson()).toList(),
      'shieldParts': shieldParts.map((e) => e.toJson()).toList(),
      'secondaryEEs': secondaryEEs.map((e) => e.toJson()).toList(),
      'reviews': reviews.map((e) => e.toJson()).toList(),
      'rating': rating,
      'totalReviews': totalReviews,
    };
  }
}

class EasterEgg {
  final String id;
  final String name;
  final String description;
  final List<Step> steps;
  final String difficulty;
  final int estimatedTime;
  final List<String> requiredItems;
  final String imageUrl;

  const EasterEgg({
    required this.id,
    required this.name,
    required this.description,
    required this.steps,
    required this.difficulty,
    required this.estimatedTime,
    required this.requiredItems,
    required this.imageUrl,
  });

  factory EasterEgg.fromJson(Map<String, dynamic> json) {
    return EasterEgg(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      steps: (json['steps'] as List)
          .map((e) => Step.fromJson(e as Map<String, dynamic>))
          .toList(),
      difficulty: json['difficulty'] as String,
      estimatedTime: json['estimatedTime'] as int,
      requiredItems: List<String>.from(json['requiredItems'] as List),
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'steps': steps.map((e) => e.toJson()).toList(),
      'difficulty': difficulty,
      'estimatedTime': estimatedTime,
      'requiredItems': requiredItems,
      'imageUrl': imageUrl,
    };
  }
}

class Step {
  final int stepNumber;
  final String description;
  final String location;
  final String imageUrl;
  final List<String> tips;

  const Step({
    required this.stepNumber,
    required this.description,
    required this.location,
    required this.imageUrl,
    required this.tips,
  });

  factory Step.fromJson(Map<String, dynamic> json) {
    return Step(
      stepNumber: json['stepNumber'] as int,
      description: json['description'] as String,
      location: json['location'] as String,
      imageUrl: json['imageUrl'] as String,
      tips: List<String>.from(json['tips'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stepNumber': stepNumber,
      'description': description,
      'location': location,
      'imageUrl': imageUrl,
      'tips': tips,
    };
  }
}

class ShieldPart {
  final String id;
  final String name;
  final String location;
  final String description;
  final String imageUrl;
  final MapLocation mapLocation;

  const ShieldPart({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.imageUrl,
    required this.mapLocation,
  });

  factory ShieldPart.fromJson(Map<String, dynamic> json) {
    return ShieldPart(
      id: json['id'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      mapLocation: MapLocation.fromJson(json['mapLocation'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'description': description,
      'imageUrl': imageUrl,
      'mapLocation': mapLocation.toJson(),
    };
  }
}

class SecondaryEE {
  final String id;
  final String name;
  final String description;
  final List<Step> steps;
  final String difficulty;
  final int estimatedTime;
  final String imageUrl;

  const SecondaryEE({
    required this.id,
    required this.name,
    required this.description,
    required this.steps,
    required this.difficulty,
    required this.estimatedTime,
    required this.imageUrl,
  });

  factory SecondaryEE.fromJson(Map<String, dynamic> json) {
    return SecondaryEE(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      steps: (json['steps'] as List)
          .map((e) => Step.fromJson(e as Map<String, dynamic>))
          .toList(),
      difficulty: json['difficulty'] as String,
      estimatedTime: json['estimatedTime'] as int,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'steps': steps.map((e) => e.toJson()).toList(),
      'difficulty': difficulty,
      'estimatedTime': estimatedTime,
      'imageUrl': imageUrl,
    };
  }
}

class MapLocation {
  final double x;
  final double y;
  final String description;

  const MapLocation({
    required this.x,
    required this.y,
    required this.description,
  });

  factory MapLocation.fromJson(Map<String, dynamic> json) {
    return MapLocation(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
      'description': description,
    };
  }
}

class Review {
  final String id;
  final String userId;
  final String userName;
  final String userAvatar;
  final double rating;
  final String comment;
  final DateTime date;
  final List<String> likes;
  final List<Comment> comments;

  const Review({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatar,
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
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String,
      date: DateTime.parse(json['date'] as String),
      likes: List<String>.from(json['likes'] as List),
      comments: (json['comments'] as List)
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userAvatar': userAvatar,
      'rating': rating,
      'comment': comment,
      'date': date.toIso8601String(),
      'likes': likes,
      'comments': comments.map((e) => e.toJson()).toList(),
    };
  }
}

class Comment {
  final String id;
  final String userId;
  final String userName;
  final String userAvatar;
  final String text;
  final DateTime date;
  final List<String> likes;

  const Comment({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.text,
    required this.date,
    required this.likes,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
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
