import 'package:flutter/material.dart';
import 'package:my_comment/constants/color_constants.dart';
import 'package:my_comment/extensions/media_query_extension.dart';
import 'package:my_comment/models/book_model.dart';
import 'package:my_comment/service/network_image_handler.dart';

class BookCard extends StatelessWidget {
  final BookModel book;
  const BookCard({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorConstants.richBlack),
      child: Row(
        children: [
          SizedBox(
            width: 125,
            height: 200,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              child: Image.network(
                fit: BoxFit.cover,
                book.imagePath,
                loadingBuilder: (context, child, loadingProgress) =>
                    NetworkImageHandler.imageNetworkHandler(
                        context, child, loadingProgress),
                errorBuilder: (_, __, ___) => NetworkImageHandler.onError(),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Divider(
                          thickness: 1,
                          color: ColorConstants.lavender,
                        ),
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: context.width * .6),
                      child: Text(
                        book.name,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge?.apply(
                            color: ColorConstants.lavender,
                            fontSizeDelta: 3,
                            fontWeightDelta: 3),
                      ),
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Divider(
                          thickness: 1,
                          color: ColorConstants.lavender,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    book.author,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.titleLarge?.apply(
                        color: ColorConstants.lavender,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                Text(
                  '${book.pages.toString()} sayfa',
                  style: Theme.of(context).textTheme.titleLarge?.apply(
                      color: ColorConstants.lavender, fontWeightDelta: 1),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
