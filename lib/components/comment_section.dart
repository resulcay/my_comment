import 'package:flutter/material.dart';
import 'package:my_comment/components/add_comment_dialog.dart';
import 'package:my_comment/constants/color_constants.dart';
import 'package:my_comment/models/book_model.dart';
import 'package:my_comment/models/movie_model.dart';
import 'package:my_comment/models/show_model.dart';
import 'package:my_comment/models/user_model.dart';
import 'package:my_comment/service/firebase_service.dart';
import 'package:my_comment/service/user_service.dart';
import 'package:provider/provider.dart';
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
                                const Icon(
                                  Icons.person,
                                  size: 35,
                                  color: ColorConstants.primaryColor,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  user.name,
                                  style: Theme.of(context).textTheme.titleLarge,
                                )
                              ],
                            ),
                            Rate(
                              iconSize: 25,
                              allowHalf: true,
                              color: ColorConstants.starColor,
                              allowClear: false,
                              initialValue: ratings[index],
                              readOnly: true,
                            ),
                          ],
                        ),
                        Text(
                          comments[index],
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.apply(fontSizeDelta: 1),
                        ),
                        const Divider()
                      ],
                    ),
                  );
                }
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                useRootNavigator: false,
                context: context,
                builder: (context) => AddCommentDialog(object: movie));
          },
          child: Builder(builder: (context) {
            UserModel currentUser = Provider.of<UserService>(context).user!;
            bool isFirst = movie.comments.keys.contains(currentUser.id);
            return Icon(isFirst ? Icons.edit : Icons.add);
          }),
        ),
      );
    } else if (widget.object is ShowModel) {
      ShowModel show = widget.object as ShowModel;

      List<String> ids = [];
      List<String> comments = [];
      List<double> ratings = [];
      show.comments.keys.map((e) => ids.add(e)).toList();
      show.comments.values.map((e) => comments.add(e)).toList();
      show.ratings.values.map((e) => ratings.add(e.toDouble())).toList();

      return Scaffold(
        body: ListView.builder(
          itemCount: show.comments.length,
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
                                const Icon(
                                  Icons.person,
                                  size: 35,
                                  color: ColorConstants.primaryColor,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  user.name,
                                  style: Theme.of(context).textTheme.titleLarge,
                                )
                              ],
                            ),
                            Rate(
                              iconSize: 25,
                              allowHalf: true,
                              color: ColorConstants.starColor,
                              allowClear: false,
                              initialValue: ratings[index],
                              readOnly: true,
                            ),
                          ],
                        ),
                        Text(
                          comments[index],
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.apply(fontSizeDelta: 1),
                        ),
                        const Divider()
                      ],
                    ),
                  );
                }
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                useRootNavigator: false,
                context: context,
                builder: (context) => AddCommentDialog(object: widget.object));
          },
          child: Builder(builder: (context) {
            UserModel currentUser = Provider.of<UserService>(context).user!;
            bool isFirst = show.comments.keys.contains(currentUser.id);
            return Icon(isFirst ? Icons.edit : Icons.add);
          }),
        ),
      );
    } else {
      BookModel book = widget.object as BookModel;

      List<String> ids = [];
      List<String> comments = [];
      List<double> ratings = [];
      book.comments.keys.map((e) => ids.add(e)).toList();
      book.comments.values.map((e) => comments.add(e)).toList();
      book.ratings.values.map((e) => ratings.add(e.toDouble())).toList();

      return Scaffold(
        body: ListView.builder(
          itemCount: book.comments.length,
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
                                const Icon(
                                  Icons.person,
                                  size: 35,
                                  color: ColorConstants.primaryColor,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  user.name,
                                  style: Theme.of(context).textTheme.titleLarge,
                                )
                              ],
                            ),
                            Rate(
                              iconSize: 25,
                              allowHalf: true,
                              color: ColorConstants.starColor,
                              allowClear: false,
                              initialValue: ratings[index],
                              readOnly: true,
                            ),
                          ],
                        ),
                        Text(
                          comments[index],
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.apply(fontSizeDelta: 1),
                        ),
                        const Divider()
                      ],
                    ),
                  );
                }
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                useRootNavigator: false,
                context: context,
                builder: (context) => AddCommentDialog(object: widget.object));
          },
          child: Builder(builder: (context) {
            UserModel currentUser = Provider.of<UserService>(context).user!;
            bool isFirst = book.comments.keys.contains(currentUser.id);
            return Icon(isFirst ? Icons.edit : Icons.add);
          }),
        ),
      );
    }
  }
}
