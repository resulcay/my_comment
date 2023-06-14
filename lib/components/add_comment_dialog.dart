import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:my_comment/models/book_model.dart';
import 'package:my_comment/models/show_model.dart';
import 'package:my_comment/models/user_model.dart';
import 'package:my_comment/service/user_service.dart';
import 'package:provider/provider.dart';
import 'package:rate/rate.dart';
import 'package:my_comment/constants/color_constants.dart';
import 'package:my_comment/extensions/media_query_extension.dart';
import 'package:my_comment/models/movie_model.dart';
import 'package:my_comment/service/firebase_service.dart';

class AddCommentDialog extends StatefulWidget {
  final Object object;
  const AddCommentDialog({
    Key? key,
    required this.object,
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
              allowClear: true,
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
                      Provider.of<UserService>(context, listen: false).user;
                  // Yorum textinin başındaki ve sonundaki boşlukları siler.
                  String refinedComment = controller.text.trim();

                  // Inputların doğru olmaması durumunda uyarı gösterir.
                  _infoBar(star, refinedComment);

                  // İstenen koşullar sağlanırsa ekleme yapar.
                  if (refinedComment.isNotEmpty &&
                      star != 0.0 &&
                      refinedComment.length >= 50) {
                    if (widget.object is MovieModel) {
                      MovieModel movie = widget.object as MovieModel;
                      movie.comments[user!.id] = refinedComment;
                      movie.ratings[user.id] = star;
                      FirebaseService()
                          .addComment(
                              context, movie, movie.id, movie.toMap(), 'movies')
                          .then((_) => Flushbar(
                                backgroundColor: ColorConstants.confirmedColor,
                                message: 'Başarılı',
                                duration: const Duration(seconds: 2),
                              ).show(context))
                          .then((_) => Navigator.pop(context));
                    } else if (widget.object is ShowModel) {
                      ShowModel show = widget.object as ShowModel;
                      show.comments[user!.id] = refinedComment;
                      show.ratings[user.id] = star;
                      FirebaseService()
                          .addComment(
                              context, show, show.id, show.toMap(), 'shows')
                          .then((_) => Flushbar(
                                backgroundColor: ColorConstants.confirmedColor,
                                message: 'Başarılı',
                                duration: const Duration(seconds: 2),
                              ).show(context))
                          .then((_) => Navigator.pop(context));
                    } else {
                      BookModel book = widget.object as BookModel;
                      book.comments[user!.id] = refinedComment;
                      book.ratings[user.id] = star;
                      FirebaseService()
                          .addComment(
                              context, book, book.id, book.toMap(), 'books')
                          .then((_) => Flushbar(
                                backgroundColor: ColorConstants.confirmedColor,
                                message: 'Başarılı',
                                duration: const Duration(seconds: 2),
                              ).show(context))
                          .then((_) => Navigator.pop(context));
                    }
                  }
                },
                child: const Text('EKLE'))
          ],
        ),
      ),
    );
  }

  _infoBar(double star, String refinedComment) {
    if (mounted) {
      if (star == 0.0) {
        Flushbar(
          backgroundColor: ColorConstants.starColor,
          message: 'Oylama Yapınız!',
          duration: const Duration(seconds: 2),
        ).show(context);
      } else if (refinedComment.isEmpty) {
        Flushbar(
          backgroundColor: ColorConstants.starColor,
          message: 'Yorum boş olamaz!',
          duration: const Duration(seconds: 2),
        ).show(context);
      } else if (refinedComment.length < 50) {
        Flushbar(
          backgroundColor: ColorConstants.starColor,
          message: 'Yorum en az 50 karakterden oluşmalı!',
          duration: const Duration(seconds: 2),
        ).show(context);
      }
    }
  }
}
