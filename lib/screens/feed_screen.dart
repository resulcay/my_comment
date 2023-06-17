import 'package:flutter/material.dart';
import 'package:my_comment/components/interactive_progress_bar.dart';
import 'package:my_comment/constants/color_constants.dart';
import 'package:my_comment/enums/category_enum.dart';
import 'package:my_comment/models/user_model.dart';
import 'package:my_comment/service/firebase_service.dart';
import 'package:my_comment/service/navigation_service.dart';
import 'package:my_comment/service/path_service.dart';
import 'package:my_comment/service/user_service.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Kullanıcı nesnemizdir.
    UserModel user = Provider.of<UserService>(context).user!;

    // Yorum yapılan film sayısıdır.
    int movieCount = user.movieComments.length;

    // Yorum yapılan dizi sayısıdır.
    int showCount = user.showComments.length;

    // Yorum yapılan kitap sayısıdır.
    int bookCount = user.bookComments.length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Image.asset(
                    alignment: Alignment.centerLeft,
                    PathService.imagePathProvider('greeting.gif')),
              ),
              Text(
                'Merhaba, ',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Flexible(
                child: Text(
                  user.name,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 25,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Card(
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
                      fontSize: 23,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          InteractiveProgressBar(
            category: Category.movie,
            barColor: ColorConstants.iconColor,
            function: FirebaseService().getAllMovies(),
          ),
          InteractiveProgressBar(
            category: Category.show,
            barColor: ColorConstants.richBlack,
            function: FirebaseService().getAllShows(),
          ),
          InteractiveProgressBar(
            category: Category.book,
            barColor: ColorConstants.secondaryColor,
            function: FirebaseService().getAllBooks(),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                // Kullanıcın tüm film yorumları ve oylamalarını siler ve Kullanıcı nesnesini günceller.
                FirebaseService()
                    .removeCurrentUserCommentData(context, 'movie');
                Provider.of<UserService>(context, listen: false)
                    .changeUserProperties(movieComments: []);
              },
              child: const Text('Kullanıcı film verisini sil'),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                // Kullanıcın tüm dizi yorumları ve oylamalarını siler ve Kullanıcı nesnesini günceller.
                FirebaseService().removeCurrentUserCommentData(context, 'show');
                Provider.of<UserService>(context, listen: false)
                    .changeUserProperties(showComments: []);
              },
              child: const Text('Kullanıcı dizi verisini sil'),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                // Kullanıcın tüm kitap yorumları ve oylamalarını siler ve Kullanıcı nesnesini günceller.
                FirebaseService().removeCurrentUserCommentData(context, 'book');
                Provider.of<UserService>(context, listen: false)
                    .changeUserProperties(bookComments: []);
              },
              child: const Text('Kullanıcı kitap verisini sil'),
            ),
          ),
          // SizedBox(
          //   width: double.infinity,
          //   child: OutlinedButton(
          //     onPressed: () {
          //       // Tüm kullanıcıların film verisini siler
          //       // kabul edilen parametreler : movie,show,book.
          //       FirebaseService().removeAllUsersCommentData(context, 'movie');
          //     },
          //     child: const Text('Tüm film verisini sil'),
          //   ),
          // ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              // Oturumu kapatır.
              onPressed: () {
                FirebaseService().logOut();
                Provider.of<NavigationService>(context, listen: false)
                    .changePageIndex(0);
              },
              child: const Text('ÇIKIŞ YAP'),
            ),
          ),
        ],
      ),
    );
  }
}
