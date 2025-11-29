import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Usuario actual simulado
  String? _currentUserId;
  
  // Stream del usuario actual
  Stream<String?> get authStateChanges => Stream.value(_currentUserId);

  // Usuario actual
  String? get currentUser => _currentUserId;

  // Iniciar sesión simulado
  Future<String?> signInWithGoogle() async {
    try {
      // Simular login exitoso
      _currentUserId = 'demo_user_123';
      
      // Intentar crear documento en Firestore, pero no fallar si no hay conexión
      try {
        await _createOrUpdateUserDocument(_currentUserId!);
        print('Google login successful with Firestore');
      } catch (e) {
        print('Firestore offline, continuing with Google: $e');
        // Continuar sin Firestore si no hay conexión
      }
      
      return _currentUserId;
    } catch (e) {
      print('Error signing in: $e');
      rethrow;
    }
  }

  // Iniciar sesión como invitado
  Future<String?> signInAsGuest() async {
    try {
      // Simular login como invitado - SIN Firestore
      _currentUserId = 'guest_user_456';
      
      // NO intentar conectar con Firestore para invitados
      print('Guest login successful - no Firestore needed');
      
      return _currentUserId;
    } catch (e) {
      print('Error signing in as guest: $e');
      rethrow;
    }
  }

  // Crear o actualizar documento del usuario en Firestore
  Future<void> _createOrUpdateUserDocument(String userId) async {
    try {
      final userDoc = _firestore.collection('users').doc(userId);
      final docSnapshot = await userDoc.get();
      
      if (!docSnapshot.exists) {
        // Crear nuevo usuario
        await userDoc.set({
          'uid': userId,
          'email': 'demo@example.com',
          'displayName': 'Demo User',
          'photoURL': null,
          'createdAt': FieldValue.serverTimestamp(),
          'lastSignIn': FieldValue.serverTimestamp(),
          'level': 1,
          'experience': 0,
          'favoriteMaps': [],
          'completedEasterEggs': [],
          'isGuest': false,
          'stats': {
            'gamesPlayed': 0,
            'easterEggsCompleted': 0,
            'reviewsWritten': 0,
            'likesReceived': 0,
          },
        });
      } else {
        // Actualizar último inicio de sesión
        await userDoc.update({
          'lastSignIn': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print('Error creating/updating user document: $e');
    }
  }

  // Crear o actualizar documento del usuario invitado en Firestore
  Future<void> _createOrUpdateGuestDocument(String userId) async {
    try {
      final userDoc = _firestore.collection('users').doc(userId);
      final docSnapshot = await userDoc.get();
      
      if (!docSnapshot.exists) {
        // Crear nuevo usuario invitado
        await userDoc.set({
          'uid': userId,
          'email': null,
          'displayName': 'Invitado',
          'photoURL': null,
          'createdAt': FieldValue.serverTimestamp(),
          'lastSignIn': FieldValue.serverTimestamp(),
          'level': 1,
          'experience': 0,
          'favoriteMaps': [],
          'completedEasterEggs': [],
          'isGuest': true,
          'stats': {
            'gamesPlayed': 0,
            'easterEggsCompleted': 0,
            'reviewsWritten': 0,
            'likesReceived': 0,
          },
        });
      } else {
        // Actualizar último inicio de sesión
        await userDoc.update({
          'lastSignIn': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print('Error creating/updating guest document: $e');
    }
  }

  // Cerrar sesión
  Future<void> signOut() async {
    try {
      _currentUserId = null;
    } catch (e) {
      print('Error signing out: $e');
      rethrow;
    }
  }

  // Eliminar cuenta
  Future<void> deleteAccount() async {
    try {
      if (_currentUserId != null) {
        // Eliminar datos del usuario en Firestore
        await _firestore.collection('users').doc(_currentUserId).delete();
        _currentUserId = null;
      }
    } catch (e) {
      print('Error deleting account: $e');
      rethrow;
    }
  }

  // Obtener datos del usuario desde Firestore
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      return doc.exists ? doc.data() : null;
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

  // Actualizar datos del usuario
  Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(uid).update(data);
    } catch (e) {
      print('Error updating user data: $e');
      rethrow;
    }
  }
}
