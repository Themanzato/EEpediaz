import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';

// Provider del servicio de autenticación
final authServiceProvider = Provider<AuthService>((ref) => AuthService());

// Provider del usuario actual
final authStateProvider = StreamProvider<String?>((ref) {
  final authService = ref.read(authServiceProvider);
  return authService.authStateChanges;
});

// Provider del usuario actual (sincrónico)
final currentUserProvider = Provider<String?>((ref) {
  final authService = ref.read(authServiceProvider);
  return authService.currentUser;
});

// Provider para datos del usuario desde Firestore
final userDataProvider = FutureProvider.family<Map<String, dynamic>?, String>((ref, uid) async {
  final authService = ref.read(authServiceProvider);
  return await authService.getUserData(uid);
});

// Notifier para operaciones de autenticación
class AuthNotifier extends StateNotifier<AsyncValue<String?>> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(const AsyncValue.data(null)) {
    _init();
  }

  void _init() {
    _authService.authStateChanges.listen((userId) {
      state = AsyncValue.data(userId);
    });
  }

  Future<void> signInWithGoogle() async {
    try {
      state = const AsyncValue.loading();
      final userId = await _authService.signInWithGoogle();
      state = AsyncValue.data(userId);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> signInAsGuest() async {
    try {
      state = const AsyncValue.loading();
      final userId = await _authService.signInAsGuest();
      state = AsyncValue.data(userId);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> deleteAccount() async {
    try {
      await _authService.deleteAccount();
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AsyncValue<String?>>((ref) {
  return AuthNotifier(ref.read(authServiceProvider));
});
