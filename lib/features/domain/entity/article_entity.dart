// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  int? id;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;
  String? sourceName;
  int? bookmark;

  ArticleEntity(
      {this.id,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content,
      this.sourceName,
      this.bookmark})
      : super();

  @override
  List<Object?> get props => [
        id,
        author,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content,
        sourceName,
        bookmark,
      ];
}
