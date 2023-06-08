import 'package:flutter/material.dart';
import 'package:my_comment/constants/color_constants.dart';
import 'package:my_comment/models/show_model.dart';
import 'package:my_comment/service/network_image_handler.dart';

class ShowCard extends StatelessWidget {
  final ShowModel show;
  const ShowCard({
    Key? key,
    required this.show,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorConstants.secondaryColor.withOpacity(.4)),
      child: Row(
        children: [
          SizedBox(
            width: 125,
            height: 200,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              child: Image.network(
                fit: BoxFit.cover,
                show.imagePath,
                loadingBuilder: (context, child, loadingProgress) =>
                    NetworkImageHandler.imageNetworkHandler(
                        context, child, loadingProgress),
                errorBuilder: (_, __, ___) => NetworkImageHandler.onError(),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: ColorConstants.primaryColor.withOpacity(.6),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20))),
                  child: Center(
                    child: Text(
                      show.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.apply(
                          color: ColorConstants.pureBlack,
                          fontSizeDelta: 3,
                          fontWeightDelta: 3),
                    ),
                  ),
                ),
                Text(
                  '${show.season.toString()} sezon',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.apply(fontStyle: FontStyle.italic),
                ),
                Text(
                  '${show.episodes.toString()} bölüm',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.apply(fontWeightDelta: 1),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    '${show.genre} türünde',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.apply(fontStyle: FontStyle.italic),
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
