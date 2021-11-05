import 'package:flutter_my_news/src/models/news_model.dart';
import 'package:flutter_my_news/src/resources/api/news_api_provider.dart';
import 'package:flutter_my_news/src/resources/db/news_db_provider.dart';

class NewsRepository {
  final NewsApiProvider _newsApiProvider = NewsApiProvider();
  final NewsDbProvider _newsDbProvider = NewsDbProvider();

  getTopIds() {
    return _newsApiProvider.fetchTopIds();
  }

  Future<NewsModel> getNewsItem(int id) async {
    // checking if a news item is already fetched earlier
    var newsItem = await _newsDbProvider.fetchNewsItem(id);
    if (newsItem != null) {
      return newsItem;
    }

    newsItem = await _newsApiProvider.fetchNewsStories(id);
    _newsDbProvider.addNewsItem(newsItem);

    return newsItem;
  }
}
