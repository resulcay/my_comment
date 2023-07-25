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
    // Varsayılan yıldız (oylama) değeridir.
    double star = 0.0;
    // Yorum metnini tuttuğumuz yapıdır.
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
              color: ColorConstants.secondaryColor,
              allowHalf: true,
              allowClear: true,
              initialValue: 3.0,
              readOnly: false,
              // Her oylama yapıldığında widgetdaki değeri kendi değişkenimize atadığımız yerdir.
              onChange: (value) {
                star = value;
              },
            ),
            SizedBox(
              child: TextField(
                controller: controller,
                // Maksimum satır(dikey) sayısıdır..
                maxLines: 3,
                // Maksimum karakter sayısıdır.
                maxLength: 100,
                decoration: const InputDecoration(hintText: "Yorumunuz"),
              ),
            ),
            OutlinedButton(
                onPressed: () async {
                  // Global kullanıcı nesnesidir.
                  UserModel? user =
                      Provider.of<UserService>(context, listen: false).user;
                  // Yorum textinin başındaki ve sonundaki boşlukları siler.
                  String refinedComment = controller.text.trim();

                  // Inputların doğru olmaması durumunda uyarı gösterir.
                  _infoBar(context, star, refinedComment);

                  // İstenen koşullar sağlanırsa ekleme yapar.
                  if (refinedComment.isNotEmpty &&
                      star != 0.0 &&
                      refinedComment.length >= 10) {
                    // Obje 3 farklı modelde olabileceği için şart ekliyoruz.
                    if (widget.object is MovieModel) {
                      MovieModel movie = widget.object as MovieModel;

                      movie.comments[user!.id] = refinedComment;
                      movie.ratings[user.id] = star;

                      // Ham veriyi eklemesi için veritabanına gönderildiği yerdir.
                      FirebaseService()
                          .addComment(
                              context, movie, movie.id, movie.toMap(), 'movies')
                          // Durum başarılıysa altta gösterilir.
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

  _infoBar(BuildContext context, double star, String refinedComment) {
    // Eğer diyalog penceresi ekranda çiziliyse bu metinler gösterilir.
    if (context.mounted) {
      // Oylama yapılmamışsa gösterilir.
      if (star == 0.0) {
        Flushbar(
          backgroundColor: ColorConstants.secondaryColor,
          message: 'Oylama Yapınız!',
          duration: const Duration(seconds: 2),
        ).show(context);
        // Yorum yapılmamışsa gösterilir.
      } else if (refinedComment.isEmpty) {
        Flushbar(
          backgroundColor: ColorConstants.secondaryColor,
          message: 'Yorum boş olamaz!',
          duration: const Duration(seconds: 2),
        ).show(context);
        // Yorum istenilen değerden küçükse gösterilir.
      } else if (refinedComment.length < 10) {
        Flushbar(
          backgroundColor: ColorConstants.secondaryColor,
          message: 'Yorum en az 10 karakterden oluşmalı!',
          duration: const Duration(seconds: 2),
        ).show(context);
      }
    }
  }
}
