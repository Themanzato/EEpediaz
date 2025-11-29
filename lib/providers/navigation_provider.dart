import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NavigationTab {
  home,
  maps,
  community,
  profile,
}

class NavigationNotifier extends StateNotifier<NavigationTab> {
  NavigationNotifier() : super(NavigationTab.home);

  void setTab(NavigationTab tab) {
    state = tab;
  }
}

final navigationProvider = StateNotifierProvider<NavigationNotifier, NavigationTab>((ref) {
  return NavigationNotifier();
});
