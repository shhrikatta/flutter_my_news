import 'package:flutter/material.dart';
import 'package:flutter_my_news/src/models/news_model.dart';
import 'package:flutter_my_news/src/providers/news_provider.dart';

class NewsListItem extends StatelessWidget {
  final int itemId;

  const NewsListItem({Key? key, required this.itemId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('current list item: $itemId');
    final bloc = NewsProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<NewsModel?>>> snapshot) {
        if (!snapshot.hasData) {
          return const Text('Item Loading...');
        }

        return FutureBuilder(
          future: snapshot.data?[itemId],
          builder: (context, AsyncSnapshot<NewsModel?> itemSnapshot) {
            if (itemSnapshot.hasData) {
              return Text(itemSnapshot.data!.title);
            }

            return Text('Future Loading $itemId...');
          },
        );
      },
    );
  }
}
