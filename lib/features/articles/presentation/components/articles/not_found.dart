import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.3,
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Ionicons.close_circle, size: 150, color: Colors.red),
            const SizedBox(height: 35),
            Text(
              title,
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyText2!.merge(
                    const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
