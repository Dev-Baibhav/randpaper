import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:randpaper/utils/routes/routes.dart';
import 'package:randpaper/view/screen/boarding/splash.dart';
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
			builder: (BuildContext context, GoRouterState state)  {
        final imagePath = state.extra as String;

        return Setwallpaper(imagePath: imagePath);
      },
		),
    GoRoute(
			path: Routes.tabBar,
			builder: (BuildContext context, GoRouterState state) => BottomTabBar(),
		),
	],
);