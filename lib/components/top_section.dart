import 'package:flutter/material.dart';
import 'package:my_comment/models/book_model.dart';
import 'package:my_comment/models/movie_model.dart';
import 'package:my_comment/models/show_model.dart';

class TopSection extends StatelessWidget {
  final Object object;
  const TopSection({
    super.key,
    required this.object,
  });

  @override
  Widget build(BuildContext context) {
    if (object is MovieModel) {
      MovieModel movie = object as MovieModel;
      return SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'FİLM',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Hero(
                      tag: movie.id,
                      child: Image.network(height: 150, movie.imagePath)),
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            movie.name,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '${movie.duration.toString()} dakika',
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '${movie.imdb.toString()} imdb',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    } else if (object is ShowModel) {
      ShowModel show = object as ShowModel;
      return SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'DİZİ',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Hero(
                      tag: show.id,
                      child: Image.network(height: 150, show.imagePath)),
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            show.name,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '${show.season.toString()} sezon',
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '${show.episodes.toString()} bölüm',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    } else {
      BookModel book = object as BookModel;

      return SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'KİTAP',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Hero(
                      tag: book.id,
                      child: Image.network(height: 150, book.imagePath)),
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            book.name,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            book.author.toString(),
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '${book.pages.toString()} sayfa',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
  }
}
