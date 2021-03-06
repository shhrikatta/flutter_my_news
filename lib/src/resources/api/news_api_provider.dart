import 'dart:convert';

import 'package:flutter_my_news/src/models/news_model.dart';
import 'package:http/http.dart' show Client;

const _baseUrl = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider {
  Client client = Client();

  fetchTopIds() async {
    final Uri uri = Uri.parse('$_baseUrl/topstories.json');
    final res = await client.get(uri);

    if (res.statusCode == 200) {
      final ids = jsonDecode(res.body);
      return ids.cast<int>();
    }

    return null;
  }

  fetchNewsStories(int id) async {
    final Uri uri = Uri.parse('$_baseUrl/item/$id.json');
    var res = await client.get(uri);

    if (res.statusCode == 200) {
      return NewsModel.fromJson(jsonDecode(res.body));
    }

    return null;
  }
}
