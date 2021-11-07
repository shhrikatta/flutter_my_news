import 'package:flutter/material.dart';
import 'package:flutter_my_news/src/models/news_model.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<NewsModel>>? itemMap;

  const Comment({Key? key, required this.itemId, required this.itemMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: itemMap?[itemId],
        builder: (context, AsyncSnapshot<NewsModel> snapshot) {
          if (snapshot.hasData) {
            return Text('${snapshot.data?.text}');
          }

          return const Text('Loading...');
        });
  }
}
