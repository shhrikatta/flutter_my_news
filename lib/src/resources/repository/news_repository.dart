import 'package:flutter_my_news/src/models/news_model.dart';
import 'package:flutter_my_news/src/resources/api/news_api_provider.dart';
import 'package:flutter_my_news/src/resources/db/news_db_provider.dart';

class NewsRepository {
  final newsApiProvider = NewsApiProvider();
  final newsDbProvider = NewsDbProvider();

  Future<List<int>> getTopIds() async {
    return await newsApiProvider.fetchTopIds();
  }

  Future<NewsModel> getNewsItem(int id) async {
    // checking if a news item is already fetched earlier
    late NewsModel newsItem;

    newsItem = await newsDbProvider.fetchNewsItem(id) ??
        await newsApiProvider.fetchNewsStories(id);

    newsDbProvider.addNewsItem(newsItem);

    return newsItem;
  }

  clearCache() async {
    await newsDbProvider.clear();
  }
}
