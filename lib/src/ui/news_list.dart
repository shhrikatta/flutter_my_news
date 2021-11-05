import 'package:flutter/material.dart';

class NewsList extends StatelessWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, int index) {
        return FutureBuilder(
          future: getFuture(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Text('fetched data at $index')
                : Text('yet to fetch data at $index');
          },
        );
      },
    );
  }

  getFuture() {
    return Future.delayed(
      const Duration(seconds: 2),
      () => 'hi',
    );
  }
}
