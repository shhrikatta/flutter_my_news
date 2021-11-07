import 'package:flutter/material.dart';
import 'package:flutter_my_news/src/blocs/comments_bloc.dart';

class CommentsProvider extends InheritedWidget {
  final CommentsBloc _commentsBloc;

  CommentsProvider({Key? key, required Widget child})
      : _commentsBloc = CommentsBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static CommentsBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<CommentsProvider>()
            as CommentsProvider)
        ._commentsBloc;
  }
}
