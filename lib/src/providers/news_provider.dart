import 'package:flutter/material.dart';
import 'package:flutter_my_news/src/blocs/news_bloc.dart';

class NewsProvider extends InheritedWidget {
  final NewsBloc newsBloc;

  NewsProvider({Key? key, required Widget child})
      : newsBloc = NewsBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static NewsBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<NewsProvider>()
            as NewsProvider)
        .newsBloc;
  }
}
