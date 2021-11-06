import 'package:flutter_my_news/src/models/news_model.dart';
import 'package:flutter_my_news/src/resources/repository/news_repository.dart';
import 'package:rxdart/rxdart.dart';

class NewsBloc {
  // init Repository
  final _newsRepo = NewsRepository();

  // stream controller similar to subject
  final _topIds = PublishSubject<List<int>>();
  Stream<List<int>> get topIds => _topIds.stream;

  // items stream controller
  final _items = BehaviorSubject<int>();
  Function(int) get fetchItem => _items.sink.add;
  late Stream<Map<int, Future<NewsModel>>> items;

  fetchTopIds() async {
    final List<int>? ids = await _newsRepo.getTopIds();
    if (ids != null) {
      _topIds.sink.add(ids);
    }
  }

  itemsTransformer() {
    return ScanStreamTransformer(
        (Map<int, Future<NewsModel?>>? cache, int id, index) {
      cache?[id] = _newsRepo.getNewsItem(id);
      return cache;
    }, <int, Future<NewsModel>>{});
  }

  NewsBloc() {
    items.transform(itemsTransformer());
  }

  dispose() {
    _topIds.close();
    _items.close();
  }
}
