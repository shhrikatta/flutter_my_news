import 'dart:convert';

import 'package:flutter_my_news/src/models/news_model.dart';
import 'package:http/http.dart' show Client;

const _baseUrl = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider {
  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    final Uri uri = Uri.parse('$_baseUrl/topstories.json');
    final res = await client.get(uri);
    final ids = jsonDecode(res.body);

    return ids.cast<int>();
  }

  Future<NewsModel> fetchNewsStories(int id) async {
    final Uri uri = Uri.parse('$_baseUrl/item/$id.json');
    var res = await client.get(uri);

    return NewsModel.fromJson(jsonDecode(res.body));
  }
}
