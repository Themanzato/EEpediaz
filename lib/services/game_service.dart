import '../models/game.dart';

class GameService {
  // Simulación de datos - en una app real esto vendría de una API
  final List<Game> _games = [
    Game(
      id: '1',
      name: 'Call of Duty: Black Ops Cold War',
      description: 'El último juego de la serie Black Ops con mapas de zombies épicos',
      imageUrl: 'https://example.com/coldwar.jpg',
      maps: ['Die Maschine', 'Firebase Z', 'Mauer der Toten', 'Forsaken'],
      releaseDate: DateTime(2020, 11, 13),
    ),
    Game(
      id: '2',
      name: 'Call of Duty: Black Ops 4',
      description: 'Black Ops 4 con el modo zombies clásico',
      imageUrl: 'https://example.com/bo4.jpg',
      maps: ['IX', 'Voyage of Despair', 'Blood of the Dead', 'Classified'],
      releaseDate: DateTime(2018, 10, 12),
    ),
    Game(
      id: '3',
      name: 'Call of Duty: Black Ops 3',
      description: 'La experiencia zombies más completa con mapas icónicos',
      imageUrl: 'https://example.com/bo3.jpg',
      maps: ['The Giant', 'Der Eisendrache', 'Zetsubou No Shima', 'Gorod Krovi', 'Revelations'],
      releaseDate: DateTime(2015, 11, 6),
    ),
    Game(
      id: '4',
      name: 'Call of Duty: Black Ops 2',
      description: 'Zombies con múltiples historias y mapas únicos',
      imageUrl: 'https://example.com/bo2.jpg',
      maps: ['TranZit', 'Die Rise', 'Buried', 'Origins'],
      releaseDate: DateTime(2012, 11, 13),
    ),
    Game(
      id: '5',
      name: 'Call of Duty: Black Ops',
      description: 'El origen de la saga zombies con mapas clásicos',
      imageUrl: 'https://example.com/bo1.jpg',
      maps: ['Kino der Toten', 'Five', 'Ascension', 'Call of the Dead', 'Shangri-La', 'Moon'],
      releaseDate: DateTime(2010, 11, 9),
    ),
    Game(
      id: '6',
      name: 'Call of Duty: WWII',
      description: 'Zombies en la Segunda Guerra Mundial',
      imageUrl: 'https://example.com/wwii.jpg',
      maps: ['The Final Reich', 'The Darkest Shore', 'The Shadowed Throne', 'The Tortured Path'],
      releaseDate: DateTime(2017, 11, 3),
    ),
  ];

  Future<List<Game>> getAllGames() async {
    // Simular delay de red
    await Future.delayed(const Duration(milliseconds: 500));
    return _games;
  }

  Future<Game?> getGameById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _games.firstWhere((game) => game.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<Game>> getFeaturedGames() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _games.take(2).toList();
  }
}
