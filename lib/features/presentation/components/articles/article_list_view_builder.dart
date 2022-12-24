import 'package:flutter/material.dart';

import '../../../domain/entity/article_entity.dart';
import 'article_tile.dart';

class ArticleListViewBuilder extends StatefulWidget {
  const ArticleListViewBuilder({Key? key, required this.list, this.bookmark})
      : super(key: key);
  final List<ArticleEntity> list;
  final bool? bookmark;

  @override
  State<ArticleListViewBuilder> createState() => _ArticleListViewBuilderState();
}

class _ArticleListViewBuilderState extends State<ArticleListViewBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      reverse: true,
      addAutomaticKeepAlives: false,
      itemCount: widget.list.length,
      cacheExtent: 9999,
      itemBuilder: (context, index) {
        final entity = widget.list[index];
        return ArticleListTile(
            articleEntity: entity, bookmark: widget.bookmark);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }
}
