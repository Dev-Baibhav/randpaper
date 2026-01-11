import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:randpaper/utils/routes/routes.dart';
import 'package:randpaper/view/screen/boarding/splash.dart';
import 'package:randpaper/view/screen/bookmark/wallpaperActions.dart';
import 'package:randpaper/view/screen/home/setWallpaper.dart';
import 'package:randpaper/view/tabbar/bottomTabBar.dart';

final GoRouter router = GoRouter(
  initialLocation: Routes.splash,
	routes: [
		GoRoute(
			path: Routes.splash,
			builder: (BuildContext context, GoRouterState state) => Splash(),
		),
    GoRoute(
      path: Routes.setWallpaper,
      pageBuilder: (BuildContext context, GoRouterState state) {
        final imagePath = state.extra as String;

        return CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: const Duration(milliseconds: 600),
          reverseTransitionDuration: const Duration(milliseconds: 600),
          child: Setwallpaper(imagePath: imagePath),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: Routes.wallpaperActions,
      pageBuilder: (BuildContext context, GoRouterState state) {
        final imagePath = state.extra as String;

        return CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: const Duration(milliseconds: 600),
          reverseTransitionDuration: const Duration(milliseconds: 600),
          child: WallpaperActions(imagePath: imagePath),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
			path: Routes.tabBar,
			builder: (BuildContext context, GoRouterState state) => BottomTabBar(),
		),
	],
);