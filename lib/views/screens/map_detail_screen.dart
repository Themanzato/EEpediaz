import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../models/map.dart';
import '../../widgets/custom_app_bar.dart';

class MapDetailScreen extends ConsumerWidget {
  final ZombieMap map;

  const MapDetailScreen({
    super.key,
    required this.map,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        title: map.name,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen principal del mapa
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: FaIcon(
                      FontAwesomeIcons.map,
                      size: 80,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.star,
                            size: 16,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${map.rating} (${map.totalReviews} reseñas)',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
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
            
            // Información del mapa
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    map.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Estadísticas del mapa
                  _buildStatsSection(context),
                  
                  const SizedBox(height: 24),
                  
                  // Easter Eggs
                  _buildEasterEggsSection(context),
                  
                  const SizedBox(height: 24),
                  
                  // Partes del Escudo
                  _buildShieldPartsSection(context),
                  
                  const SizedBox(height: 24),
                  
                  // Easter Eggs Secundarios
                  _buildSecondaryEESection(context),
                  
                  const SizedBox(height: 24),
                  
                  // Reseñas
                  _buildReviewsSection(context),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showAddToFavoritesDialog(context);
        },
        icon: const FaIcon(FontAwesomeIcons.heart),
        label: const Text('Agregar a Favoritos'),
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Estadísticas',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Rating',
                    '${map.rating}',
                    FontAwesomeIcons.star,
                    Colors.amber,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Reseñas',
                    '${map.totalReviews}',
                    FontAwesomeIcons.comments,
                    Colors.blue,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Easter Eggs',
                    '${map.easterEggs.length}',
                    FontAwesomeIcons.egg,
                    Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        FaIcon(
          icon,
          color: color,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildEasterEggsSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.egg,
                  color: Colors.orange,
                ),
                const SizedBox(width: 8),
                Text(
                  'Easter Eggs',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (map.easterEggs.isEmpty)
              Text(
                'No hay Easter Eggs disponibles para este mapa',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
              )
            else
              ...map.easterEggs.map((ee) => _buildEasterEggItem(context, ee)),
          ],
        ),
      ),
    );
  }

  Widget _buildEasterEggItem(BuildContext context, easterEgg) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const FaIcon(
          FontAwesomeIcons.egg,
          color: Colors.orange,
        ),
        title: Text(easterEgg.name),
        subtitle: Text(easterEgg.description),
        trailing: const FaIcon(FontAwesomeIcons.chevronRight),
        onTap: () {
          // Navegar a detalles del Easter Egg
        },
      ),
    );
  }

  Widget _buildShieldPartsSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.shield,
                  color: Colors.blue,
                ),
                const SizedBox(width: 8),
                Text(
                  'Partes del Escudo',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (map.shieldParts.isEmpty)
              Text(
                'No hay partes de escudo disponibles para este mapa',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
              )
            else
              ...map.shieldParts.map((part) => _buildShieldPartItem(context, part)),
          ],
        ),
      ),
    );
  }

  Widget _buildShieldPartItem(BuildContext context, shieldPart) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const FaIcon(
          FontAwesomeIcons.shield,
          color: Colors.blue,
        ),
        title: Text(shieldPart.name),
        subtitle: Text(shieldPart.description),
        trailing: const FaIcon(FontAwesomeIcons.chevronRight),
        onTap: () {
          // Navegar a detalles de la parte del escudo
        },
      ),
    );
  }

  Widget _buildSecondaryEESection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.puzzlePiece,
                  color: Colors.purple,
                ),
                const SizedBox(width: 8),
                Text(
                  'Easter Eggs Secundarios',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (map.secondaryEEs.isEmpty)
              Text(
                'No hay Easter Eggs secundarios disponibles para este mapa',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
              )
            else
              ...map.secondaryEEs.map((ee) => _buildSecondaryEEItem(context, ee)),
          ],
        ),
      ),
    );
  }

  Widget _buildSecondaryEEItem(BuildContext context, secondaryEE) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const FaIcon(
          FontAwesomeIcons.puzzlePiece,
          color: Colors.purple,
        ),
        title: Text(secondaryEE.name),
        subtitle: Text(secondaryEE.description),
        trailing: const FaIcon(FontAwesomeIcons.chevronRight),
        onTap: () {
          // Navegar a detalles del Easter Egg secundario
        },
      ),
    );
  }

  Widget _buildReviewsSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.star,
                  color: Colors.amber,
                ),
                const SizedBox(width: 8),
                Text(
                  'Reseñas',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (map.reviews.isEmpty)
              Text(
                'No hay reseñas disponibles para este mapa',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
              )
            else
              ...map.reviews.map((review) => _buildReviewItem(context, review)),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewItem(BuildContext context, review) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Text(
                    review.userName.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.userName,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          ...List.generate(5, (index) {
                            return FaIcon(
                              FontAwesomeIcons.star,
                              size: 12,
                              color: index < review.rating ? Colors.amber : Colors.grey,
                            );
                          }),
                          const SizedBox(width: 4),
                          Text(
                            '${review.rating}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              review.comment,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  void _showAddToFavoritesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Agregar a Favoritos'),
        content: Text('¿Agregar "${map.name}" a tus favoritos?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${map.name} agregado a favoritos'),
                  action: SnackBarAction(
                    label: 'Deshacer',
                    onPressed: () {},
                  ),
                ),
              );
            },
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
  }
}
