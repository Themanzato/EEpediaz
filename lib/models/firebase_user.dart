import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUser {
  final String id;
  final String nombreUsuario;
  final String email;
  final String avatar;
  final DateTime fechaRegistro;
  final DateTime ultimaActividad;
  final int nivel;
  final int experiencia;
  final List<String> mapasFavoritos;
  final List<String> easterEggsCompletados;
  final Map<String, dynamic> estadisticas;
  final bool activo;
  final String rol;

  const FirebaseUser({
    required this.id,
    required this.nombreUsuario,
    required this.email,
    required this.avatar,
    required this.fechaRegistro,
    required this.ultimaActividad,
    required this.nivel,
    required this.experiencia,
    required this.mapasFavoritos,
    required this.easterEggsCompletados,
    required this.estadisticas,
    required this.activo,
    required this.rol,
  });

  factory FirebaseUser.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FirebaseUser(
      id: doc.id,
      nombreUsuario: data['nombreUsuario'] ?? '',
      email: data['email'] ?? '',
      avatar: data['avatar'] ?? '',
      fechaRegistro: (data['fechaRegistro'] as Timestamp).toDate(),
      ultimaActividad: (data['ultimaActividad'] as Timestamp).toDate(),
      nivel: data['nivel'] ?? 1,
      experiencia: data['experiencia'] ?? 0,
      mapasFavoritos: List<String>.from(data['mapasFavoritos'] ?? []),
      easterEggsCompletados: List<String>.from(data['easterEggsCompletados'] ?? []),
      estadisticas: Map<String, dynamic>.from(data['estadisticas'] ?? {}),
      activo: data['activo'] ?? true,
      rol: data['rol'] ?? 'usuario',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'nombreUsuario': nombreUsuario,
      'email': email,
      'avatar': avatar,
      'fechaRegistro': Timestamp.fromDate(fechaRegistro),
      'ultimaActividad': Timestamp.fromDate(ultimaActividad),
      'nivel': nivel,
      'experiencia': experiencia,
      'mapasFavoritos': mapasFavoritos,
      'easterEggsCompletados': easterEggsCompletados,
      'estadisticas': estadisticas,
      'activo': activo,
      'rol': rol,
    };
  }

  FirebaseUser copyWith({
    String? id,
    String? nombreUsuario,
    String? email,
    String? avatar,
    DateTime? fechaRegistro,
    DateTime? ultimaActividad,
    int? nivel,
    int? experiencia,
    List<String>? mapasFavoritos,
    List<String>? easterEggsCompletados,
    Map<String, dynamic>? estadisticas,
    bool? activo,
    String? rol,
  }) {
    return FirebaseUser(
      id: id ?? this.id,
      nombreUsuario: nombreUsuario ?? this.nombreUsuario,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      fechaRegistro: fechaRegistro ?? this.fechaRegistro,
      ultimaActividad: ultimaActividad ?? this.ultimaActividad,
      nivel: nivel ?? this.nivel,
      experiencia: experiencia ?? this.experiencia,
      mapasFavoritos: mapasFavoritos ?? this.mapasFavoritos,
      easterEggsCompletados: easterEggsCompletados ?? this.easterEggsCompletados,
      estadisticas: estadisticas ?? this.estadisticas,
      activo: activo ?? this.activo,
      rol: rol ?? this.rol,
    );
  }
}
