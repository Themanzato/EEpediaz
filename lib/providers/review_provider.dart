import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/review.dart';
import '../services/review_service.dart';

final reviewServiceProvider = Provider<ReviewService>((ref) => ReviewService());

final reviewsProvider = FutureProvider<List<Review>>((ref) async {
  final reviewService = ref.read(reviewServiceProvider);
  return await reviewService.getAllReviews();
});

final reviewNotifierProvider = StateNotifierProvider<ReviewNotifier, List<Review>>((ref) {
  return ReviewNotifier(ref.read(reviewServiceProvider));
});

class ReviewNotifier extends StateNotifier<List<Review>> {
  final ReviewService _reviewService;

  ReviewNotifier(this._reviewService) : super([]) {
    _loadReviews();
  }

  Future<void> _loadReviews() async {
    try {
      final reviews = await _reviewService.getAllReviews();
      state = reviews;
    } catch (e) {
      // Handle error
      state = [];
    }
  }

  Future<void> addReview(Review review) async {
    try {
      final newReview = await _reviewService.addReview(review);
      state = [newReview, ...state];
    } catch (e) {
      // Handle error
      rethrow;
    }
  }

  Future<void> likeReview(String reviewId, String userId) async {
    try {
      await _reviewService.likeReview(reviewId, userId);
      state = state.map((review) {
        if (review.id == reviewId) {
          final updatedLikes = List<String>.from(review.likes);
          if (updatedLikes.contains(userId)) {
            updatedLikes.remove(userId);
          } else {
            updatedLikes.add(userId);
          }
          return review.copyWith(likes: updatedLikes);
        }
        return review;
      }).toList();
    } catch (e) {
      // Handle error
      rethrow;
    }
  }

  Future<void> addComment(String reviewId, ReviewComment comment) async {
    try {
      await _reviewService.addComment(reviewId, comment);
      state = state.map((review) {
        if (review.id == reviewId) {
          final updatedComments = List<ReviewComment>.from(review.comments);
          updatedComments.add(comment);
          return review.copyWith(comments: updatedComments);
        }
        return review;
      }).toList();
    } catch (e) {
      // Handle error
      rethrow;
    }
  }
}
