import 'package:flutter/material.dart';
import 'package:my_comment/constants/color_constants.dart';
import 'package:my_comment/models/movie_model.dart';
import 'package:my_comment/service/network_image_handler.dart';

class MovieCard extends StatelessWidget {
  final void Function() function;
  final MovieModel movie;
  const MovieCard({
    Key? key,
    required this.movie,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorConstants.primaryColor.withOpacity(.3)),
      child: InkWell(
        onTap: function,
        splashColor: ColorConstants.primaryColor,
        borderRadius: BorderRadius.circular(20),
        child: Row(
          children: [
            SizedBox(
              width: 125,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                child: Hero(
                  tag: movie.id,
                  child: Image.network(
                    fit: BoxFit.cover,
                    movie.imagePath,
                    // Resim verisi yüklenirken kurguladığımız yapıdır.
                    loadingBuilder: (context, child, loadingProgress) =>
                        NetworkImageHandler.imageNetworkHandler(
                            context, child, loadingProgress),
                    // Resim verisi yüklenirken hata oluştuğunda kurguladığımız yapıdır.
                    errorBuilder: (_, __, ___) => NetworkImageHandler.onError(),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    movie.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.apply(fontSizeDelta: 3, fontWeightDelta: 3),
                  ),
                  Text(
                    '${movie.year.toString()} yapımı',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.apply(fontSizeDelta: 3, fontStyle: FontStyle.italic),
                  ),
                  Text(
                    '${movie.imdb.toString()} IMDB',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.apply(fontSizeDelta: 2, fontWeightDelta: 1),
                  ),
                  Text(
                    '${movie.duration.toString()} dakika',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.apply(fontSizeDelta: 3, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
