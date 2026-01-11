import 'package:flutter/material.dart';
import 'package:flutter_masonry_view/flutter_masonry_view.dart';
import 'package:go_router/go_router.dart';
import 'package:randpaper/utils/routes/routes.dart';
import 'package:randpaper/view_model/bookmark/setBookmark.dart';
import 'package:randpaper/view_model/home/categoryBar.dart';

class Bookmark extends StatefulWidget {
  const Bookmark({super.key});

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  static _BookmarkState? _instance;

  @override
  void initState() {
    super.initState();
    _instance = this;
    _loadBookmarks();
  }

  @override
  void dispose() {
    _instance = null;
    super.dispose();
  }

  void _loadBookmarks() async {
    await setBookmark();
    if (mounted) {
      setState(() {});
    }
  }

  static void refresh() {
    _instance?._loadBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Bookmarks', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: refresh, icon: Icon(Icons.refresh, color: Colors.white))
        ],
      ),
      backgroundColor: Colors.black,
      body: bookmarkedImagesData.isNotEmpty
          ? SafeArea(
              child: SingleChildScrollView(
                child: MasonryView(
                  listOfItem: bookmarkedImagesData,
                  numberOfColumn: 2,
                  itemBuilder: (item) {
                    final data = item as Map<String, String>;

                    return GestureDetector(
                      onTap: () {
                        context.push(
                          Routes.wallpaperActions,
                          extra: data['image']!,
                        );
                      },
                      child: Hero(
                        tag: '${data['image']!}_wallpaper',
                        child: Image.asset(
                          data['image']!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          : Center(
              child: Text(
                "Bookmarks Not Found",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
    );
  }
}
