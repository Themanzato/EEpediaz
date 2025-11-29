class Game {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final List<String> maps;
  final DateTime releaseDate;

  const Game({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.maps,
    required this.releaseDate,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      maps: List<String>.from(json['maps'] as List),
      releaseDate: DateTime.parse(json['releaseDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'maps': maps,
      'releaseDate': releaseDate.toIso8601String(),
    };
  }
}
