import '../../../../core/db/create_all_tables.dart';
import '../database/article_database.dart';
import '../models/article_model.dart';

abstract class ArticleLocalDataSource {
  Future<List<ArticleModel>> fetchData();

  Future<void> insertArticlesToDb(List<ArticleModel> list);

  Future<int?> bookmarkArticle(ArticleModel model);

  Future<List<ArticleModel>> fetchBookmarkPost();
}

class ArticleLocalDataSourceImpl implements ArticleLocalDataSource {
  final ArticleDatabase _articleDatabase = ArticleDatabase.instance;
  final CreateAllTables _createAllTables = CreateAllTables.instance;

  @override
  Future<List<ArticleModel>> fetchData() async =>
      await _articleDatabase.fetchAllOfflineArticles();

  @override
  Future<void> insertArticlesToDb(list) async =>
      await _createAllTables.insertArticles(list);

  @override
  Future<int?> bookmarkArticle(ArticleModel model) =>
      _articleDatabase.updateArticleModelById(model);

  @override
  Future<List<ArticleModel>> fetchBookmarkPost() async =>
      await _articleDatabase.fetchArticleByBookmark();
}
