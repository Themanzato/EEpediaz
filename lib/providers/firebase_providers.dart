import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/firestore_service.dart';
import '../models/firebase_mapa.dart';
import '../models/firebase_easter_egg.dart';
import '../models/firebase_review.dart';
import '../models/firebase_user.dart';

// ========== SERVICIOS ==========
final firestoreServiceProvider = Provider<FirestoreService>((ref) => FirestoreService());

// ========== MAPAS ==========
final mapasProvider = FutureProvider<List<FirebaseMapa>>((ref) async {
  final firestoreService = ref.read(firestoreServiceProvider);
  return await firestoreService.getMapas();
});

final mapasStreamProvider = StreamProvider<List<FirebaseMapa>>((ref) {
  final firestoreService = ref.read(firestoreServiceProvider);
  return firestoreService.getMapasStream();
});

final mapasPorJuegoProvider = FutureProvider.family<List<FirebaseMapa>, String>((ref, juegoId) async {
  final firestoreService = ref.read(firestoreServiceProvider);
  return await firestoreService.getMapasPorJuego(juegoId);
});

final mapaPorIdProvider = FutureProvider.family<FirebaseMapa?, String>((ref, id) async {
  final firestoreService = ref.read(firestoreServiceProvider);
  return await firestoreService.getMapaPorId(id);
});

// ========== EASTER EGGS ==========
final easterEggsPorMapaProvider = FutureProvider.family<List<FirebaseEasterEgg>, String>((ref, mapaId) async {
  final firestoreService = ref.read(firestoreServiceProvider);
  return await firestoreService.getEasterEggsPorMapa(mapaId);
});

// ========== REVIEWS ==========
final reviewsProvider = FutureProvider<List<FirebaseReview>>((ref) async {
  final firestoreService = ref.read(firestoreServiceProvider);
  return await firestoreService.getReviews();
});

final reviewsStreamProvider = StreamProvider<List<FirebaseReview>>((ref) {
  final firestoreService = ref.read(firestoreServiceProvider);
  return firestoreService.getReviewsStream();
});

final reviewsPorMapaProvider = FutureProvider.family<List<FirebaseReview>, String>((ref, mapaId) async {
  final firestoreService = ref.read(firestoreServiceProvider);
  return await firestoreService.getReviewsPorMapa(mapaId);
});

final reviewsPorMapaStreamProvider = StreamProvider.family<List<FirebaseReview>, String>((ref, mapaId) {
  final firestoreService = ref.read(firestoreServiceProvider);
  return firestoreService.getReviewsPorMapaStream(mapaId);
});

// ========== USUARIOS ==========
final usuarioPorIdProvider = FutureProvider.family<FirebaseUser?, String>((ref, id) async {
  final firestoreService = ref.read(firestoreServiceProvider);
  return await firestoreService.getUsuarioPorId(id);
});

// ========== NOTIFIERS PARA OPERACIONES ==========

// Notifier para mapas
class MapasNotifier extends StateNotifier<AsyncValue<List<FirebaseMapa>>> {
  final FirestoreService _firestoreService;

  MapasNotifier(this._firestoreService) : super(const AsyncValue.loading()) {
    _loadMapas();
  }

  Future<void> _loadMapas() async {
    try {
      state = const AsyncValue.loading();
      final mapas = await _firestoreService.getMapas();
      state = AsyncValue.data(mapas);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> refresh() async {
    await _loadMapas();
  }

  Future<void> crearMapa(FirebaseMapa mapa) async {
    try {
      await _firestoreService.crearMapa(mapa);
      await _loadMapas();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> actualizarMapa(String id, FirebaseMapa mapa) async {
    try {
      await _firestoreService.actualizarMapa(id, mapa);
      await _loadMapas();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> eliminarMapa(String id) async {
    try {
      await _firestoreService.eliminarMapa(id);
      await _loadMapas();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final mapasNotifierProvider = StateNotifierProvider<MapasNotifier, AsyncValue<List<FirebaseMapa>>>((ref) {
  return MapasNotifier(ref.read(firestoreServiceProvider));
});

// Notifier para reviews
class ReviewsNotifier extends StateNotifier<AsyncValue<List<FirebaseReview>>> {
  final FirestoreService _firestoreService;

  ReviewsNotifier(this._firestoreService) : super(const AsyncValue.loading()) {
    _loadReviews();
  }

  Future<void> _loadReviews() async {
    try {
      state = const AsyncValue.loading();
      final reviews = await _firestoreService.getReviews();
      state = AsyncValue.data(reviews);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> refresh() async {
    await _loadReviews();
  }

  Future<void> crearReview(FirebaseReview review) async {
    try {
      await _firestoreService.crearReview(review);
      await _loadReviews();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> actualizarReview(String id, FirebaseReview review) async {
    try {
      await _firestoreService.actualizarReview(id, review);
      await _loadReviews();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> darLikeReview(String reviewId, String usuarioId) async {
    try {
      await _firestoreService.darLikeReview(reviewId, usuarioId);
      await _loadReviews();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final reviewsNotifierProvider = StateNotifierProvider<ReviewsNotifier, AsyncValue<List<FirebaseReview>>>((ref) {
  return ReviewsNotifier(ref.read(firestoreServiceProvider));
});

// Notifier para usuario actual
class UsuarioNotifier extends StateNotifier<AsyncValue<FirebaseUser?>> {
  final FirestoreService _firestoreService;
  String? _usuarioId;

  UsuarioNotifier(this._firestoreService) : super(const AsyncValue.data(null));

  void setUsuarioId(String usuarioId) {
    _usuarioId = usuarioId;
    _loadUsuario();
  }

  Future<void> _loadUsuario() async {
    if (_usuarioId == null) return;
    
    try {
      state = const AsyncValue.loading();
      final usuario = await _firestoreService.getUsuarioPorId(_usuarioId!);
      state = AsyncValue.data(usuario);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> crearUsuario(FirebaseUser usuario) async {
    try {
      await _firestoreService.crearUsuario(usuario);
      _usuarioId = usuario.id;
      await _loadUsuario();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> actualizarUsuario(FirebaseUser usuario) async {
    try {
      await _firestoreService.actualizarUsuario(usuario.id, usuario);
      await _loadUsuario();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> agregarMapaFavorito(String mapaId) async {
    if (_usuarioId == null) return;
    
    try {
      await _firestoreService.agregarMapaFavorito(_usuarioId!, mapaId);
      await _loadUsuario();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> removerMapaFavorito(String mapaId) async {
    if (_usuarioId == null) return;
    
    try {
      await _firestoreService.removerMapaFavorito(_usuarioId!, mapaId);
      await _loadUsuario();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  void logout() {
    _usuarioId = null;
    state = const AsyncValue.data(null);
  }
}

final usuarioNotifierProvider = StateNotifierProvider<UsuarioNotifier, AsyncValue<FirebaseUser?>>((ref) {
  return UsuarioNotifier(ref.read(firestoreServiceProvider));
});
