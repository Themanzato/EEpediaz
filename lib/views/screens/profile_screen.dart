import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../providers/user_provider.dart' hide currentUserProvider;
import '../../providers/auth_provider.dart';
import '../../widgets/custom_app_bar.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(currentUserProvider);
    final userStatsAsync = ref.watch(userStatsProvider);

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Perfil',
        actions: [
          Icon(Icons.settings),
          SizedBox(width: 16),
        ],
      ),
      body: userId == null
          ? _buildLoginPrompt(context, ref)
          : _buildUserProfile(context, ref, userId, userStatsAsync),
    );
  }

  Widget _buildLoginPrompt(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FaIcon(
              FontAwesomeIcons.user,
              size: 80,
              color: Colors.grey,
            ),
            const SizedBox(height: 24),
            Text(
              'Inicia Sesión',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Inicia sesión para acceder a tu perfil, guardar favoritos y participar en la comunidad',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await ref.read(authNotifierProvider.notifier).signInWithGoogle();
                },
                icon: const FaIcon(FontAwesomeIcons.google),
                label: const Text('Continuar con Google'),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async {
                  await ref.read(authNotifierProvider.notifier).signInAsGuest();
                },
                icon: const FaIcon(FontAwesomeIcons.user),
                label: const Text('Continuar como Invitado'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context, WidgetRef ref, String userId, AsyncValue userStatsAsync) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Información del usuario
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Text(
                      userId.startsWith('guest') ? 'I' : 'U',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    userId.startsWith('guest') ? 'Invitado' : 'Usuario',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    userId.startsWith('guest') ? 'Modo Invitado' : 'Nivel 1',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (userId.startsWith('guest')) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.orange),
                      ),
                      child: const Text(
                        'Progreso no se guarda',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ] else ...[
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: 0.3, // Valor fijo para demo
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '300/1000 XP',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Estadísticas
          userStatsAsync.when(
            data: (stats) {
              if (stats == null) return const SizedBox.shrink();
              
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Estadísticas',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          context,
                          'Easter Eggs',
                          '${stats.totalEEsCompleted}',
                          FontAwesomeIcons.egg,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          context,
                          'Mapas',
                          '${stats.totalMapsPlayed}',
                          FontAwesomeIcons.map,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          context,
                          'Horas',
                          '${stats.totalHoursPlayed}',
                          FontAwesomeIcons.clock,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          context,
                          'Reseñas',
                          '${stats.reviewsWritten}',
                          FontAwesomeIcons.star,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => const SizedBox.shrink(),
          ),
          
          const SizedBox(height: 24),
          
          // Opciones del perfil
          Text(
            'Opciones',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          _buildProfileOption(
            context,
            'Favoritos',
            'Tus mapas favoritos',
            FontAwesomeIcons.heart,
            () {
              // Navegar a favoritos
            },
          ),
          
          _buildProfileOption(
            context,
            'Progreso',
            'Easter Eggs completados',
            FontAwesomeIcons.circleCheck,
            () {
              // Navegar a progreso
            },
          ),
          
          _buildProfileOption(
            context,
            'Configuración',
            'Ajustes de la aplicación',
            FontAwesomeIcons.gear,
            () {
              // Navegar a configuración
            },
          ),
          
          _buildProfileOption(
            context,
            'Cerrar Sesión',
            'Salir de tu cuenta',
            FontAwesomeIcons.rightFromBracket,
            () async {
              await ref.read(authNotifierProvider.notifier).signOut();
            },
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          FaIcon(
            icon,
            size: 24,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: FaIcon(
          icon,
          color: isDestructive 
              ? Colors.red 
              : Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isDestructive ? Colors.red : null,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const FaIcon(FontAwesomeIcons.chevronRight),
        onTap: onTap,
      ),
    );
  }


  Widget _buildLogoutButton(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      child: ElevatedButton.icon(
        onPressed: () async {
          await ref.read(authNotifierProvider.notifier).signOut();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        icon: const FaIcon(FontAwesomeIcons.signOut),
        label: const Text('Cerrar Sesión'),
      ),
    );
  }
}
