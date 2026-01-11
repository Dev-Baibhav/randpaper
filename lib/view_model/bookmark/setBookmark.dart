import 'package:randpaper/data/database/database_helper.dart';
import 'package:randpaper/view_model/home/categoryBar.dart';

DatabaseHelper db = DatabaseHelper();

Future<void> setBookmark() async {
  final data = await db.readData();
  bookmarkedImagesData.clear();
  for (var item in data) {
    if (item['isBookmarked'] == 'true') {
      bookmarkedImagesData.add({
        'title': item['title'] as String,
        'image': item['image'] as String,
        'isBookmarked': item['isBookmarked'] as String,
      });
    }
  }
}

void addBookmark(String path) {
  for (var item in items) {
    final imagePath = item['image'];

    if (imagePath == path) {
      item['isBookmarked'] = 'true';
      db.insertData(item['image']!, item['title']!, item['isBookmarked']!);
    }
  }

  setBookmark();
}

void removeBookmark(String path) {
  db.removeData(path);
  for (var item in items) {
    final imagePath = item['image'];

    if (imagePath == path) {
      item['isBookmarked'] = 'false';
    }
  }

  setBookmark();
}