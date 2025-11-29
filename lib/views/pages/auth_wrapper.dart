import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../screens/login_screen.dart';
import 'main_page.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/app_theme.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    return authState.when(
      data: (userId) {
        if (userId != null) {
          // Usuario autenticado - mostrar app principal
          return const MainPage();
        } else {
          // Usuario no autenticado - mostrar login
          return const LoginScreen();
        }
      },
      loading: () => const Scaffold(
        backgroundColor: AppTheme.primaryBlack,
        body: Center(
          child: CircularProgressIndicator(
            color: AppTheme.accentRed,
          ),
        ),
      ),
      error: (error, stack) => Scaffold(
        backgroundColor: AppTheme.primaryBlack,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FaIcon(
                FontAwesomeIcons.triangleExclamation,
                size: 64,
                color: AppTheme.accentRed,
              ),
              const SizedBox(height: 16),
              Text(
                'Error de autenticación',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppTheme.textWhite,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textGray,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(authNotifierProvider);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentRed,
                  foregroundColor: AppTheme.textWhite,
                ),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
