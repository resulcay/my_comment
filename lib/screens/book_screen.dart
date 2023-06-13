import 'package:flutter/material.dart';
import 'package:my_comment/components/book_card.dart';
import 'package:my_comment/components/title_widget.dart';
import 'package:my_comment/constants/color_constants.dart';
import 'package:my_comment/extensions/media_query_extension.dart';
import 'package:my_comment/models/book_model.dart';
import 'package:my_comment/screens/comment_screen.dart';
import 'package:my_comment/service/firebase_service.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Tüm kitapları getirir.
      future: FirebaseService().getAllBooks(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // İstek başarılı ise dönen nesneyi kitap modeline atadığımız yerdir.
          List<BookModel> books = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: context.height,
              width: context.width,
              child: Column(
                children: [
                  const TitleWidget(
                    title: 'KİTAPLAR',
                    colors: [
                      ColorConstants.lavender,
                      ColorConstants.pureBlack,
                    ],
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: ListView.builder(
                      itemCount: books.length,
                      itemBuilder: (context, index) => BookCard(
                        book: books[index],
                        function: () => _onTap(context, books[index]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        // Bekleme durumunda gösterilir.
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  _onTap(BuildContext context, Object object) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CommentScreen(object: object),
        ));
  }
}
