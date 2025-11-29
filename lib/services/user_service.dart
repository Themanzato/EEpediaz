import '../models/user.dart';

class UserService {
  // Simulación de datos - en una app real esto vendría de una API
  User? _currentUser;

  Future<User> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    
    // Simular login exitoso
    _currentUser = User(
      id: '1',
      username: 'ZombieMaster',
      email: email,
      avatar: 'https://example.com/avatar.jpg',
      joinDate: DateTime(2023, 1, 15),
      level: 25,
      experience: 1500,
      favoriteMaps: ['1', '3'],
      completedEEs: ['ee1', 'ee2'],
      stats: const UserStats(
        totalEEsCompleted: 15,
        totalMapsPlayed: 8,
        totalHoursPlayed: 120,
        reviewsWritten: 5,
        commentsWritten: 25,
        likesReceived: 50,
        favoriteGame: 'Call of Duty: Black Ops Cold War',
        favoriteMap: 'Die Maschine',
      ),
    );
    
    return _currentUser!;
  }

  Future<User> register(String username, String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    
    // Simular registro exitoso
    _currentUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      username: username,
      email: email,
      avatar: 'https://example.com/default_avatar.jpg',
      joinDate: DateTime.now(),
      level: 1,
      experience: 0,
      favoriteMaps: [],
      completedEEs: [],
      stats: const UserStats(
        totalEEsCompleted: 0,
        totalMapsPlayed: 0,
        totalHoursPlayed: 0,
        reviewsWritten: 0,
        commentsWritten: 0,
        likesReceived: 0,
        favoriteGame: '',
        favoriteMap: '',
      ),
    );
    
    return _currentUser!;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
  }

  Future<User> updateProfile(User user) async {
    await Future.delayed(const Duration(milliseconds: 800));
    _currentUser = user;
    return user;
  }

  Future<User> addFavoriteMap(String userId, String mapId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (_currentUser != null && _currentUser!.id == userId) {
      final updatedFavorites = List<String>.from(_currentUser!.favoriteMaps);
      if (!updatedFavorites.contains(mapId)) {
        updatedFavorites.add(mapId);
      }
      _currentUser = User(
        id: _currentUser!.id,
        username: _currentUser!.username,
        email: _currentUser!.email,
        avatar: _currentUser!.avatar,
        joinDate: _currentUser!.joinDate,
        level: _currentUser!.level,
        experience: _currentUser!.experience,
        favoriteMaps: updatedFavorites,
        completedEEs: _currentUser!.completedEEs,
        stats: _currentUser!.stats,
      );
    }
    return _currentUser!;
  }

  Future<User> removeFavoriteMap(String userId, String mapId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (_currentUser != null && _currentUser!.id == userId) {
      final updatedFavorites = List<String>.from(_currentUser!.favoriteMaps);
      updatedFavorites.remove(mapId);
      _currentUser = User(
        id: _currentUser!.id,
        username: _currentUser!.username,
        email: _currentUser!.email,
        avatar: _currentUser!.avatar,
        joinDate: _currentUser!.joinDate,
        level: _currentUser!.level,
        experience: _currentUser!.experience,
        favoriteMaps: updatedFavorites,
        completedEEs: _currentUser!.completedEEs,
        stats: _currentUser!.stats,
      );
    }
    return _currentUser!;
  }

  Future<User> markEECompleted(String userId, String eeId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (_currentUser != null && _currentUser!.id == userId) {
      final updatedEEs = List<String>.from(_currentUser!.completedEEs);
      if (!updatedEEs.contains(eeId)) {
        updatedEEs.add(eeId);
      }
      _currentUser = User(
        id: _currentUser!.id,
        username: _currentUser!.username,
        email: _currentUser!.email,
        avatar: _currentUser!.avatar,
        joinDate: _currentUser!.joinDate,
        level: _currentUser!.level + 1, // Subir nivel al completar EE
        experience: _currentUser!.experience + 100,
        favoriteMaps: _currentUser!.favoriteMaps,
        completedEEs: updatedEEs,
        stats: _currentUser!.stats,
      );
    }
    return _currentUser!;
  }

  Future<UserStats?> getUserStats(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _currentUser?.stats;
  }
}
