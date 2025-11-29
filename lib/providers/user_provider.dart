import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../services/user_service.dart';

final userServiceProvider = Provider<UserService>((ref) => UserService());

final currentUserProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier(ref.read(userServiceProvider));
});

final userStatsProvider = FutureProvider<UserStats?>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return null;
  
  final userService = ref.read(userServiceProvider);
  return await userService.getUserStats(user.id);
});

class UserNotifier extends StateNotifier<User?> {
  final UserService _userService;

  UserNotifier(this._userService) : super(null);

  Future<void> login(String email, String password) async {
    try {
      final user = await _userService.login(email, password);
      state = user;
    } catch (e) {
      // Handle error
      rethrow;
    }
  }

  Future<void> register(String username, String email, String password) async {
    try {
      final user = await _userService.register(username, email, password);
      state = user;
    } catch (e) {
      // Handle error
      rethrow;
    }
  }

  Future<void> logout() async {
    await _userService.logout();
    state = null;
  }

  Future<void> updateProfile(User user) async {
    try {
      final updatedUser = await _userService.updateProfile(user);
      state = updatedUser;
    } catch (e) {
      // Handle error
      rethrow;
    }
  }

  Future<void> addFavoriteMap(String mapId) async {
    if (state != null) {
      final updatedUser = await _userService.addFavoriteMap(state!.id, mapId);
      state = updatedUser;
    }
  }

  Future<void> removeFavoriteMap(String mapId) async {
    if (state != null) {
      final updatedUser = await _userService.removeFavoriteMap(state!.id, mapId);
      state = updatedUser;
    }
  }

  Future<void> markEECompleted(String eeId) async {
    if (state != null) {
      final updatedUser = await _userService.markEECompleted(state!.id, eeId);
      state = updatedUser;
    }
  }
}
