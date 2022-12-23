import 'package:flutter/cupertino.dart';

class LoadMoreArticles extends StatelessWidget {
  const LoadMoreArticles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: CupertinoActivityIndicator(
          animating: true,
          radius: 12,
        ),
      ),
    );
  }
}
