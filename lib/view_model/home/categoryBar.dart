// ignore_for_file: avoid_print

final List<Map<String, String>> items = [
  {
    'title': 'Cars',
    'image': 'assets/images/Wallpaper1.jpeg',
    'isActive': 'false',
  },
  {
    'title': 'Gojo',
    'image': 'assets/images/Wallpaper2.jpeg',
    'isActive': 'false',
  },
  {
    'title': 'Anime',
    'image': 'assets/images/Wallpaper3.jpeg',
    'isActive': 'false',
  },
  {
    'title': 'Gojo',
    'image': 'assets/images/Wallpaper4.jpeg',
    'isActive': 'false',
  },
  {
    'title': 'Batman',
    'image': 'assets/images/Wallpaper5.jpeg',
    'isActive': 'false',
  },
  {
    'title': 'Cars',
    'image': 'assets/images/Wallpaper6.jpeg',
    'isActive': 'false',
  },
  {
    'title': 'Anime',
    'image': 'assets/images/Wallpaper7.jpeg',
    'isActive': 'false',
  },
  {
    'title': 'Anime',
    'image': 'assets/images/Wallpaper8.jpeg',
    'isActive': 'false',
  },
  {
    'title': 'Gojo',
    'image': 'assets/images/Wallpaper9.jpeg',
    'isActive': 'false',
  },
  {
    'title': 'Gojo',
    'image': 'assets/images/Wallpaper10.jpeg',
    'isActive': 'false',
  },
];

Map<String, List<Map<String, String>>> categories = {};

final List<Map<String, String>> imagesData = [];

void createCategory() {
  categories.clear();

  categories['All'] = [];

  for (var i = 1; i <= 10; i++) {
    categories['All']!.add({
      'title': 'All',
      'image': 'assets/images/Wallpaper$i.jpeg',
      'isActive': 'true',
    });
  }

  for (var item in items) {
    final title = item['title'];

    if (!categories.containsKey(title)) {
      categories[title!] = [];
    }

    categories[title]!.add(item);
  }

  categories.forEach((category, items) {
    for (final item in items) {
      if (item['isActive'] == 'true') {
        imagesData.add(item);
      }
    }
  });


}

void makeTrue(String label) {
  categories = Map.from(categories);

  imagesData.clear();

  categories.forEach((key, value) {
    value[0]['isActive'] = (key == label).toString();
  
    if (key == label) {
      imagesData.addAll(value);
    }
  });
}