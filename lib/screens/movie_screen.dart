import 'package:flutter/material.dart';
import 'package:my_comment/components/movie_card.dart';
import 'package:my_comment/components/title_widget.dart';
import 'package:my_comment/constants/color_constants.dart';
import 'package:my_comment/extensions/media_query_extension.dart';
import 'package:my_comment/models/movie_model.dart';
import 'package:my_comment/service/firebase_service.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseService().getAllMovies(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MovieModel> movies = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: context.height,
              width: context.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TitleWidget(
                    title: 'FİLMLER',
                    colors: [
                      ColorConstants.secondaryColor,
                      ColorConstants.primaryColor,
                    ],
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) =>
                          MovieCard(movie: movies[index]),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
