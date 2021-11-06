import 'dart:convert';

import 'package:flutter_my_news/src/models/news_model.dart';
import 'package:flutter_my_news/src/resources/api/news_api_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('Fetching of top news ids', () async {
    final newsApi = NewsApiProvider();

    newsApi.client = MockClient((req) async {
      return Response(jsonEncode([1, 2, 3, 4]), 200);
    });

    final ids = await newsApi.fetchTopIds();

    expect(ids, [1, 2, 3, 4]);
  });

  test('fetching of news api model', () async {
    final newsApi = NewsApiProvider();

    newsApi.client = MockClient((req) async {
      final jsonReq = {
        "by": "dhouston",
        "descendants": 71,
        "id": 8863,
        "kids": [
          9224,
          8917,
          8952,
          8958,
          8884,
          8887,
          8869,
          8940,
          8908,
          9005,
          8873,
          9671,
          9067,
          9055,
          8865,
          8881,
          8872,
          8955,
          10403,
          8903,
          8928,
          9125,
          8998,
          8901,
          8902,
          8907,
          8894,
          8870,
          8878,
          8980,
          8934,
          8943,
          8876
        ],
        "score": 104,
        "time": 1175714200,
        "title": "My YC app: Dropbox - Throw away your USB drive",
        "type": "story",
        "url": "http://www.getdropbox.com/u/2/screencast.html"
      };

      return Response(jsonEncode(jsonReq), 200);
    });

    final NewsModel? res = await newsApi.fetchNewsStories(8863);

    expect(res?.id, 8863);
  });
}
