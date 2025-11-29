import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../providers/game_provider.dart';
import '../../providers/map_provider.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/game_card.dart';
import 'map_detail_screen.dart';

class MapasView extends ConsumerStatefulWidget {
  const MapasView({super.key});

  @override
  ConsumerState<MapasView> createState() => _MapasViewState();
}

class _MapasViewState extends ConsumerState<MapasView> {
  String? _selectedGameId;
  String? _selectedGameName;

  @override
  Widget build(BuildContext context) {
    final gamesAsync = ref.watch(gamesProvider);
    final mapsAsync = _selectedGameId != null
        ? ref.watch(mapsByGameProvider(_selectedGameId!))
        : ref.watch(mapsProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: _selectedGameName ?? 'Mapas de Zombies',
        showBackButton: _selectedGameId != null,
        onBackPressed: _selectedGameId != null
            ? () {
                setState(() {
                  _selectedGameId = null;
                  _selectedGameName = null;
                });
              }
            : null,
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
            onPressed: () {
              _showSearchDialog(context);
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // Carrusel de juegos
          if (_selectedGameId == null) ...[
            Container(
              height: 200,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: gamesAsync.when(
                data: (games) => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: games.length,
                  itemBuilder: (context, index) {
                    final game = games[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        right: index < games.length - 1 ? 12 : 0,
                      ),
                      child: SizedBox(
                        width: 280,
                        child: GameCard(
                          game: game,
                          onTap: () {
                            setState(() {
                              _selectedGameId = game.id;
                              _selectedGameName = game.name;
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Text('Error: $error'),
                ),
              ),
            ),
            
            // Indicador de selección
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.gamepad,
                    size: 16,
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Selecciona un juego para ver sus mapas',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
          ],
          
          // Grid de mapas
          Expanded(
            child: mapsAsync.when(
              data: (maps) {
                if (maps.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.map,
                          size: 64,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _selectedGameId == null
                              ? 'Selecciona un juego para ver sus mapas'
                              : 'No hay mapas disponibles',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _selectedGameId == null
                              ? 'Los mapas aparecerán aquí'
                              : 'Intenta con otro juego',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  );
                }
                
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: maps.length,
                  itemBuilder: (context, index) {
                    final map = maps[index];
                    return _buildMapGridItem(context, map);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.triangleExclamation,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error al cargar mapas',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      error.toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapGridItem(BuildContext context, map) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MapDetailScreen(map: map),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del mapa
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).colorScheme.primary.withOpacity(0.8),
                      Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: FaIcon(
                        FontAwesomeIcons.map,
                        size: 40,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.star,
                              size: 10,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              map.rating.toStringAsFixed(1),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Contenido
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      map.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Expanded(
                      child: Text(
                        map.description,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.users,
                          size: 10,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${map.totalReviews}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const Spacer(),
                        FaIcon(
                          FontAwesomeIcons.chevronRight,
                          size: 10,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Buscar Mapas'),
        content: const TextField(
          decoration: InputDecoration(
            hintText: 'Nombre del mapa...',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Implementar búsqueda
            },
            child: const Text('Buscar'),
          ),
        ],
      ),
    );
  }
}
