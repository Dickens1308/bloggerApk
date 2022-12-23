// ignore_for_file: must_be_immutable

import '../../domain/entity/article_entity.dart';

class ArticleModel extends ArticleEntity {
  ArticleModel({
    id,
    sourceName,
    author,
    title,
    description,
    url,
    urlToImage,
    publishedAt,
    content,
    bookmark,
  }) : super();

  ArticleModel.fromJson(Map<String, dynamic> json) {
    sourceName = json['source']['name'];
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
    bookmark = 0; //0 - False
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['source']["name"] = sourceName;
    data['author'] = author;
    data['title'] = title;
    data['description'] = description;
    data['url'] = url;
    data['urlToImage'] = urlToImage;
    data['publishedAt'] = publishedAt;
    data['content'] = content;
    return data;
  }

  // Local Database Data Model
  static const tableName = "articles";
  static const colId = "id";
  static const colTitle = "Title";
  static const colDescription = "Description";
  static const colImagePath = "Image";
  static const colPublishedAt = "published_At";
  static const colSourceName = "source";
  static const colContent = "content";
  static const colUrl = "url";
  static const colBookmark = "bookmark";

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      colTitle: title,
      colDescription: description,
      colImagePath: urlToImage,
      colPublishedAt: publishedAt,
      colSourceName: author,
      colUrl: url,
      colContent: content,
      colBookmark: bookmark,
    };

    if (id != null) {
      map[colId] = id;
    }
    return map;
  }

  ArticleModel.fromMap(Map<String, dynamic> map) {
    id = map[colId];
    title = map[colTitle];
    description = map[colDescription];
    urlToImage = map[colImagePath];
    publishedAt = map[colPublishedAt];
    sourceName = map[colSourceName];
    url = map[colUrl];
    content = map[colContent];
    bookmark = map[colBookmark];
  }
}
