import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/features/articles/presentation/components/articles/article_list_view_builder.dart';
import 'package:tasks/features/articles/presentation/providers/article_provider.dart';

import '../components/articles/not_found.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleProvider>(builder: (context, state, _) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: searchTextField(state, context),
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanDown: (_) => FocusScope.of(context).requestFocus(FocusNode()),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  if (state.searchList.isNotEmpty)
                    ArticleListViewBuilder(list: state.searchList),

                  if (state.searchList.isEmpty)
                    const NotFoundWidget(
                      title: 'No articles found',
                      subtitle:
                          'Try to search with different title to get articles',
                    ),

                  // Shimmer Loading on Remote Search
                  // ArticleShimmerList()
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  TextField searchTextField(ArticleProvider state, BuildContext context) {
    return TextField(
      controller: textEditingController,
      onSubmitted: (value) {},
      onChanged: (value) {
        state.searchQuery(textEditingController.text);
      },
      keyboardType: TextInputType.text,
      autofocus: true,
      style: Theme.of(context).textTheme.headline6!.merge(
            const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
      decoration: InputDecoration(
        hintText: "Search article",
        hintStyle: Theme.of(context).textTheme.headline6!.merge(
              const TextStyle(
                color: Colors.white60,
                fontWeight: FontWeight.w400,
              ),
            ),
        suffixIcon: IconButton(
          onPressed: () {
            FocusScope.of(context).requestFocus(FocusNode());
            textEditingController.clear();
            state.searchResultClear();
          },
          icon: const Icon(
            Icons.clear,
            color: Colors.white60,
          ),
        ),
        border: InputBorder.none,
      ),
    );
  }
}
