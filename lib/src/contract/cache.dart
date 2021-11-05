import 'package:flutter_my_news/src/models/news_model.dart';

abstract class Cache {
  addNewsItem(NewsModel news);
}
