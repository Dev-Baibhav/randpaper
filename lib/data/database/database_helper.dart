
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DatabaseHelper {
  Database? _database;

  Future<Database?> get database async  {
    if(_database != null) {
      return _database;
    }

    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,'test.db');


    _database = await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute(
        '''
          CREATE TABLE text (
            title TEXT,
            image TEXT PRIMARY KEY,
            isBookmarked TEXT
          )
        '''
      );
    }, onUpgrade: (db, oldVersion, newVersion) {
      db.execute('DROP TABLE IF EXISTS text');
      db.execute(
        '''
          CREATE TABLE text (
            title TEXT,
            image TEXT PRIMARY KEY,
            isBookmarked TEXT
          )
        '''
      );
    },);

    return _database!;
  }

  insertData(String image, String title, String isBookmarked) async {
    Database? db = await database;
    await db!.insert('text', {
      'image' : image,
      'title' : title,
      'isBookmarked' : isBookmarked
    });
  }

  readData() async {
    Database? db = await database;
    final list = await db!.query('text');
    return list;
  }

  removeData(String image) async {
    Database? db = await database;
    await db!.delete('text', where: 'image = ?', whereArgs: [image]);
  }

  deleteDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,'test.db');
    await databaseFactory.deleteDatabase(path);
    _database = null;
  }
}

