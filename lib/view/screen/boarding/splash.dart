import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:randpaper/utils/routes/routes.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.go(Routes.tabBar);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      body: Center(
        child: const Text("Welcome To The Wallpaper App", style: TextStyle(color: Colors.white, fontSize: 20),)
      ),
    );
  }
}