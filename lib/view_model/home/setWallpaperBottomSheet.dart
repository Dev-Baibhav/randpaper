import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallpaper_manager_plus/wallpaper_manager_plus.dart';

Future<bool> setWallpaperAction(dynamic imagePath, String screen) async {
  try {
    final ByteData data = await rootBundle.load(imagePath);
    final Directory tempDir = await getTemporaryDirectory();
    final File file = File('${tempDir.path}/wallpaper.jpg');

    await file.writeAsBytes(
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
    );

    if(screen == 'Home')  {
      await WallpaperManagerPlus().setWallpaper(
        file,
        WallpaperManagerPlus.homeScreen,
      );
    } else if(screen == 'Lock')  {
      await WallpaperManagerPlus().setWallpaper(
        file,
        WallpaperManagerPlus.lockScreen,
      );
    } else {
      await WallpaperManagerPlus().setWallpaper(
        file,
        WallpaperManagerPlus.bothScreens,
      );
    }

    await Future.delayed(const Duration(milliseconds: 300));

    return true;
  } catch (e) {
    // ignore: avoid_print
    print('Error: $e');
    return false;
  }
}


                
