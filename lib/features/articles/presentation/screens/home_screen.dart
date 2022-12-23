import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:tasks/features/articles/presentation/components/articles/article_list_view_builder.dart';
import 'package:tasks/features/articles/presentation/components/articles/article_shimmer_list.dart';
import 'package:tasks/features/articles/presentation/screens/search_screen.dart';

import '../../../../widgets/custom_drawer.dart';
import '../components/articles/load_more_articles.dart';
import '../components/articles/not_found.dart';
import '../providers/article_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ArticleProvider>(context, listen: false).fetchArticles();
    });

    controller.addListener(() => _scrollListener());
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeListener(_scrollListener);
  }

  _scrollListener() async {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Provider.of<ArticleProvider>(context, listen: false)
            .fetchMoreArticles(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Article News'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const SearchScreen())),
            icon: const Icon(Ionicons.search_outline),
          )
        ],
      ),
      drawer: const CustomerDrawer(),
      body: Consumer<ArticleProvider>(builder: (context, state, _) {
        return RefreshIndicator(
          onRefresh: () => state.fetchArticles(),
          child: RawScrollbar(
            thumbColor: Colors.green,
            controller: controller,
            thickness: 1,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              controller: controller,
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                child: Column(
                  children: [
                    if (state.loading) const ArticleShimmerList(),
                    state.articleList.isNotEmpty
                        ? ArticleListViewBuilder(list: state.articleList)
                        : state.loading
                            ? const SizedBox()
                            : const NotFoundWidget(
                                title: 'No article Found',
                                subtitle:
                                    'Try to refresh or connect to the internet to get articles',
                              ),
                    if (state.loadMore) const LoadMoreArticles(),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
