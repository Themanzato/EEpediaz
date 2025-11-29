import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../widgets/custom_app_bar.dart';

class CommunityScreen extends ConsumerWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Comunidad',
        actions: [
          Icon(Icons.notifications_outlined),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Estadísticas de la comunidad
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.users,
                    size: 40,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Comunidad Activa',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Únete a la discusión y comparte tus experiencias',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Secciones de la comunidad
            Text(
              'Explorar',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            _buildCommunitySection(
              context,
              'Reseñas Recientes',
              'Lee las últimas reseñas de la comunidad',
              FontAwesomeIcons.star,
              () {
                // Navegar a reseñas
              },
            ),
            
            const SizedBox(height: 12),
            
            _buildCommunitySection(
              context,
              'Discusiones',
              'Participa en conversaciones sobre mapas',
              FontAwesomeIcons.comments,
              () {
                // Navegar a discusiones
              },
            ),
            
            const SizedBox(height: 12),
            
            _buildCommunitySection(
              context,
              'Guías de Usuario',
              'Guías creadas por la comunidad',
              FontAwesomeIcons.book,
              () {
                // Navegar a guías
              },
            ),
            
            const SizedBox(height: 12),
            
            _buildCommunitySection(
              context,
              'Logros',
              'Ve los logros de la comunidad',
              FontAwesomeIcons.trophy,
              () {
                // Navegar a logros
              },
            ),
            
            const SizedBox(height: 24),
            
            // Actividad reciente
            Text(
              'Actividad Reciente',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            _buildActivityItem(
              context,
              'ZombieMaster completó el Easter Egg de Die Maschine',
              'Hace 2 horas',
              FontAwesomeIcons.egg,
            ),
            
            _buildActivityItem(
              context,
              'Nueva reseña en Firebase Z por ProGamer',
              'Hace 4 horas',
              FontAwesomeIcons.star,
            ),
            
            _buildActivityItem(
              context,
              'Guía actualizada para Mauer der Toten',
              'Hace 6 horas',
              FontAwesomeIcons.book,
            ),
            
            _buildActivityItem(
              context,
              'Nuevo logro desbloqueado: 100 Easter Eggs',
              'Hace 1 día',
              FontAwesomeIcons.trophy,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommunitySection(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      child: ListTile(
        leading: FaIcon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const FaIcon(FontAwesomeIcons.chevronRight),
        onTap: onTap,
      ),
    );
  }

  Widget _buildActivityItem(
    BuildContext context,
    String text,
    String time,
    IconData icon,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: FaIcon(
                icon,
                size: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
