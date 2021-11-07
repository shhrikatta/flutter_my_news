import 'dart:async';

import 'package:flutter_my_news/src/models/news_model.dart';
import 'package:flutter_my_news/src/resources/repository/news_repository.dart';
import 'package:rxdart/rxdart.dart';

class CommentsBloc {
  final _repository = NewsRepository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<NewsModel>>>();

  // Streams
  Stream<Map<int, Future<NewsModel>>> get _streamComments =>
      _commentsOutput.stream;

  // Sink
  Function(int) get commentIds => _commentsFetcher.sink.add;

  CommentsBloc() {
    _commentsFetcher.stream
        .transform(_commentTransform())
        .pipe(_commentsOutput);
  }

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }

  _commentTransform() {
    return ScanStreamTransformer<int, Map<int, Future<NewsModel>>>(
        (Map<int, Future<NewsModel>> cache, int id, index) {
      print(index);
      cache[id] = _repository.getNewsItem(id);
      cache[id]!.then((NewsModel newsModel) {
        for (var kidId in newsModel.kids) {
          commentIds(kidId);
        }
      });
      return cache;
    }, <int, Future<NewsModel>>{});
  }
}
