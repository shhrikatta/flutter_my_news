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
  final _items = BehaviorSubject<Map<int, Future<NewsModel>>>();
  Stream<Map<int, Future<NewsModel>>> get items => _items.stream;
  final _itemsFetcher = PublishSubject<int>();
  Function(int) get fetchItem => _itemsFetcher.sink.add;

  fetchTopIds() async {
    final List<int>? ids = await _newsRepo.getTopIds();
    if (ids != null) {
      _topIds.sink.add(ids);
    }
  }

  clearCache() {
    return _newsRepo.clearCache();
  }

  itemsTransformer() {
    return ScanStreamTransformer(
        (Map<int, Future<NewsModel>> cache, int id, index) {
      cache[id] = _newsRepo.getNewsItem(id);
      return cache;
    }, <int, Future<NewsModel>>{});
  }

  NewsBloc() {
    _itemsFetcher.stream.transform(itemsTransformer()).pipe(_items);
  }

  dispose() {
    _topIds.close();
    _itemsFetcher.close();
    _items.close();
  }
}
