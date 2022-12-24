import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/custom_drawer.dart';
import '../components/articles/article_list_view_builder.dart';
import '../components/articles/article_shimmer_list.dart';
import '../components/articles/not_found.dart';
import '../providers/article_provider.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ArticleProvider>(context, listen: false)
          .fetchBookmarksArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Bookmarks'),
      ),
      drawer: const CustomerDrawer(),
      body: Consumer<ArticleProvider>(
        builder: (context, state, _) {
          return RefreshIndicator(
            onRefresh: () => state.fetchBookmarksArticles(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                child: Column(
                  children: [
                    if (state.loading) const ArticleShimmerList(),
                    state.articleList.isNotEmpty
                        ? ArticleListViewBuilder(
                            list: state.bookmarkList, bookmark: true)
                        : state.loading
                            ? const SizedBox()
                            : const NotFoundWidget(
                                title: 'No bookmark Found',
                                subtitle:
                                    'Try to bookmark articles from details screen & store view here',
                              ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
