import 'package:flutter/material.dart';
import 'package:my_comment/constants/color_constants.dart';
import 'package:my_comment/extensions/media_query_extension.dart';
import 'package:my_comment/models/book_model.dart';
import 'package:my_comment/service/network_image_handler.dart';

class BookCard extends StatelessWidget {
  final BookModel book;
  final void Function() function;
  const BookCard({
    Key? key,
    required this.book,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 94,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorConstants.richBlack),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: function,
          borderRadius: BorderRadius.circular(20),
          child: Row(
            children: [
              SizedBox(
                width: 125,
                height: 150,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  child: Hero(
                    tag: book.id,
                    child: Image.network(
                      fit: BoxFit.fill,
                      book.imagePath,
                      // Resim verisi yüklenirken kurguladığımız yapıdır.
                      loadingBuilder: (context, child, loadingProgress) =>
                          NetworkImageHandler.imageNetworkHandler(
                              context, child, loadingProgress),
                      // Resim verisi yüklenirken hata oluştuğunda kurguladığımız yapıdır.
                      errorBuilder: (_, __, ___) =>
                          NetworkImageHandler.onError(),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Flexible(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Divider(
                              thickness: 1,
                              color: ColorConstants.lavender,
                            ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints:
                              BoxConstraints(maxWidth: context.width * .6),
                          child: Text(
                            book.name,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.apply(
                                    color: ColorConstants.lavender,
                                    fontSizeDelta: -4,
                                    fontWeightDelta: 3),
                          ),
                        ),
                        const Flexible(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Divider(
                              thickness: 1,
                              color: ColorConstants.lavender,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              book.author,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.apply(
                                      color: ColorConstants.lavender,
                                      fontStyle: FontStyle.italic),
                            ),
                            Text(
                              '${book.pages.toString()} sayfa',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.apply(
                                      color: ColorConstants.lavender,
                                      fontWeightDelta: 1),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
