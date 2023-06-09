import 'package:flutter/material.dart';
import 'package:my_comment/components/add_comment_dialog.dart';
import 'package:my_comment/constants/color_constants.dart';
import 'package:my_comment/extensions/media_query_extension.dart';
import 'package:my_comment/models/book_model.dart';
import 'package:my_comment/models/movie_model.dart';
import 'package:my_comment/models/show_model.dart';
import 'package:my_comment/models/user_model.dart';
import 'package:my_comment/service/firebase_service.dart';
import 'package:rate/rate.dart';

class CommentSection extends StatefulWidget {
  final Object object;
  const CommentSection({
    super.key,
    required this.object,
  });

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  @override
  Widget build(BuildContext context) {
    if (widget.object is MovieModel) {
      MovieModel movie = widget.object as MovieModel;

      List<String> ids = [];
      List<String> comments = [];
      List<double> ratings = [];
      movie.comments.keys.map((e) => ids.add(e)).toList();
      movie.comments.values.map((e) => comments.add(e)).toList();
      movie.ratings.values.map((e) => ratings.add(e.toDouble())).toList();

      return Scaffold(
        body: ListView.builder(
          itemCount: movie.comments.length,
          itemBuilder: (context, index) => FutureBuilder(
              future: FirebaseService().getUserById(ids[index]),
              builder: (context, snap) {
                if (snap.data == null) {
                  return const SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  UserModel user = snap.data!;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.person_2),
                                const SizedBox(width: 5),
                                Text(user.name)
                              ],
                            ),
                            Rate(
                              iconSize: 25,
                              allowHalf: true,
                              color: ColorConstants.starColor,
                              allowClear: true,
                              initialValue: ratings[index],
                              readOnly: true,
                            ),
                          ],
                        ),
                        Text(comments[index]),
                      ],
                    ),
                  );
                }
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => AddCommentDialog(movie: movie));
          },
          child: const Icon(Icons.add),
        ),
      );
    } else if (widget.object is ShowModel) {
      ShowModel show = widget.object as ShowModel;
      return Text(show.name);
    } else {
      BookModel book = widget.object as BookModel;
      return Text(book.name);
    }
  }
}
