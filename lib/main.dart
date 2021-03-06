import 'package:flutter/material.dart';
import 'package:flutter_my_news/src/providers/comments_provider.dart';
import 'package:flutter_my_news/src/providers/news_provider.dart';
import 'package:flutter_my_news/src/ui/screens/news_detail.dart';
import 'package:flutter_my_news/src/ui/screens/news_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: NewsProvider(
        child: MaterialApp(
          title: 'N.E.W.S',
          onGenerateRoute: (RouteSettings routeSettings) {
            return routes(routeSettings);
          },
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          home: Scaffold(
            appBar: AppBar(
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: const Text('N.E.W.S'),
            ),
            body: const Center(
              child: NewsList(),
            ),
          ),
        ),
      ),
    );
  }

  Route routes(RouteSettings routeSettings) {
    if (routeSettings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          // call top news ids api before loading of new list ui
          final _newsBloc = NewsProvider.of(context);
          _newsBloc.fetchTopIds();

          return const NewsList();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          final itemId = int.parse(routeSettings.name!.replaceFirst('/', ''));
          final commentBloc = CommentsProvider.of(context);
          commentBloc.commentIds(itemId);
          return NewsDetail(itemId: itemId);
        },
      );
    }
  }
}
