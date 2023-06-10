import 'package:flutter/material.dart';
import 'package:my_comment/components/activity_bar.dart';
import 'package:my_comment/enums/category_enum.dart';

class InteractiveProgressBar extends StatelessWidget {
  const InteractiveProgressBar({
    super.key,
    required this.initialStep,
    required this.barColor,
    required this.category,
    required this.function,
  });

  final int initialStep;
  final Color barColor;
  final Category category;
  final Future<Object?>? function;

  @override
  Widget build(BuildContext context) {
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
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Builder(builder: (context) {
                    if (Category.movie.name == category.name) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(4),
                            child: Text('FİLM'),
                          ),
                          const Text('Sinematör'),
                          Text('$initialStep/$length')
                        ],
                      );
                    } else if (Category.show.name == category.name) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(4),
                            child: Text('DİZİ'),
                          ),
                          const Text('Dizi Delisi'),
                          Text('$initialStep/$length')
                        ],
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(4),
                            child: Text('KİTAP'),
                          ),
                          const Text('Kitap Kurdu'),
                          Text('$initialStep/$length')
                        ],
                      );
                    }
                  }),
                ),
                ActivityBar(
                  currentStep: initialStep,
                  maxSteps: length,
                  color: barColor,
                ),
              ],
            );
          }
        });
  }
}
