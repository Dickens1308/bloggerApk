// ignore_for_file: unnecessary_import, depend_on_referenced_packages

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheConfig {
  static final customCacheManager = CacheManager(
    Config(
      'customCacheKey',
      maxNrOfCacheObjects: 300,
      stalePeriod: const Duration(days: 10),
    ),
  );

  // final defaultCacheManager = DefaultCacheManager();
  //
  // Future<String> cacheImage(String? imagePath) async {
  //   // Check if the image file is not in the cache
  //   if ((await defaultCacheManager.getFileFromCache(imagePath!))?.file ==
  //       null) {
  //     Uint8List bytes =
  //         (await NetworkAssetBundle(Uri.parse(imagePath)).load(imagePath))
  //             .buffer
  //             .asUint8List();
  //
  //     // Put the image file in the cache
  //     await defaultCacheManager.putFile(imagePath, bytes);
  //   }
  //
  //   // Return image download url
  //   return imagePath;
  // }
}
