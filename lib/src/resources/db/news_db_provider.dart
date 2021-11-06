import 'dart:io';

import 'package:flutter_my_news/src/contract/cache.dart';
import 'package:flutter_my_news/src/contract/source.dart';
import 'package:flutter_my_news/src/models/news_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const tableName = 'NEWS';
const newsId = 'id';

class NewsDbProvider implements Cache, Source {
  late Database db;

  NewsDbProvider() {
    init();
  }

  init() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final dbPath = documentDirectory.path + "item.db";
    db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
          CREATE TABLE $tableName (
            $newsId INTEGER PRIMARY KEY,
            deleted INTEGER,
            type TEXT,
            by TEXT,
            time INTEGER,
            text TEXT,
            dead INTEGER,
            parent TEXT,
            kids BLOB,
            url TEXT,
            score INTEGER,
            title TEXT,
            descendants INTEGER
          )
        """);
      },
    );
  }

  fetchNewsItem(int id) async {
    final maps = await db.query(
      tableName,
      columns: null,
      where: "$newsId = ?",
      whereArgs: [id],
    );

    if (maps.isNotEmpty) return NewsModel.fromDb(maps.first);

    return null;
  }

  @override
  addNewsItem(NewsModel news) {
    db.insert(tableName, news.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  @override
  Future<NewsModel>? fetchNewsStories(int id) => null;

  @override
  Future<List<int>>? fetchTopIds() => null;
}

final NewsDbProvider newsDbProvider = NewsDbProvider();
