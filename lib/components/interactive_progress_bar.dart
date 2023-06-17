import 'package:flutter/material.dart';
import 'package:my_comment/components/activity_bar.dart';
import 'package:my_comment/constants/text_constants.dart';
import 'package:my_comment/enums/category_enum.dart';
import 'package:my_comment/models/user_model.dart';
import 'package:my_comment/service/user_service.dart';
import 'package:provider/provider.dart';

class InteractiveProgressBar extends StatelessWidget {
  const InteractiveProgressBar({
    super.key,
    required this.barColor,
    required this.category,
    required this.function,
  });

  final Color barColor;
  final Category category;
  final Future<Object?>? function;

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

    return FutureBuilder(
        future: function,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox(
                height: 100,
                width: double.infinity,
                child: Center(child: CircularProgressIndicator()));
          } else {
            List<Object> array = snapshot.data as List<Object>;
            int length = array.length;
            return Padding(
              padding: const EdgeInsets.all(4),
              child: Builder(builder: (context) {
                List<String> tags = TextConstants.tags;
                if (Category.movie.name == category.name) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              'FİLM',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(width: 1)),
                            child: Text(
                              // Sıfat sayısını toplam bar uzunluğundan küçük olması şartını tanımlıyoruz.
                              // Aksi halde son sıfat gösterilir.
                              (tags.length > movieCount)
                                  ? tags[movieCount]
                                  : tags.last,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          Text(
                            '$movieCount/$length',
                            style: Theme.of(context).textTheme.titleSmall,
                          )
                        ],
                      ),
                      ActivityBar(
                        currentStep: movieCount,
                        maxSteps: length,
                        color: barColor,
                      )
                    ],
                  );
                } else if (Category.show.name == category.name) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              'DİZİ',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(width: 1)),
                            child: Text(
                              // Sıfat sayısını toplam bar uzunluğundan küçük olması şartını tanımlıyoruz.
                              // Aksi halde son sıfat gösterilir.
                              (tags.length > movieCount)
                                  ? tags[movieCount]
                                  : tags.last,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          Text(
                            '$showCount/$length',
                            style: Theme.of(context).textTheme.titleSmall,
                          )
                        ],
                      ),
                      ActivityBar(
                        currentStep: showCount,
                        maxSteps: length,
                        color: barColor,
                      )
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              'KİTAP',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(width: 1)),
                            child: Text(
                              // Sıfat sayısını toplam bar uzunluğundan küçük olması şartını tanımlıyoruz.
                              // Aksi halde son sıfat gösterilir.
                              (tags.length > movieCount)
                                  ? tags[movieCount]
                                  : tags.last,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          Text(
                            '$bookCount/$length',
                            style: Theme.of(context).textTheme.titleSmall,
                          )
                        ],
                      ),
                      ActivityBar(
                        currentStep: bookCount,
                        maxSteps: length,
                        color: barColor,
                      )
                    ],
                  );
                }
              }),
            );
          }
        });
  }
}
