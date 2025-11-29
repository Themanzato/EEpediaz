import '../models/map.dart';

class MapService {
  // Simulación de datos - en una app real esto vendría de una API
  final List<ZombieMap> _maps = [
    // Black Ops Cold War
    ZombieMap(
      id: '1',
      name: 'Die Maschine',
      gameId: '1',
      description: 'El primer mapa de Cold War, ambientado en una instalación de pruebas alemana',
      imageUrl: 'https://example.com/die_maschine.jpg',
      easterEggs: [],
      shieldParts: [],
      secondaryEEs: [],
      reviews: [],
      rating: 4.5,
      totalReviews: 150,
    ),
    ZombieMap(
      id: '2',
      name: 'Firebase Z',
      gameId: '1',
      description: 'Una base militar en Vietnam con experimentos de zombies',
      imageUrl: 'https://example.com/firebase_z.jpg',
      easterEggs: [],
      shieldParts: [],
      secondaryEEs: [],
      reviews: [],
      rating: 4.2,
      totalReviews: 120,
    ),
    // Black Ops 4
    ZombieMap(
      id: '3',
      name: 'IX',
      gameId: '2',
      description: 'Una arena romana con gladiadores zombies',
      imageUrl: 'https://example.com/ix.jpg',
      easterEggs: [],
      shieldParts: [],
      secondaryEEs: [],
      reviews: [],
      rating: 4.7,
      totalReviews: 200,
    ),
    // Black Ops 3
    ZombieMap(
      id: '4',
      name: 'The Giant',
      gameId: '3',
      description: 'Remasterización del clásico Der Riese con mejoras visuales',
      imageUrl: 'https://example.com/the_giant.jpg',
      easterEggs: [],
      shieldParts: [],
      secondaryEEs: [],
      reviews: [],
      rating: 4.8,
      totalReviews: 300,
    ),
    ZombieMap(
      id: '5',
      name: 'Der Eisendrache',
      gameId: '3',
      description: 'Un castillo medieval con dragones y magia antigua',
      imageUrl: 'https://example.com/der_eisendrache.jpg',
      easterEggs: [],
      shieldParts: [],
      secondaryEEs: [],
      reviews: [],
      rating: 4.9,
      totalReviews: 450,
    ),
    ZombieMap(
      id: '6',
      name: 'Zetsubou No Shima',
      gameId: '3',
      description: 'Una isla japonesa con experimentos biológicos',
      imageUrl: 'https://example.com/zetsubou_no_shima.jpg',
      easterEggs: [],
      shieldParts: [],
      secondaryEEs: [],
      reviews: [],
      rating: 4.3,
      totalReviews: 180,
    ),
    ZombieMap(
      id: '7',
      name: 'Gorod Krovi',
      gameId: '3',
      description: 'Stalingrado durante la Segunda Guerra Mundial',
      imageUrl: 'https://example.com/gorod_krovi.jpg',
      easterEggs: [],
      shieldParts: [],
      secondaryEEs: [],
      reviews: [],
      rating: 4.6,
      totalReviews: 220,
    ),
    ZombieMap(
      id: '8',
      name: 'Revelations',
      gameId: '3',
      description: 'El mapa final que conecta todas las historias',
      imageUrl: 'https://example.com/revelations.jpg',
      easterEggs: [],
      shieldParts: [],
      secondaryEEs: [],
      reviews: [],
      rating: 4.7,
      totalReviews: 280,
    ),
    // Black Ops 2
    ZombieMap(
      id: '9',
      name: 'TranZit',
      gameId: '4',
      description: 'Un viaje post-apocalíptico en autobús',
      imageUrl: 'https://example.com/tranzit.jpg',
      easterEggs: [],
      shieldParts: [],
      secondaryEEs: [],
      reviews: [],
      rating: 3.8,
      totalReviews: 120,
    ),
    ZombieMap(
      id: '10',
      name: 'Origins',
      gameId: '4',
      description: 'El mapa que cambió todo, ambientado en la Primera Guerra Mundial',
      imageUrl: 'https://example.com/origins.jpg',
      easterEggs: [],
      shieldParts: [],
      secondaryEEs: [],
      reviews: [],
      rating: 4.9,
      totalReviews: 500,
    ),
    // Black Ops 1
    ZombieMap(
      id: '11',
      name: 'Kino der Toten',
      gameId: '5',
      description: 'El teatro clásico donde comenzó todo',
      imageUrl: 'https://example.com/kino_der_toten.jpg',
      easterEggs: [],
      shieldParts: [],
      secondaryEEs: [],
      reviews: [],
      rating: 4.6,
      totalReviews: 350,
    ),
    ZombieMap(
      id: '12',
      name: 'Moon',
      gameId: '5',
      description: 'La luna, el mapa más épico de la saga',
      imageUrl: 'https://example.com/moon.jpg',
      easterEggs: [],
      shieldParts: [],
      secondaryEEs: [],
      reviews: [],
      rating: 4.8,
      totalReviews: 400,
    ),
  ];

  Future<List<ZombieMap>> getAllMaps() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _maps;
  }

  Future<List<ZombieMap>> getMapsByGame(String gameId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _maps.where((map) => map.gameId == gameId).toList();
  }

  Future<ZombieMap?> getMapById(String mapId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _maps.firstWhere((map) => map.id == mapId);
    } catch (e) {
      return null;
    }
  }

  Future<List<ZombieMap>> getFeaturedMaps() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _maps.where((map) => map.rating >= 4.5).toList();
  }

  Future<List<ZombieMap>> searchMaps(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _maps.where((map) => 
      map.name.toLowerCase().contains(query.toLowerCase()) ||
      map.description.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }
}
