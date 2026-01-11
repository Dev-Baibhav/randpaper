// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:randpaper/view_model/bookmark/setBookmark.dart';
import 'package:randpaper/view_model/home/setWallpaperBottomSheet.dart';
import 'package:slide_to_act/slide_to_act.dart';

class WallpaperActions extends StatelessWidget {
  final dynamic imagePath;

  const WallpaperActions({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: Center(child: Hero(tag: '${imagePath}_wallpaper', child: Image.asset(imagePath))),

      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Colors.white,
        activeForegroundColor: Colors.black,
        children: [
          SpeedDialChild(
            child: Icon(Icons.bookmark_border),
            onTap: () {
              removeBookmark(imagePath);
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.multiple_stop),
            onTap: () {
              _openBottomSheet(context, 'Both', imagePath);
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.lock),
            onTap: () {
              _openBottomSheet(context, 'Lock', imagePath);
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.home),
            onTap: () {
              _openBottomSheet(context, 'Home', imagePath);
            },
          ),
        ],
      ),
    );
  }
}

void _openBottomSheet(BuildContext context, String screen, imagePath) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder:
        (_) => Container(
          height: 200,
          width: double.infinity,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              Text('Set As $screen Screen', style: TextStyle(fontSize: 30, color: Colors.white),),

              SizedBox(
                width: 300,
                child: SlideAction(
                  onSubmit: () async {
                    bool isSet = await setWallpaperAction(imagePath, screen);
                    if (isSet) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Wallpaper Set Successfully')),
                      );
                      context.pop();
                      context.pop();
                      return null;
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Unable To Set Wallpaper')),
                      );
                      context.pop();
                      return null;
                    }
                  },

                  outerColor: const Color(0xFF121212),
                  innerColor: const Color(0xFF1F1F1F),

                  sliderButtonIcon: 
                  screen == 'Both' 
                  ? const Icon(
                    Icons.multiple_stop,
                    color: Colors.white,
                    size: 18,
                  ) 
                  : screen == 'Home'
                  ? const Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 18,
                  ) 
                  :  const Icon(
                    Icons.lock,
                    color: Colors.white,
                    size: 18,
                  ),
                  sliderButtonIconPadding: 18,

                  elevation: 1.5,

                  // 🔥 Key changes for rounded look
                  borderRadius: 30, // pill shape
                  height: 60,

                  text: 'Set as wallpaper',
                  textStyle: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.4,
                  ),

                  submittedIcon: const Icon(
                    Icons.check_circle,
                    color: Colors.greenAccent,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
  );
}
