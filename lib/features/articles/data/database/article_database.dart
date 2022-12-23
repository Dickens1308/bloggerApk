import 'dart:developer';
import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/article_model.dart';

class ArticleDatabase {
  static const _databaseName = 'blogs.db';
  static const _databaseVersion = 1;

  //Singleton Class(initialize only Once)
  ArticleDatabase._();

  static final ArticleDatabase instance = ArticleDatabase._();

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();

    return _database;
  }

  _initDatabase() async {
    Directory? directory = await getExternalStorageDirectory();
    var newPath =
        await Directory('${directory!.path}/db').create(recursive: true);

    String dbPath = join(newPath.path, _databaseName);

    return await openDatabase(dbPath, version: _databaseVersion);
  }

  //inserting data to the database
  Future<void> insertArticles(List<ArticleModel> articleModel) async {
    Database? db = await database;
    Batch batch = db!.batch();

    // batch.insert(table, values)
    if (articleModel.isNotEmpty) {
      for (int i = 0; i < articleModel.length; i++) {
        batch.insert(ArticleModel.tableName, articleModel[i].toMap(),
            conflictAlgorithm: ConflictAlgorithm.ignore);
      }

      await batch.commit(noResult: true);
    }
  }

  //Retrieve Data from the Database
  Future<List<ArticleModel>> fetchAllOfflineArticles() async {
    List<ArticleModel> list = [];

    Database? db = await database;

    var articleModels = await db!.query(
      ArticleModel.tableName,
      columns: [
        ArticleModel.colId,
        ArticleModel.colTitle,
        ArticleModel.colDescription,
        ArticleModel.colContent,
        ArticleModel.colSourceName,
        ArticleModel.colUrl,
        ArticleModel.colImagePath,
        ArticleModel.colPublishedAt,
        ArticleModel.colBookmark,
      ],
    ).catchError((onError) {
      log(onError.toString());
    });

    if (articleModels.isNotEmpty) {
      for (int i = 0; i < articleModels.length; i++) {
        list.add(ArticleModel.fromMap(articleModels[i]));
      }
    }

    return list;
  }

  Future<List<ArticleModel>> fetchArticleByBookmark() async {
    List<ArticleModel> list = [];
    Database? db = await database;

    var articleModels = await db!
        .query(ArticleModel.tableName,
            columns: [
              ArticleModel.colId,
              ArticleModel.colTitle,
              ArticleModel.colDescription,
              ArticleModel.colContent,
              ArticleModel.colSourceName,
              ArticleModel.colUrl,
              ArticleModel.colImagePath,
              ArticleModel.colPublishedAt,
              ArticleModel.colBookmark,
            ],
            where: '${ArticleModel.colBookmark} = ?',
            whereArgs: [1])
        .catchError((onError) {
      log(onError.toString());
    });

    if (articleModels.isNotEmpty) {
      for (int i = 0; i < articleModels.length; i++) {
        list.add(ArticleModel.fromMap(articleModels[i]));
      }
    }

    return list;
  }

  Future<int> updateArticleModelById(ArticleModel articleModel) async {
    Database? db = await database;
    int bookmark = articleModel.bookmark == 0 ? 1 : 0;
    return await db!.rawUpdate(
        '''UPDATE ${ArticleModel.tableName} SET ${ArticleModel.colBookmark} = ?
        WHERE ${ArticleModel.colId} = ?''', [bookmark, articleModel.id]);
  }

// Future<int> deleteRowById(int ArticleModelId) async {
//   Database? db = await database;

//   return db!.rawDelete(
//       'DELETE FROM ${ArticleModel.tableName} WHERE ${ArticleModel.colId} = ?',
//       [ArticleModelId]);
// }

// Future<int> deleteDb() async {
//   Database? db = await database;
//   return await db!.delete(ArticleModel.tableName);
// }
}
