import 'dart:convert';

class NewsModel {
  late final int id; // The item's unique id.
  late final bool? deleted; // true if the item is deleted.
  late final String?
      type; // The type of item. One of "job", "story", "comment", "poll", or "pollopt".
  late final String? by; // The username of the item's author.
  late final int? time; // Creation date of the item, in Unix Time.
  late final String? text; // The comment, story or poll text. HTML.
  late final bool? dead; // true if the item is dead.
  late final String?
      parent; // The comment's parent: either another comment or the relevant story.
  late final List<dynamic>?
      kids; // The ids of the item's comments, in ranked display order.
  late final String? url; // The URL of the story.
  late final int? score; // The story's score, or the votes for a pollopt.
  late final String? title; // The title of the story, poll or job. HTML.
  late final int?
      descendants; // In the case of stories or polls, the total comment count.

  NewsModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    deleted = parsedJson['deleted'];
    type = parsedJson['type'];
    by = parsedJson['by'];
    time = parsedJson['time'];
    text = parsedJson['text'];
    dead = parsedJson['dead'];
    parent = parsedJson['parent'];
    kids = parsedJson['kids'];
    url = parsedJson['url'];
    score = parsedJson['score'];
    title = parsedJson['title'];
    descendants = parsedJson['descendants'];
  }

  NewsModel.fromDb(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    deleted = parsedJson['deleted'] == 1;
    type = parsedJson['type'];
    by = parsedJson['by'];
    time = parsedJson['time'];
    text = parsedJson['text'];
    dead = parsedJson['dead'] == 1;
    parent = parsedJson['parent'];
    kids = jsonDecode(parsedJson['kids']);
    url = parsedJson['url'];
    score = parsedJson['score'];
    title = parsedJson['title'];
    descendants = parsedJson['descendants'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'by': by,
      'deleted': deleted == true ? 1 : 0,
      'text': text,
      'dead': dead == true ? 1 : 0,
      'parent': parent,
      'descendants': descendants,
      'id': id,
      'kids': jsonEncode(kids),
      'score': score,
      'time': time,
      'title': title,
      'type': type,
      'url': url,
    };
  }
}
