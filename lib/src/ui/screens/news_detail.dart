import 'package:flutter/material.dart';
import 'package:flutter_my_news/src/blocs/comments_bloc.dart';
import 'package:flutter_my_news/src/models/news_model.dart';
import 'package:flutter_my_news/src/providers/comments_provider.dart';
import 'package:flutter_my_news/src/ui/widgets/comment.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;

  const NewsDetail({Key? key, required this.itemId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _commentsBloc = CommentsProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('News Detail'),
      ),
      body: buildCommentBody(_commentsBloc),
    );
  }

  buildCommentBody(CommentsBloc commentsBloc) {
    return StreamBuilder(
      stream: commentsBloc.streamComments,
      builder: (context, AsyncSnapshot<Map<int, Future<NewsModel>>> snapshot) {
        if (snapshot.hasData) {
          final itemFuture = snapshot.data![itemId];
          return FutureBuilder(
            future: itemFuture,
            builder: (context, AsyncSnapshot<NewsModel> itemSnapshot) {
              if (snapshot.hasData) {
                return buildCommentList(itemSnapshot.data, snapshot.data);
              }
              return const Text('Loading...');
            },
          );
        }

        return const Text('Loading...');
      },
    );
  }

  buildTitle(NewsModel? data) {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.all(10),
      child: Text(
        '${data?.title}',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  buildCommentList(NewsModel? data, Map<int, Future<NewsModel>>? itemMap) {
    final children = <Widget>[];
    children.add(buildTitle(data));

    final commentsList = data?.kids
        .map((kidId) => Comment(
              itemId: kidId,
              itemMap: itemMap,
            ))
        .toList();

    if (commentsList != null) {
      children.addAll(commentsList);
    }

    return ListView(
      children: children,
    );
  }
}
