import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tasks/core/constant/caches.dart';
import 'package:tasks/core/constant/constant.dart';

import '../../../domain/entity/article_entity.dart';
import '../../screens/article_details.dart';

class ArticleListTile extends StatelessWidget {
  const ArticleListTile(
      {super.key, required this.articleEntity, this.bookmark});

  final ArticleEntity articleEntity;
  final bool? bookmark;

  // Future<String?> _cacheImg(String img) async {
  //   final defaultCacheManager = CacheConfig();
  //   defaultCacheManager.cacheImage(img).then((String imageUrl) {
  //     return imageUrl;
  //   });
  //
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListTile(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ArticleDetails(
            entity: articleEntity,
            bookmark: bookmark,
          ),
        ),
      ),
      contentPadding: const EdgeInsets.only(left: 0, bottom: 10),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Hero(
          tag: articleEntity,
          child: SizedBox(
            height: size.height * .4,
            width: size.width * .2,
            child: CachedNetworkImage(
              cacheManager: CacheConfig.customCacheManager,
              key: UniqueKey(),
              imageUrl: articleEntity.urlToImage ??
                  'https://cdn.pixabay.com/photo/2017/02/12/21/29/false-2061132__340.png',
              memCacheWidth: size.width.ceil() *
                  MediaQuery.of(context).devicePixelRatio.ceil(),
              memCacheHeight: size.width.ceil() *
                  MediaQuery.of(context).devicePixelRatio.ceil(),
              fit: BoxFit.cover,
              errorWidget: (context, url, error) {
                return Image.asset('assets/images/false-2061132__340.webp');
              },
              placeholder: (context, url) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.withOpacity(.3),
                  highlightColor: Colors.white.withOpacity(.2),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .12,
                    width: MediaQuery.of(context).size.width * .25,
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
      ),
      title: Text(
        articleEntity.title.toString(),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Row(
          children: [
            Text(
              Constant.dateAgo(
                articleEntity.publishedAt ?? DateTime.now().toString(),
                false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
