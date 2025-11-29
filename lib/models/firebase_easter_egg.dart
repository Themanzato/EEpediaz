import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseEasterEgg {
  final String id;
  final String nombre;
  final String mapaId;
  final String descripcion;
  final String dificultad;
  final int tiempoEstimado;
  final List<String> itemsRequeridos;
  final String imagenUrl;
  final List<Map<String, dynamic>> pasos;
  final DateTime fechaCreacion;
  final DateTime fechaActualizacion;
  final String creadoPor;
  final bool activo;

  const FirebaseEasterEgg({
    required this.id,
    required this.nombre,
    required this.mapaId,
    required this.descripcion,
    required this.dificultad,
    required this.tiempoEstimado,
    required this.itemsRequeridos,
    required this.imagenUrl,
    required this.pasos,
    required this.fechaCreacion,
    required this.fechaActualizacion,
    required this.creadoPor,
    required this.activo,
  });

  factory FirebaseEasterEgg.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FirebaseEasterEgg(
      id: doc.id,
      nombre: data['nombre'] ?? '',
      mapaId: data['mapaId'] ?? '',
      descripcion: data['descripcion'] ?? '',
      dificultad: data['dificultad'] ?? 'Media',
      tiempoEstimado: data['tiempoEstimado'] ?? 0,
      itemsRequeridos: List<String>.from(data['itemsRequeridos'] ?? []),
      imagenUrl: data['imagenUrl'] ?? '',
      pasos: List<Map<String, dynamic>>.from(data['pasos'] ?? []),
      fechaCreacion: (data['fechaCreacion'] as Timestamp).toDate(),
      fechaActualizacion: (data['fechaActualizacion'] as Timestamp).toDate(),
      creadoPor: data['creadoPor'] ?? '',
      activo: data['activo'] ?? true,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'nombre': nombre,
      'mapaId': mapaId,
      'descripcion': descripcion,
      'dificultad': dificultad,
      'tiempoEstimado': tiempoEstimado,
      'itemsRequeridos': itemsRequeridos,
      'imagenUrl': imagenUrl,
      'pasos': pasos,
      'fechaCreacion': Timestamp.fromDate(fechaCreacion),
      'fechaActualizacion': Timestamp.fromDate(fechaActualizacion),
      'creadoPor': creadoPor,
      'activo': activo,
    };
  }

  FirebaseEasterEgg copyWith({
    String? id,
    String? nombre,
    String? mapaId,
    String? descripcion,
    String? dificultad,
    int? tiempoEstimado,
    List<String>? itemsRequeridos,
    String? imagenUrl,
    List<Map<String, dynamic>>? pasos,
    DateTime? fechaCreacion,
    DateTime? fechaActualizacion,
    String? creadoPor,
    bool? activo,
  }) {
    return FirebaseEasterEgg(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      mapaId: mapaId ?? this.mapaId,
      descripcion: descripcion ?? this.descripcion,
      dificultad: dificultad ?? this.dificultad,
      tiempoEstimado: tiempoEstimado ?? this.tiempoEstimado,
      itemsRequeridos: itemsRequeridos ?? this.itemsRequeridos,
      imagenUrl: imagenUrl ?? this.imagenUrl,
      pasos: pasos ?? this.pasos,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
      fechaActualizacion: fechaActualizacion ?? this.fechaActualizacion,
      creadoPor: creadoPor ?? this.creadoPor,
      activo: activo ?? this.activo,
    );
  }
}
