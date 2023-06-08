import 'package:flutter/material.dart';
import 'package:my_comment/components/show_card.dart';
import 'package:my_comment/components/title_widget.dart';
import 'package:my_comment/constants/color_constants.dart';
import 'package:my_comment/extensions/media_query_extension.dart';
import 'package:my_comment/models/show_model.dart';
import 'package:my_comment/service/firebase_service.dart';

class ShowScreen extends StatelessWidget {
  const ShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseService().getAllShows(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
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
                      itemBuilder: (context, index) =>
                          ShowCard(show: shows[index]),
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
