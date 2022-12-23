import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ArticleShimmerList extends StatelessWidget {
  const ArticleShimmerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return SizedBox(
          width: double.infinity,
          height: 80,
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: ListTile(
              contentPadding:
                  const EdgeInsets.only(left: 10, right: 10, top: 10),
              leading: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                height: size.height * .4,
                width: size.width * .2,
              ),
              title: Container(
                color: Colors.grey,
                width: double.infinity,
                height: 30,
              ),
              subtitle: Container(
                margin: const EdgeInsets.only(top: 10, right: 150),
                color: Colors.grey,
                height: 15,
              ),
            ),
          ),
        );
      },
    );
  }
}
