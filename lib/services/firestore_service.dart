import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/firebase_mapa.dart';
import '../models/firebase_easter_egg.dart';
import '../models/firebase_review.dart';
import '../models/firebase_user.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ========== MAPAS ==========
  
  /// Obtener todos los mapas
  Future<List<FirebaseMapa>> getMapas() async {
    try {
      final querySnapshot = await _firestore
          .collection('mapas')
          .where('activo', isEqualTo: true)
          .orderBy('fechaCreacion', descending: true)
          .get();
      
      return querySnapshot.docs
          .map((doc) => FirebaseMapa.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Error al obtener mapas: $e');
    }
  }

  /// Obtener mapas por juego
  Future<List<FirebaseMapa>> getMapasPorJuego(String juegoId) async {
    try {
      final querySnapshot = await _firestore
          .collection('mapas')
          .where('juegoId', isEqualTo: juegoId)
          .where('activo', isEqualTo: true)
          .orderBy('fechaCreacion', descending: true)
          .get();
      
      return querySnapshot.docs
          .map((doc) => FirebaseMapa.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Error al obtener mapas por juego: $e');
    }
  }

  /// Obtener un mapa por ID
  Future<FirebaseMapa?> getMapaPorId(String id) async {
    try {
      final doc = await _firestore.collection('mapas').doc(id).get();
      if (doc.exists) {
        return FirebaseMapa.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Error al obtener mapa: $e');
    }
  }

  /// Crear un nuevo mapa
  Future<String> crearMapa(FirebaseMapa mapa) async {
    try {
      final docRef = await _firestore.collection('mapas').add(mapa.toFirestore());
      return docRef.id;
    } catch (e) {
      throw Exception('Error al crear mapa: $e');
    }
  }

  /// Actualizar un mapa
  Future<void> actualizarMapa(String id, FirebaseMapa mapa) async {
    try {
      await _firestore.collection('mapas').doc(id).update(mapa.toFirestore());
    } catch (e) {
      throw Exception('Error al actualizar mapa: $e');
    }
  }

  /// Eliminar un mapa (soft delete)
  Future<void> eliminarMapa(String id) async {
    try {
      await _firestore.collection('mapas').doc(id).update({'activo': false});
    } catch (e) {
      throw Exception('Error al eliminar mapa: $e');
    }
  }

  // ========== EASTER EGGS ==========
  
  /// Obtener Easter Eggs por mapa
  Future<List<FirebaseEasterEgg>> getEasterEggsPorMapa(String mapaId) async {
    try {
      final querySnapshot = await _firestore
          .collection('easterEggs')
          .where('mapaId', isEqualTo: mapaId)
          .where('activo', isEqualTo: true)
          .orderBy('fechaCreacion', descending: true)
          .get();
      
      return querySnapshot.docs
          .map((doc) => FirebaseEasterEgg.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Error al obtener Easter Eggs: $e');
    }
  }

  /// Crear un nuevo Easter Egg
  Future<String> crearEasterEgg(FirebaseEasterEgg easterEgg) async {
    try {
      final docRef = await _firestore.collection('easterEggs').add(easterEgg.toFirestore());
      return docRef.id;
    } catch (e) {
      throw Exception('Error al crear Easter Egg: $e');
    }
  }

  /// Actualizar un Easter Egg
  Future<void> actualizarEasterEgg(String id, FirebaseEasterEgg easterEgg) async {
    try {
      await _firestore.collection('easterEggs').doc(id).update(easterEgg.toFirestore());
    } catch (e) {
      throw Exception('Error al actualizar Easter Egg: $e');
    }
  }

  // ========== REVIEWS ==========
  
  /// Obtener todas las reseñas
  Future<List<FirebaseReview>> getReviews() async {
    try {
      final querySnapshot = await _firestore
          .collection('reviews')
          .where('activo', isEqualTo: true)
          .orderBy('fechaCreacion', descending: true)
          .get();
      
      return querySnapshot.docs
          .map((doc) => FirebaseReview.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Error al obtener reviews: $e');
    }
  }

  /// Obtener reviews por mapa
  Future<List<FirebaseReview>> getReviewsPorMapa(String mapaId) async {
    try {
      final querySnapshot = await _firestore
          .collection('reviews')
          .where('mapaId', isEqualTo: mapaId)
          .where('activo', isEqualTo: true)
          .orderBy('fechaCreacion', descending: true)
          .get();
      
      return querySnapshot.docs
          .map((doc) => FirebaseReview.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Error al obtener reviews por mapa: $e');
    }
  }

  /// Crear una nueva review
  Future<String> crearReview(FirebaseReview review) async {
    try {
      final docRef = await _firestore.collection('reviews').add(review.toFirestore());
      return docRef.id;
    } catch (e) {
      throw Exception('Error al crear review: $e');
    }
  }

  /// Actualizar una review
  Future<void> actualizarReview(String id, FirebaseReview review) async {
    try {
      await _firestore.collection('reviews').doc(id).update(review.toFirestore());
    } catch (e) {
      throw Exception('Error al actualizar review: $e');
    }
  }

  /// Dar like a una review
  Future<void> darLikeReview(String reviewId, String usuarioId) async {
    try {
      final reviewRef = _firestore.collection('reviews').doc(reviewId);
      await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(reviewRef);
        if (snapshot.exists) {
          final data = snapshot.data()!;
          final likes = List<String>.from(data['likes'] ?? []);
          if (likes.contains(usuarioId)) {
            likes.remove(usuarioId);
          } else {
            likes.add(usuarioId);
          }
          transaction.update(reviewRef, {'likes': likes});
        }
      });
    } catch (e) {
      throw Exception('Error al dar like: $e');
    }
  }

  // ========== USUARIOS ==========
  
  /// Obtener usuario por ID
  Future<FirebaseUser?> getUsuarioPorId(String id) async {
    try {
      final doc = await _firestore.collection('usuarios').doc(id).get();
      if (doc.exists) {
        return FirebaseUser.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Error al obtener usuario: $e');
    }
  }

  /// Crear un nuevo usuario
  Future<String> crearUsuario(FirebaseUser usuario) async {
    try {
      await _firestore.collection('usuarios').doc(usuario.id).set(usuario.toFirestore());
      return usuario.id;
    } catch (e) {
      throw Exception('Error al crear usuario: $e');
    }
  }

  /// Actualizar usuario
  Future<void> actualizarUsuario(String id, FirebaseUser usuario) async {
    try {
      await _firestore.collection('usuarios').doc(id).update(usuario.toFirestore());
    } catch (e) {
      throw Exception('Error al actualizar usuario: $e');
    }
  }

  /// Agregar mapa a favoritos
  Future<void> agregarMapaFavorito(String usuarioId, String mapaId) async {
    try {
      final usuarioRef = _firestore.collection('usuarios').doc(usuarioId);
      await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(usuarioRef);
        if (snapshot.exists) {
          final data = snapshot.data()!;
          final favoritos = List<String>.from(data['mapasFavoritos'] ?? []);
          if (!favoritos.contains(mapaId)) {
            favoritos.add(mapaId);
            transaction.update(usuarioRef, {'mapasFavoritos': favoritos});
          }
        }
      });
    } catch (e) {
      throw Exception('Error al agregar favorito: $e');
    }
  }

  /// Remover mapa de favoritos
  Future<void> removerMapaFavorito(String usuarioId, String mapaId) async {
    try {
      final usuarioRef = _firestore.collection('usuarios').doc(usuarioId);
      await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(usuarioRef);
        if (snapshot.exists) {
          final data = snapshot.data()!;
          final favoritos = List<String>.from(data['mapasFavoritos'] ?? []);
          favoritos.remove(mapaId);
          transaction.update(usuarioRef, {'mapasFavoritos': favoritos});
        }
      });
    } catch (e) {
      throw Exception('Error al remover favorito: $e');
    }
  }

  // ========== STREAMS ==========
  
  /// Stream de mapas en tiempo real
  Stream<List<FirebaseMapa>> getMapasStream() {
    return _firestore
        .collection('mapas')
        .where('activo', isEqualTo: true)
        .orderBy('fechaCreacion', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => FirebaseMapa.fromFirestore(doc))
            .toList());
  }

  /// Stream de reviews en tiempo real
  Stream<List<FirebaseReview>> getReviewsStream() {
    return _firestore
        .collection('reviews')
        .where('activo', isEqualTo: true)
        .orderBy('fechaCreacion', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => FirebaseReview.fromFirestore(doc))
            .toList());
  }

  /// Stream de reviews por mapa
  Stream<List<FirebaseReview>> getReviewsPorMapaStream(String mapaId) {
    return _firestore
        .collection('reviews')
        .where('mapaId', isEqualTo: mapaId)
        .where('activo', isEqualTo: true)
        .orderBy('fechaCreacion', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => FirebaseReview.fromFirestore(doc))
            .toList());
  }
}
