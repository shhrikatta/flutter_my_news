import 'package:flutter_my_news/src/contract/cache.dart';
import 'package:flutter_my_news/src/contract/source.dart';
import 'package:flutter_my_news/src/models/news_model.dart';
import 'package:flutter_my_news/src/resources/api/news_api_provider.dart';
import 'package:flutter_my_news/src/resources/db/news_db_provider.dart';

class NewsRepository {
  List<Source> sources = [NewsApiProvider(), newsDbProvider];
  List<Cache> caches = [newsDbProvider];

  Future<List<int>?> getTopIds() async {
    return await sources[1].fetchTopIds();
  }

  Future<NewsModel?> getNewsItem(int id) async {
    // checking if a news item is already fetched earlier
    late NewsModel? newsItem;
    Source source;

    for (source in sources) {
      newsItem = await source.fetchNewsStories(id);
      if (newsItem != null) {
        break;
      }
    }

    for (var cache in caches) {
      cache.addNewsItem(newsItem!);
    }

    return newsItem;
  }
}
