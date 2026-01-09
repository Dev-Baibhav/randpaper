// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wallpaper_manager_plus/wallpaper_manager_plus.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class Setwallpaper extends StatelessWidget {
  final dynamic imagePath;

  const Setwallpaper({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),

        actions: [
          IconButton(
            onPressed: () async {
              // Create instance
              try {
                // Load image from assets
                final ByteData data = await rootBundle.load(imagePath);

                // Get temporary directory
                final Directory tempDir = await getTemporaryDirectory();
                final File file = File('${tempDir.path}/wallpaper.jpg');

                // Write asset data to file
                await file.writeAsBytes(
                  data.buffer.asUint8List(
                    data.offsetInBytes,
                    data.lengthInBytes,
                  ),
                );

                // Set wallpaper
                await WallpaperManagerPlus().setWallpaper(
                  file,
                  WallpaperManagerPlus.homeScreen,
                );

                await Future.delayed(const Duration(milliseconds: 300));

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Wallpaper set successfully')),
                );

                if (context.mounted) {
                  context.pop();
                }

              } catch (e) {
                // ignore: avoid_print
                print('Error: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Wallpaper set successfully')),
                );
              }
            },
            icon: Icon(Icons.save_as),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(child: Hero(tag: imagePath, child: Image.asset(imagePath))),
    );
  }
}
