import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseMapa {
  final String id;
  final String nombre;
  final String juegoId;
  final String descripcion;
  final String imagenUrl;
  final double rating;
  final int totalResenas;
  final DateTime fechaCreacion;
  final DateTime fechaActualizacion;
  final List<String> easterEggs;
  final List<String> partesEscudo;
  final List<String> easterEggsSecundarios;
  final Map<String, dynamic> ubicacion;
  final bool activo;

  const FirebaseMapa({
    required this.id,
    required this.nombre,
    required this.juegoId,
    required this.descripcion,
    required this.imagenUrl,
    required this.rating,
    required this.totalResenas,
    required this.fechaCreacion,
    required this.fechaActualizacion,
    required this.easterEggs,
    required this.partesEscudo,
    required this.easterEggsSecundarios,
    required this.ubicacion,
    required this.activo,
  });

  factory FirebaseMapa.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FirebaseMapa(
      id: doc.id,
      nombre: data['nombre'] ?? '',
      juegoId: data['juegoId'] ?? '',
      descripcion: data['descripcion'] ?? '',
      imagenUrl: data['imagenUrl'] ?? '',
      rating: (data['rating'] ?? 0.0).toDouble(),
      totalResenas: data['totalResenas'] ?? 0,
      fechaCreacion: (data['fechaCreacion'] as Timestamp).toDate(),
      fechaActualizacion: (data['fechaActualizacion'] as Timestamp).toDate(),
      easterEggs: List<String>.from(data['easterEggs'] ?? []),
      partesEscudo: List<String>.from(data['partesEscudo'] ?? []),
      easterEggsSecundarios: List<String>.from(data['easterEggsSecundarios'] ?? []),
      ubicacion: Map<String, dynamic>.from(data['ubicacion'] ?? {}),
      activo: data['activo'] ?? true,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'nombre': nombre,
      'juegoId': juegoId,
      'descripcion': descripcion,
      'imagenUrl': imagenUrl,
      'rating': rating,
      'totalResenas': totalResenas,
      'fechaCreacion': Timestamp.fromDate(fechaCreacion),
      'fechaActualizacion': Timestamp.fromDate(fechaActualizacion),
      'easterEggs': easterEggs,
      'partesEscudo': partesEscudo,
      'easterEggsSecundarios': easterEggsSecundarios,
      'ubicacion': ubicacion,
      'activo': activo,
    };
  }

  FirebaseMapa copyWith({
    String? id,
    String? nombre,
    String? juegoId,
    String? descripcion,
    String? imagenUrl,
    double? rating,
    int? totalResenas,
    DateTime? fechaCreacion,
    DateTime? fechaActualizacion,
    List<String>? easterEggs,
    List<String>? partesEscudo,
    List<String>? easterEggsSecundarios,
    Map<String, dynamic>? ubicacion,
    bool? activo,
  }) {
    return FirebaseMapa(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      juegoId: juegoId ?? this.juegoId,
      descripcion: descripcion ?? this.descripcion,
      imagenUrl: imagenUrl ?? this.imagenUrl,
      rating: rating ?? this.rating,
      totalResenas: totalResenas ?? this.totalResenas,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
      fechaActualizacion: fechaActualizacion ?? this.fechaActualizacion,
      easterEggs: easterEggs ?? this.easterEggs,
      partesEscudo: partesEscudo ?? this.partesEscudo,
      easterEggsSecundarios: easterEggsSecundarios ?? this.easterEggsSecundarios,
      ubicacion: ubicacion ?? this.ubicacion,
      activo: activo ?? this.activo,
    );
  }
}
