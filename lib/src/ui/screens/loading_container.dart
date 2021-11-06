import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: buildLoadingBox(),
          subtitle: buildLoadingBox(),
        ),
        const Divider(
          height: 8,
        ),
      ],
    );
  }

  Widget buildLoadingBox() {
    return Container(
      color: Colors.grey[200],
      height: 24,
      width: 150,
      margin: const EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
    );
  }
}
