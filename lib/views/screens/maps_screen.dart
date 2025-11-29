import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../providers/game_provider.dart';
import '../../providers/map_provider.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/map_card.dart';

class MapsScreen extends ConsumerStatefulWidget {
  const MapsScreen({super.key});

  @override
  ConsumerState<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends ConsumerState<MapsScreen> {
  String _selectedGameId = '';
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final gamesAsync = ref.watch(gamesProvider);
    final mapsAsync = _selectedGameId.isEmpty
        ? ref.watch(mapsProvider)
        : ref.watch(mapsByGameProvider(_selectedGameId));

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Mapas de Zombies',
        actions: [
          Icon(Icons.filter_list),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar mapas...',
                prefixIcon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const FaIcon(FontAwesomeIcons.xmark),
                        onPressed: () {
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          
          // Filtro por juego
          gamesAsync.when(
            data: (games) => SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: games.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: const Text('Todos'),
                        selected: _selectedGameId.isEmpty,
                        onSelected: (selected) {
                          setState(() {
                            _selectedGameId = '';
                          });
                        },
                      ),
                    );
                  }
                  
                  final game = games[index - 1];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(game.name),
                      selected: _selectedGameId == game.id,
                      onSelected: (selected) {
                        setState(() {
                          _selectedGameId = selected ? game.id : '';
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            loading: () => const SizedBox.shrink(),
            error: (error, stack) => const SizedBox.shrink(),
          ),
          
          const SizedBox(height: 16),
          
          // Lista de mapas
          Expanded(
            child: mapsAsync.when(
              data: (maps) {
                final filteredMaps = _searchQuery.isEmpty
                    ? maps
                    : maps.where((map) =>
                        map.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                        map.description.toLowerCase().contains(_searchQuery.toLowerCase())
                      ).toList();
                
                if (filteredMaps.isEmpty) {
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
                          _searchQuery.isEmpty
                              ? 'No hay mapas disponibles'
                              : 'No se encontraron mapas',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _searchQuery.isEmpty
                              ? 'Los mapas aparecerán aquí'
                              : 'Intenta con otros términos de búsqueda',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  );
                }
                
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredMaps.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: MapCard(
                        map: filteredMaps[index],
                        onTap: () {
                          // Navegar a detalles del mapa
                          _showMapDetails(context, filteredMaps[index]);
                        },
                        onFavorite: () {
                          // Agregar a favoritos
                          _toggleFavorite(filteredMaps[index]);
                        },
                      ),
                    );
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

  void _showMapDetails(BuildContext context, map) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    map.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    map.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const FaIcon(FontAwesomeIcons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text('${map.rating} (${map.totalReviews} reseñas)'),
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          // Navegar a vista completa del mapa
                        },
                        icon: const FaIcon(FontAwesomeIcons.arrowRight),
                        label: const Text('Ver Detalles'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleFavorite(map) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${map.name} agregado a favoritos'),
        action: SnackBarAction(
          label: 'Deshacer',
          onPressed: () {},
        ),
      ),
    );
  }
}
