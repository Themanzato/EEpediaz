import '../models/review.dart';

class ReviewService {
  // Simulación de datos - en una app real esto vendría de una API
  final List<Review> _reviews = [
    Review(
      id: '1',
      userId: 'user1',
      userName: 'ZombieMaster',
      userAvatar: 'https://example.com/avatar1.jpg',
      mapId: '5',
      mapName: 'Der Eisendrache',
      rating: 5.0,
      comment: 'Increíble mapa! Los dragones y la mecánica de los arcos son geniales. El Easter Egg es épico y la ambientación medieval es perfecta.',
      date: DateTime.now().subtract(const Duration(days: 2)),
      likes: ['user2', 'user3', 'user4'],
      comments: [],
    ),
    Review(
      id: '2',
      userId: 'user2',
      userName: 'ProGamer',
      userAvatar: 'https://example.com/avatar2.jpg',
      mapId: '8',
      mapName: 'Revelations',
      rating: 4.5,
      comment: 'El mapa final que conecta todo. Un poco confuso al principio pero muy satisfactorio cuando entiendes la mecánica.',
      date: DateTime.now().subtract(const Duration(days: 5)),
      likes: ['user1', 'user5'],
      comments: [],
    ),
    Review(
      id: '3',
      userId: 'user3',
      userName: 'MapHunter',
      userAvatar: 'https://example.com/avatar3.jpg',
      mapId: '4',
      mapName: 'The Giant',
      rating: 4.8,
      comment: 'Clásico remasterizado. Der Riese nunca falla. Perfecto para jugar con amigos y practicar estrategias.',
      date: DateTime.now().subtract(const Duration(days: 7)),
      likes: ['user1', 'user2', 'user4', 'user6'],
      comments: [],
    ),
    Review(
      id: '4',
      userId: 'user4',
      userName: 'EasterEggKing',
      userAvatar: 'https://example.com/avatar4.jpg',
      mapId: '10',
      mapName: 'Origins',
      rating: 5.0,
      comment: 'El mapa que cambió todo. La introducción de los gigantes y la mecánica de los robots es revolucionaria. ¡Increíble!',
      date: DateTime.now().subtract(const Duration(days: 10)),
      likes: ['user1', 'user2', 'user3', 'user5', 'user7'],
      comments: [],
    ),
    Review(
      id: '5',
      userId: 'user5',
      userName: 'ZombieSlayer',
      userAvatar: 'https://example.com/avatar5.jpg',
      mapId: '6',
      mapName: 'Zetsubou No Shima',
      rating: 3.5,
      comment: 'Mapa interesante pero muy difícil. La mecánica de las plantas es única pero puede ser frustrante para principiantes.',
      date: DateTime.now().subtract(const Duration(days: 12)),
      likes: ['user2'],
      comments: [],
    ),
    Review(
      id: '6',
      userId: 'user6',
      userName: 'MapCollector',
      userAvatar: 'https://example.com/avatar6.jpg',
      mapId: '11',
      mapName: 'Kino der Toten',
      rating: 4.7,
      comment: 'El teatro clásico. Perfecto para aprender las mecánicas básicas. La música y la ambientación son icónicas.',
      date: DateTime.now().subtract(const Duration(days: 15)),
      likes: ['user1', 'user3', 'user4'],
      comments: [],
    ),
    Review(
      id: '7',
      userId: 'user7',
      userName: 'ZombieVeteran',
      userAvatar: 'https://example.com/avatar7.jpg',
      mapId: '12',
      mapName: 'Moon',
      rating: 4.9,
      comment: 'El mapa más épico de la saga. La gravedad cero y el Easter Egg final son inolvidables. ¡Una obra maestra!',
      date: DateTime.now().subtract(const Duration(days: 18)),
      likes: ['user1', 'user2', 'user4', 'user5', 'user6'],
      comments: [],
    ),
    Review(
      id: '8',
      userId: 'user8',
      userName: 'MapExplorer',
      userAvatar: 'https://example.com/avatar8.jpg',
      mapId: '7',
      mapName: 'Gorod Krovi',
      rating: 4.3,
      comment: 'Ambientación de guerra muy bien lograda. El dragón es impresionante pero el mapa puede ser un poco caótico.',
      date: DateTime.now().subtract(const Duration(days: 20)),
      likes: ['user1', 'user3'],
      comments: [],
    ),
  ];

  Future<List<Review>> getAllReviews() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _reviews;
  }

  Future<Review> addReview(Review review) async {
    await Future.delayed(const Duration(milliseconds: 800));
    _reviews.insert(0, review);
    return review;
  }

  Future<void> likeReview(String reviewId, String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final reviewIndex = _reviews.indexWhere((review) => review.id == reviewId);
    if (reviewIndex != -1) {
      final review = _reviews[reviewIndex];
      final updatedLikes = List<String>.from(review.likes);
      if (updatedLikes.contains(userId)) {
        updatedLikes.remove(userId);
      } else {
        updatedLikes.add(userId);
      }
      _reviews[reviewIndex] = review.copyWith(likes: updatedLikes);
    }
  }

  Future<void> addComment(String reviewId, ReviewComment comment) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final reviewIndex = _reviews.indexWhere((review) => review.id == reviewId);
    if (reviewIndex != -1) {
      final review = _reviews[reviewIndex];
      final updatedComments = List<ReviewComment>.from(review.comments);
      updatedComments.add(comment);
      _reviews[reviewIndex] = review.copyWith(comments: updatedComments);
    }
  }
}
