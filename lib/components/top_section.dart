import 'package:flutter/material.dart';
import 'package:my_comment/constants/color_constants.dart';
import 'package:my_comment/models/book_model.dart';
import 'package:my_comment/models/movie_model.dart';
import 'package:my_comment/models/show_model.dart';

class TopSection extends StatefulWidget {
  final Object object;
  const TopSection({
    super.key,
    required this.object,
  });

  @override
  State<TopSection> createState() => _TopSectionState();
}

class _TopSectionState extends State<TopSection>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animationTween;
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animationTween =
        Tween<double>(begin: 0.0, end: 150.0).animate(animationController);

    animationController.forward();

    animationController.addListener(() {
      setState(() {});
      animationController.addStatusListener((status) {
        if (status.name == 'completed') {
          animationController.repeat(reverse: true);
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.object is MovieModel) {
      MovieModel movie = widget.object as MovieModel;
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
                  Stack(
                    children: [
                      Positioned(
                        top: 10,
                        left: 20,
                        child: Container(
                          height: 2,
                          width: 2,
                          margin: const EdgeInsets.only(top: 60),
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              blurRadius: 300,
                              spreadRadius: animationTween.value,
                              color: ColorConstants.secondaryColor,
                            )
                          ]),
                        ),
                      ),
                      Hero(
                          tag: movie.id,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child:
                                  Image.network(height: 150, movie.imagePath))),
                    ],
                  ),
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
    } else if (widget.object is ShowModel) {
      ShowModel show = widget.object as ShowModel;
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
                  Stack(
                    children: [
                      Positioned(
                        top: 10,
                        left: 20,
                        child: Container(
                          height: 2,
                          width: 2,
                          margin: const EdgeInsets.only(top: 60),
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              blurRadius: 300,
                              spreadRadius: animationTween.value,
                              color: ColorConstants.secondaryColor,
                            )
                          ]),
                        ),
                      ),
                      Hero(
                          tag: show.id,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child:
                                  Image.network(height: 150, show.imagePath))),
                    ],
                  ),
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
      BookModel book = widget.object as BookModel;

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
                  Stack(
                    children: [
                      Positioned(
                        top: 10,
                        left: 20,
                        child: Container(
                          height: 2,
                          width: 2,
                          margin: const EdgeInsets.only(top: 60),
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              blurRadius: 300,
                              spreadRadius: animationTween.value,
                              color: ColorConstants.secondaryColor,
                            )
                          ]),
                        ),
                      ),
                      Hero(
                          tag: book.id,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child:
                                  Image.network(height: 150, book.imagePath))),
                    ],
                  ),
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
