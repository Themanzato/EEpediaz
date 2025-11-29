import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseReview {
  final String id;
  final String usuarioId;
  final String nombreUsuario;
  final String avatarUsuario;
  final String mapaId;
  final String nombreMapa;
  final double rating;
  final String comentario;
  final DateTime fechaCreacion;
  final DateTime fechaActualizacion;
  final List<String> likes;
  final List<Map<String, dynamic>> comentarios;
  final bool activo;

  const FirebaseReview({
    required this.id,
    required this.usuarioId,
    required this.nombreUsuario,
    required this.avatarUsuario,
    required this.mapaId,
    required this.nombreMapa,
    required this.rating,
    required this.comentario,
    required this.fechaCreacion,
    required this.fechaActualizacion,
    required this.likes,
    required this.comentarios,
    required this.activo,
  });

  factory FirebaseReview.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FirebaseReview(
      id: doc.id,
      usuarioId: data['usuarioId'] ?? '',
      nombreUsuario: data['nombreUsuario'] ?? '',
      avatarUsuario: data['avatarUsuario'] ?? '',
      mapaId: data['mapaId'] ?? '',
      nombreMapa: data['nombreMapa'] ?? '',
      rating: (data['rating'] ?? 0.0).toDouble(),
      comentario: data['comentario'] ?? '',
      fechaCreacion: (data['fechaCreacion'] as Timestamp).toDate(),
      fechaActualizacion: (data['fechaActualizacion'] as Timestamp).toDate(),
      likes: List<String>.from(data['likes'] ?? []),
      comentarios: List<Map<String, dynamic>>.from(data['comentarios'] ?? []),
      activo: data['activo'] ?? true,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'usuarioId': usuarioId,
      'nombreUsuario': nombreUsuario,
      'avatarUsuario': avatarUsuario,
      'mapaId': mapaId,
      'nombreMapa': nombreMapa,
      'rating': rating,
      'comentario': comentario,
      'fechaCreacion': Timestamp.fromDate(fechaCreacion),
      'fechaActualizacion': Timestamp.fromDate(fechaActualizacion),
      'likes': likes,
      'comentarios': comentarios,
      'activo': activo,
    };
  }

  FirebaseReview copyWith({
    String? id,
    String? usuarioId,
    String? nombreUsuario,
    String? avatarUsuario,
    String? mapaId,
    String? nombreMapa,
    double? rating,
    String? comentario,
    DateTime? fechaCreacion,
    DateTime? fechaActualizacion,
    List<String>? likes,
    List<Map<String, dynamic>>? comentarios,
    bool? activo,
  }) {
    return FirebaseReview(
      id: id ?? this.id,
      usuarioId: usuarioId ?? this.usuarioId,
      nombreUsuario: nombreUsuario ?? this.nombreUsuario,
      avatarUsuario: avatarUsuario ?? this.avatarUsuario,
      mapaId: mapaId ?? this.mapaId,
      nombreMapa: nombreMapa ?? this.nombreMapa,
      rating: rating ?? this.rating,
      comentario: comentario ?? this.comentario,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
      fechaActualizacion: fechaActualizacion ?? this.fechaActualizacion,
      likes: likes ?? this.likes,
      comentarios: comentarios ?? this.comentarios,
      activo: activo ?? this.activo,
    );
  }
}
