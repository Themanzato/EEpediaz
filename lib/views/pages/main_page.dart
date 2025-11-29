import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/navigation_provider.dart';
import '../../widgets/custom_bottom_nav.dart';
import '../screens/home_screen.dart';
import '../screens/mapas_view.dart';
import '../screens/comunidad_view.dart';
import '../screens/profile_screen.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab = ref.watch(navigationProvider);

    return Scaffold(
      body: IndexedStack(
        index: currentTab.index,
        children: const [
          HomeScreen(),
          MapasView(),
          ComunidadView(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}
