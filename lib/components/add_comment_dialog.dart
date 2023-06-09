import 'package:flutter/material.dart';
import 'package:rate/rate.dart';
import 'package:my_comment/constants/color_constants.dart';
import 'package:my_comment/extensions/media_query_extension.dart';
import 'package:my_comment/models/movie_model.dart';
import 'package:my_comment/models/user_model.dart';
import 'package:my_comment/service/firebase_service.dart';

class AddCommentDialog extends StatefulWidget {
  final MovieModel movie;
  const AddCommentDialog({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<AddCommentDialog> createState() => _AddCommentDialogState();
}

class _AddCommentDialogState extends State<AddCommentDialog> {
  @override
  Widget build(BuildContext context) {
    double star = 0.0;
    TextEditingController controller = TextEditingController();
    return AlertDialog(
      scrollable: true,
      title: const Center(child: Text('Yorum Yap')),
      content: SizedBox(
        height: context.height * .5,
        width: context.width * .8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Rate(
              iconSize: 40,
              color: ColorConstants.starColor,
              allowHalf: true,
              allowClear: false,
              initialValue: 3.0,
              readOnly: false,
              onChange: (value) {
                star = value;
              },
            ),
            SizedBox(
              child: TextField(
                controller: controller,
                maxLines: 3,
                maxLength: 100,
                decoration: const InputDecoration(hintText: "Yorumunuz"),
              ),
            ),
            OutlinedButton(
                onPressed: () async {
                  UserModel? user =
                      await FirebaseService().getUserDetails(context);
                  String refinedComment = controller.text.trim();
                  if (star == 0.0) {
                    print('object');
                  }
                  if (refinedComment.isNotEmpty && star != 0.0) {
                    widget.movie.comments[user!.id] = refinedComment;
                    widget.movie.ratings[user.id] = star;
                    FirebaseService()
                        .addComment(widget.movie.id, widget.movie.toMap());
                  }
                },
                child: const Text('EKLE'))
          ],
        ),
      ),
    );
  }
}
