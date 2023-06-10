import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_comment/components/interactive_progress_bar.dart';
import 'package:my_comment/constants/color_constants.dart';
import 'package:my_comment/enums/category_enum.dart';
import 'package:my_comment/models/user_model.dart';
import 'package:my_comment/service/firebase_service.dart';
import 'package:my_comment/service/path_service.dart';
import 'package:my_comment/service/user_service.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserService>(context).user!;
    int movieCount = user.movieComments.length;
    int showCount = user.showComments.length;
    int bookCount = user.bookComments.length;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: SvgPicture.asset(
                      alignment: Alignment.centerLeft,
                      PathService.imagePathProvider('welcome.svg')),
                ),
              ),
              Text(
                'Merhaba, ',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Flexible(
                child: Text(
                  user.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 25,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Card(
              color: ColorConstants.richBlack.withOpacity(.8),
              margin: EdgeInsets.zero,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Şu ana dek; $movieCount film, $showCount dizi ve $bookCount kitap hakkında yorum yaptınız',
                    style: const TextStyle(
                        color: ColorConstants.pureWhite,
                        fontSize: 25,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
          ),
          InteractiveProgressBar(
            initialStep: movieCount,
            category: Category.movie,
            barColor: ColorConstants.iconColor,
            function: FirebaseService().getAllMovies(),
          ),
          InteractiveProgressBar(
            initialStep: showCount,
            category: Category.show,
            barColor: ColorConstants.richBlack,
            function: FirebaseService().getAllShows(),
          ),
          InteractiveProgressBar(
            initialStep: bookCount,
            category: Category.book,
            barColor: ColorConstants.starColor,
            function: FirebaseService().getAllBooks(),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                FirebaseService().removeAllComments(context, 'movie');
              },
              child: const Text('Remove all movie comment and rating data'),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                FirebaseService().removeAllComments(context, 'show');
              },
              child: const Text('Remove all show comment and rating data'),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                FirebaseService().removeAllComments(context, 'book');
              },
              child: const Text('Remove all book comment and rating data'),
            ),
          ),
        ],
      ),
    );
  }
}
