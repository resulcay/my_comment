import 'package:flutter/material.dart';
import 'package:my_comment/components/show_card.dart';
import 'package:my_comment/components/title_widget.dart';
import 'package:my_comment/constants/color_constants.dart';
import 'package:my_comment/extensions/media_query_extension.dart';
import 'package:my_comment/models/show_model.dart';
import 'package:my_comment/screens/comment_screen.dart';
import 'package:my_comment/service/firebase_service.dart';

class ShowScreen extends StatelessWidget {
  const ShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Tüm dizileri getirir.
      future: FirebaseService().getAllShows(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // İstek başarılı ise dönen nesneyi dizi modeline atadığımız yerdir.
          List<ShowModel> shows = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: context.height,
              width: context.width,
              child: Column(
                children: [
                  const TitleWidget(
                    title: 'DİZİLER',
                    colors: [
                      ColorConstants.iconColor,
                      ColorConstants.secondaryColor,
                    ],
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: ListView.builder(
                      itemCount: shows.length,
                      itemBuilder: (context, index) => ShowCard(
                        show: shows[index],
                        function: () => _onTap(context, shows[index]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        // Bekleme durumunda gösterilir.
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  _onTap(BuildContext context, Object object) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CommentScreen(object: object),
        ));
  }
}
