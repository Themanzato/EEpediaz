import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/app_theme.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      backgroundColor: AppTheme.primaryBlack,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.primaryBlack,
              AppTheme.secondaryBlack,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo y título
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppTheme.accentRed.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppTheme.accentRed.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: const FaIcon(
                    FontAwesomeIcons.skull,
                    size: 80,
                    color: AppTheme.accentRed,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'EEpedia Z',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: AppTheme.textWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 48,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Tu guía definitiva para zombies',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.textGray,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Inicia sesión para guardar tu progreso o continúa como invitado',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textGray,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                
                // Botones de autenticación
                authState.when(
                  data: (user) => _buildAuthButtons(context, ref),
                  loading: () => const CircularProgressIndicator(
                    color: AppTheme.accentRed,
                  ),
                  error: (error, stack) => Column(
                    children: [
                      Text(
                        'Error: ${error.toString()}',
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      _buildAuthButtons(context, ref),
                    ],
                  ),
                ),
                
                const Spacer(),
                
                // Footer
                Text(
                  'Los invitados pueden explorar la app, pero el progreso no se guardará',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textGray,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthButtons(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        // Botón de Google Sign In
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            onPressed: () async {
              await ref.read(authNotifierProvider.notifier).signInWithGoogle();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const FaIcon(
              FontAwesomeIcons.google,
              color: Colors.red,
              size: 20,
            ),
            label: const Text(
              'Continuar con Google',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Botón de invitado
        SizedBox(
          width: double.infinity,
          height: 56,
          child: OutlinedButton.icon(
            onPressed: () async {
              await ref.read(authNotifierProvider.notifier).signInAsGuest();
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.textWhite,
              side: const BorderSide(color: AppTheme.accentRed, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const FaIcon(
              FontAwesomeIcons.user,
              color: AppTheme.accentRed,
              size: 20,
            ),
            label: const Text(
              'Continuar como Invitado',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
