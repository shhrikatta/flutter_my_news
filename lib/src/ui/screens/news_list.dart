import 'package:flutter/material.dart';
import 'package:flutter_my_news/src/blocs/news_bloc.dart';
import 'package:flutter_my_news/src/providers/news_provider.dart';
import 'package:flutter_my_news/src/ui/widgets/news_list_item.dart';
import 'package:flutter_my_news/src/ui/widgets/refresh.dart';

class NewsList extends StatelessWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _newsBloc = NewsProvider.of(context);

    return buildNewsList(_newsBloc, context);
  }

  Widget buildNewsList(NewsBloc newsBloc, BuildContext context) {
    return StreamBuilder(
      stream: newsBloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return const CircularProgressIndicator();
        } else {
          return Refresh(
            child: ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, int index) {
                newsBloc.fetchItem(snapshot.data![index]);
                return NewsListItem(
                  itemId: snapshot.data![index],
                );
              },
            ),
          );
        }
      },
    );
  }
}
