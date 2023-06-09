import 'package:flutter/material.dart';
import 'package:my_comment/components/comment_section.dart';
import 'package:my_comment/components/top_section.dart';
import 'package:my_comment/extensions/media_query_extension.dart';
import 'package:my_comment/models/book_model.dart';
import 'package:my_comment/models/movie_model.dart';
import 'package:my_comment/models/show_model.dart';

class CommentScreen extends StatelessWidget {
  final Object object;
  const CommentScreen({Key? key, required this.object}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: context.height,
          width: context.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TopSection(object: object),
                Expanded(child: CommentSection(object: object))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
