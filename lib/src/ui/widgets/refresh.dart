import 'package:flutter/material.dart';
import 'package:flutter_my_news/src/providers/news_provider.dart';

class Refresh extends StatelessWidget {
  final Widget child;

  const Refresh({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = NewsProvider.of(context);

    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await bloc.clearCache();
        await bloc.fetchTopIds();
      },
    );
  }
}
