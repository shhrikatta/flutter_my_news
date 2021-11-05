import 'package:flutter_my_news/src/models/news_model.dart';

abstract class Source {
  Future<List<int>>? fetchTopIds();
  Future<NewsModel>? fetchNewsStories(int id);
}
