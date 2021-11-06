import 'package:flutter/material.dart';
import 'package:flutter_my_news/src/models/news_model.dart';
import 'package:flutter_my_news/src/providers/news_provider.dart';
import 'package:flutter_my_news/src/ui/screens/loading_container.dart';

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
          return const LoadingContainer();
        }

        return FutureBuilder(
          future: snapshot.data?[itemId],
          builder: (context, AsyncSnapshot<NewsModel?> itemSnapshot) {
            if (itemSnapshot.hasData) {
              return buildNewsTile(itemSnapshot.data);
            }

            return const LoadingContainer();
          },
        );
      },
    );
  }

  Widget buildNewsTile(NewsModel? data) {
    return Column(
      children: [
        ListTile(
          title: Text(data!.title),
          subtitle: Text('${data.score} points'),
          trailing: Column(
            children: [
              const Icon(Icons.comment),
              Text('${data.descendants}'),
            ],
          ),
        ),
        const Divider(
          height: 8,
        ),
      ],
    );
  }
}
