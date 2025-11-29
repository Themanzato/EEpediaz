import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/map.dart';
import '../services/map_service.dart';

final mapServiceProvider = Provider<MapService>((ref) => MapService());

final mapsProvider = FutureProvider<List<ZombieMap>>((ref) async {
  final mapService = ref.read(mapServiceProvider);
  return await mapService.getAllMaps();
});

final mapsByGameProvider = FutureProvider.family<List<ZombieMap>, String>((ref, gameId) async {
  final mapService = ref.read(mapServiceProvider);
  return await mapService.getMapsByGame(gameId);
});

final mapByIdProvider = FutureProvider.family<ZombieMap?, String>((ref, mapId) async {
  final mapService = ref.read(mapServiceProvider);
  return await mapService.getMapById(mapId);
});

final featuredMapsProvider = FutureProvider<List<ZombieMap>>((ref) async {
  final mapService = ref.read(mapServiceProvider);
  return await mapService.getFeaturedMaps();
});

final searchMapsProvider = FutureProvider.family<List<ZombieMap>, String>((ref, query) async {
  final mapService = ref.read(mapServiceProvider);
  return await mapService.searchMaps(query);
});
