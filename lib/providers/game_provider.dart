import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/game.dart';
import '../services/game_service.dart';

final gameServiceProvider = Provider<GameService>((ref) => GameService());

final gamesProvider = FutureProvider<List<Game>>((ref) async {
  final gameService = ref.read(gameServiceProvider);
  return await gameService.getAllGames();
});

final gameByIdProvider = FutureProvider.family<Game?, String>((ref, gameId) async {
  final gameService = ref.read(gameServiceProvider);
  return await gameService.getGameById(gameId);
});

final featuredGamesProvider = FutureProvider<List<Game>>((ref) async {
  final gameService = ref.read(gameServiceProvider);
  return await gameService.getFeaturedGames();
});
