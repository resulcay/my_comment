import 'package:flutter/material.dart';
import 'package:my_comment/constants/color_constants.dart';
import 'package:my_comment/models/movie_model.dart';
import 'package:my_comment/service/network_image_handler.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  const MovieCard({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorConstants.primaryColor.withOpacity(.3)),
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
                movie.imagePath,
                loadingBuilder: (context, child, loadingProgress) =>
                    NetworkImageHandler.imageNetworkHandler(
                        context, child, loadingProgress),
                errorBuilder: (_, __, ___) => NetworkImageHandler.onError(),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  color: ColorConstants.secondaryColor.withOpacity(.8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      movie.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.apply(
                          color: ColorConstants.pureWhite,
                          fontSizeDelta: 3,
                          fontWeightDelta: 3),
                    ),
                  ),
                ),
                Text(
                  '${movie.year.toString()} yapımı',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.apply(fontStyle: FontStyle.italic),
                ),
                Text(
                  '${movie.imdb.toString()} IMDB',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.apply(fontWeightDelta: 1),
                ),
                Text(
                  '${movie.duration.toString()} dakika',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.apply(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
