import 'package:flutter_my_news/src/resources/repository/news_repository.dart';
import 'package:rxdart/rxdart.dart';

class NewsBloc {
  // init Repository
  final _newsRepo = NewsRepository();
  // stream controller similar to subject
  final _topIds = PublishSubject<List<int>>();
  get topIds => _topIds.stream;

  fetchTopIds() async {
    final List<int>? ids = await _newsRepo.getTopIds();
    if (ids != null) {
      _topIds.sink.add(ids);
    }
  }

  dispose() {
    _topIds.close();
  }
}
