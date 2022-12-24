import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tasks/core/constant/constant.dart';

import '../../../../core/constant/caches.dart';
import '../../domain/entity/article_entity.dart';
import '../components/articles/article_list_view_builder.dart';
import '../providers/article_provider.dart';

class ArticleDetails extends StatefulWidget {
  const ArticleDetails({super.key, required this.entity, this.bookmark});

  final ArticleEntity entity;
  final bool? bookmark;

  @override
  State<ArticleDetails> createState() => _ArticleDetailsState();
}

class _ArticleDetailsState extends State<ArticleDetails> {
  List<ArticleEntity> list = [];
  ArticleEntity articleEntity = ArticleEntity(bookmark: 0);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        articleEntity = widget.entity;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final listTemp =
          await Provider.of<ArticleProvider>(context, listen: false)
              .setRelatedArticleList(widget.entity);
      setState(() {
        list = listTemp;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        slivers: [
          buildSliverAppBar(size, context),
          buildSliverToBoxAdapter(context, size),
        ],
      ),
    );
  }

  SliverAppBar buildSliverAppBar(Size size, BuildContext context) {
    return SliverAppBar(
      // snap: true,
      pinned: true,
      floating: false,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: widget.entity,
          child: CachedNetworkImage(
            cacheManager: CacheConfig.customCacheManager,
            key: UniqueKey(),
            imageUrl: widget.entity.urlToImage.toString(),
            fit: BoxFit.cover,
            memCacheWidth: size.width.ceil() *
                MediaQuery.of(context).devicePixelRatio.ceil(),
            errorWidget: (context, url, error) {
              return Image.asset('assets/images/false-2061132__340.webp');
            },
            placeholder: (context, url) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.withOpacity(.3),
                highlightColor: Colors.white.withOpacity(.2),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey,
                  ),
                ),
              );
            },
          ),
        ),
      ),
      expandedHeight: 200,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.share),
          tooltip: 'Share',
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.open_in_new),
          tooltip: 'Open tap',
          onPressed: () {},
        ),
      ],
    );
  }

  SliverToBoxAdapter buildSliverToBoxAdapter(BuildContext context, Size size) {
    return SliverToBoxAdapter(
      child: Scrollbar(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.entity.title ?? '',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 10),
              Consumer<ArticleProvider>(
                builder: (context, state, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Constant.formatDate(widget.entity.publishedAt),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Row(
                        children: [
                          if (!state.bookmark)
                            IconButton(
                              onPressed: () async {
                                final modal = await state.updateBookmark(
                                    widget.entity, widget.bookmark);

                                if (modal != null) {
                                  setState(() {
                                    articleEntity = modal;
                                  });
                                }
                              },
                              icon: Icon(
                                (articleEntity.bookmark! > 0 &&
                                        articleEntity.bookmark != null)
                                    ? Ionicons.bookmark
                                    : Ionicons.bookmark_outline,
                              ),
                            ),
                          if (state.bookmark)
                            const Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: CupertinoActivityIndicator(),
                            ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.comment),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                width: size.width / 7,
                height: 30,
                child: const Divider(
                  color: Colors.green,
                  thickness: 2,
                ),
              ),
              Text(
                widget.entity.description ?? '',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .merge(const TextStyle(
                      fontWeight: FontWeight.w400,
                    )),
              ),
              const SizedBox(height: 10),
              Text(
                widget.entity.content ?? '',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .merge(const TextStyle(
                      fontWeight: FontWeight.w300,
                    )),
              ),
              const SizedBox(height: 20),
              Text(
                'Related articles',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                width: size.width / 4,
                child: const Divider(
                  color: Colors.green,
                  thickness: 2,
                ),
              ),
              ArticleListViewBuilder(
                list: list.take(10).toList(),
                bookmark: widget.bookmark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
