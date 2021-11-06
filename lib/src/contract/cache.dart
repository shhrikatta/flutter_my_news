import 'package:flutter_my_news/src/models/news_model.dart';

abstract class Cache {
  Future<int> addNewsItem(NewsModel news);
  Future<int> clear();
}
