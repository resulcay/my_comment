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
                      child: Text(
                        movie.name,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                        ),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Hero(
                        tag: show.id,
                        child: Image.network(height: 150, show.imagePath)),
                    Expanded(
                      child: Center(
                        child: Text(
                          show.name,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Hero(
                        tag: book.id,
                        child: Image.network(height: 150, book.imagePath)),
                    Expanded(
                      child: Center(
                        child: Text(
                          book.name,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}
