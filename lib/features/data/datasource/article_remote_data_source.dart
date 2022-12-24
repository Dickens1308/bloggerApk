// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constant/config.dart';
import '../../../../core/error/exceptions.dart';
import '../models/article_model.dart';
import 'article_local_data_source.dart';

abstract class ArticleRemoteDataSource {
  Future<List<ArticleModel>> fetchData();

  Future<List<ArticleModel>> fetchMoreData(int? pageNum);
}

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  String apiUrl =
      'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=${Config.newsApi}';

  ArticleLocalDataSource articleLocalDataSource;

  ArticleRemoteDataSourceImpl({required this.articleLocalDataSource});

  @override
  Future<List<ArticleModel>> fetchData() => _fetchArticleFromApi(apiUrl);

  @override
  Future<List<ArticleModel>> fetchMoreData(int? pageNum) =>
      _fetchArticleFromApi('$apiUrl&page=$pageNum');

  Future<List<ArticleModel>> _fetchArticleFromApi(String url) async {
    var result = await http
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});

    if (result.statusCode == 200) {
      Iterable parsedListJson =
          await (jsonDecode(result.body)["articles"]) as List;
      var articleModelList =
          parsedListJson.map((model) => ArticleModel.fromJson(model)).toList();

      if (articleModelList.isNotEmpty) {
        await articleLocalDataSource.insertArticlesToDb(articleModelList);
        articleModelList = await articleLocalDataSource.fetchData();
      }

      return articleModelList;
    }
    // log(result.body.toString());
    throw ServerException();
  }
}
