import 'package:flutter/material.dart';
import 'package:flutter_my_news/src/blocs/news_bloc.dart';
import 'package:flutter_my_news/src/providers/news_provider.dart';

class NewsList extends StatelessWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _newsBloc = NewsProvider.of(context);
    //BAD implementation
    _newsBloc.fetchTopIds();

    return buildNewsList(_newsBloc, context);
  }

  Widget buildNewsList(NewsBloc newsBloc, BuildContext context) {
    return StreamBuilder(
      stream: newsBloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return const CircularProgressIndicator();
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, int index) {
              return Text('${snapshot.data![index]}');
            },
          );
        }
      },
    );
  }
}
