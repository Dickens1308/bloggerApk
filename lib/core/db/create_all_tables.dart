import 'dart:developer';
import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../features/articles/data/models/article_model.dart';

class CreateAllTables {
  static const _databaseName = 'blogs.db';
  static const _databaseVersion = 1;

  //Singleton Class(initialize only Once)
  CreateAllTables._();

  static final CreateAllTables instance = CreateAllTables._();

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

    return await openDatabase(dbPath,
        onCreate: _onCreateDb,
        onUpgrade: _onUpgrade,
        version: _databaseVersion);
  }

  _onCreateDb(Database db, int version) async {
    try {
      Batch batch = db.batch();
      batch.execute(_article);
      await batch.commit(continueOnError: true, noResult: true).then((value) {
        log('all table created');
      });
    } catch (e) {
      log(e.toString());
    }
  }

  _onUpgrade(Database db, int oldValue, int version) async {
    try {
      Batch batch = db.batch();
      batch.execute("DROP TABLE IF EXISTS ${ArticleModel.tableName} ;");
      batch.execute(_article);

      await batch.commit(continueOnError: true, noResult: true).then((value) {
        log('all table dropped & created');
      });
    } catch (e) {
      log(e.toString());
    }
  }

  //inserting data to the database
  Future<void> insertArticles(List<ArticleModel> articleModel) async {
    Database? db = await database;
    Batch batch = db!.batch();

    if (articleModel.isNotEmpty) {
      for (int i = 0; i < articleModel.length; i++) {
        batch.insert(ArticleModel.tableName, articleModel[i].toMap(),
            conflictAlgorithm: ConflictAlgorithm.ignore);
      }

      await batch.commit(continueOnError: true);
    }
  }

  final String _article = '''
  CREATE TABLE ${ArticleModel.tableName}(
   ${ArticleModel.colId}  INTEGER PRIMARY KEY AUTOINCREMENT,
   ${ArticleModel.colTitle} TEXT,
   ${ArticleModel.colDescription} BLOB,
   ${ArticleModel.colContent} BLOB,
   ${ArticleModel.colSourceName} TEXT,
   ${ArticleModel.colImagePath} TEXT,
   ${ArticleModel.colUrl} TEXT,
   ${ArticleModel.colBookmark} INTEGER,
   ${ArticleModel.colPublishedAt} TEXT,
   UNIQUE (${ArticleModel.colTitle})
   )
 ''';

// final String _order = '''
// CREATE TABLE ${Order.tableName} (
//    ${Order.colId}  INTEGER PRIMARY KEY AUTOINCREMENT,
//    ${Order.colPrice}  NUM(8,2),
//    ${Order.colInvoice}  INTEGER,
//    ${Order.colProduct}  INTEGER,
//    ${Order.colCreateDate}  TEXT,
//    FOREIGN KEY (${Order.colInvoice}) REFERENCES ${Invoice.tableName} (id),
//    FOREIGN KEY (${Order.colProduct}) REFERENCES ${Product.tableName} (id) ON DELETE NO ACTION ON UPDATE NO ACTION
// )
// ''';

}
