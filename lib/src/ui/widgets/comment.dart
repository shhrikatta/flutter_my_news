import 'package:flutter/material.dart';
import 'package:flutter_my_news/src/models/news_model.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<NewsModel>>? itemMap;
  final int depth;

  const Comment(
      {Key? key,
      required this.itemId,
      required this.itemMap,
      required this.depth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: itemMap?[itemId],
        builder: (context, AsyncSnapshot<NewsModel> snapshot) {
          if (snapshot.hasData) {
            final children = <Widget>[
              ListTile(
                title: Text('${snapshot.data?.text}'),
                subtitle: Text('${snapshot.data?.by}'),
                contentPadding: EdgeInsets.only(
                  right: 16,
                  left: depth * 16,
                ),
              ),
              const Divider(),
            ];
            final listKids = snapshot.data?.kids ?? [];

            for (var kid in listKids) {
              children.add(
                Comment(
                  itemId: kid,
                  itemMap: itemMap,
                  depth: depth + 1,
                ),
              );
            }

            return Column(
              children: children,
            );
          }

          return const Text('Loading...');
        });
  }
}
