import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entity/article_entity.dart';
import '../../domain/usecase/fetch_bookmark_use_case.dart';
import '../../domain/usecase/fetch_data_use_case.dart';
import '../../domain/usecase/fetch_more_data_use_case.dart';
import '../../domain/usecase/update_bookmark_use_case.dart';

class ArticleProvider extends ChangeNotifier {
  final FetchDataUseCase fetchDataUseCase;
  final FetchMoreDataUseCase fetchMoreDataUseCase;
  final UpdateArticleBookmarkUsecase updateArticleBookmarkUsecase;
  final FetchBookmarkUseCase fetchBookmarkUseCase;

  ArticleProvider(
      {required this.fetchDataUseCase,
      required this.fetchMoreDataUseCase,
      required this.updateArticleBookmarkUsecase,
      required this.fetchBookmarkUseCase});

  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<ArticleEntity> _articleList = [];

  List<ArticleEntity> get articleList => _articleList;

  setArticleList(List<ArticleEntity> value) {
    if (value.isNotEmpty) {
      _articleList = value;
      _articleList.sort((a, b) => a.publishedAt!.compareTo(b.publishedAt!));
    }
    notifyListeners();
  }

  List<ArticleEntity> _relatedArticleList = [];

  List<ArticleEntity> get relatedArticleList => _relatedArticleList;

  Future<List<ArticleEntity>> setRelatedArticleList(ArticleEntity value) async {
    _relatedArticleList =
        _articleList.where((e) => e.title != value.title).toList();
    _relatedArticleList
        .sort((a, b) => a.publishedAt!.compareTo(b.publishedAt!));

    _relatedArticleList.reversed;
    notifyListeners();

    return _relatedArticleList;
  }

  Future<void> fetchArticles() async {
    setLoading(true);
    final fetch = await fetchDataUseCase(ArticleParam());
    fetch.fold(
      (fail) => log("Error occurred"),
      (articles) => setArticleList(articles),
    );

    setLoading(false);
  }

  int _page = 2;

  int get page => _page;

  void incrementPage(int value) {
    _page = value;
    notifyListeners();
  }

  int _pageCheck = 2;

  int get pageCheck => _pageCheck;

  void incrementPageCheck() {
    _pageCheck++;
    notifyListeners();
  }

  bool _loadMore = false;

  bool get loadMore => _loadMore;

  void setLoadMore(bool value) {
    _loadMore = value;
    notifyListeners();
  }

  Future<void> fetchMoreArticles(BuildContext context) async {
    setLoadMore(true);
    if (_pageCheck == _page) {
      incrementPage(_page + 1);
      final fetch = await fetchMoreDataUseCase(ArticleParam(page: _pageCheck));
      fetch.fold(
        (fail) {
          log("There is no more data to load");
          _toastMessage("There is no more data to load", Colors.red);
        },
        (articles) => setArticleList(articles),
      );

      setLoadMore(false);
      incrementPageCheck();
      incrementPage(_pageCheck);
    }
  }

  List<ArticleEntity> _searchList = [];

  List<ArticleEntity> get searchList => _searchList;

  searchQuery(String value) {
    _searchList = _articleList
        .where((e) => e.title!.toLowerCase().contains(value))
        .toList();

    _searchList.sort((a, b) => a.publishedAt!.compareTo(b.publishedAt!));
    if (value == '') searchResultClear();
    notifyListeners();
  }

  searchResultClear() {
    _searchList.clear();
    notifyListeners();
  }

  static void _toastMessage(String message, Color color) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: color,
      textColor: Colors.white,
    );
  }

  //Start
  //Bookmark Functions
  bool _bookmark = false;

  bool get bookmark => _bookmark;

  setBookmark(bool value) {
    _bookmark = value;
    notifyListeners();
  }

  Future<ArticleEntity?> updateBookmark(
      ArticleEntity entity, bool? book) async {
    try {
      setBookmark(true);
      final toUpdate = await updateArticleBookmarkUsecase(
          ArticleBookmarkParam(articleEntity: entity));

      ArticleEntity? result = toUpdate.fold(
        (failure) {
          _toastMessage('failed to bookmark article', Colors.red);
          return null;
        },
        (res) {
          return _changeCurrentArticleState(res, entity, book);
        },
      );

      return result;
    } catch (e) {
      log("The error $e");
    } finally {
      setBookmark(false);
    }
    return null;
  }

  ArticleEntity? _changeCurrentArticleState(
      int? state, ArticleEntity entity, bool? book) {
    if (state! > 0) {
      entity.bookmark = entity.bookmark == 0 ? 1 : 0;
      final index =
          _articleList.indexWhere((element) => element.id == entity.id);
      _articleList[index] = entity;
      notifyListeners();

      if (book != null) {
        updateBookmarkList(book, entity);
      }
      return entity;
    }

    return null;
  }

  List<ArticleEntity> _bookmarkList = [];

  List<ArticleEntity> get bookmarkList => _bookmarkList;

  setBookmarkList(List<ArticleEntity> value) {
    _bookmarkList = value;
    notifyListeners();
  }

  Future<void> fetchBookmarksArticles() async {
    setLoading(true);
    final fetch = await fetchBookmarkUseCase(ArticleParam());
    fetch.fold(
      (fail) => log("Error occurred"),
      (articles) => setBookmarkList(articles),
    );

    setLoading(false);
  }

  void updateBookmarkList(bool? fromBookmark, ArticleEntity entity) {
    if (fromBookmark != null) {
      if (entity.bookmark == 0) {
        _bookmarkList.remove(entity);
      } else {
        _bookmarkList.add(entity);
      }

      notifyListeners();
    }
  }
}
