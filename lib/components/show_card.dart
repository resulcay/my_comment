import 'package:flutter/material.dart';
import 'package:my_comment/constants/color_constants.dart';
import 'package:my_comment/models/show_model.dart';
import 'package:my_comment/service/network_image_handler.dart';

class ShowCard extends StatelessWidget {
  final ShowModel show;
  final void Function() function;
  const ShowCard({
    Key? key,
    required this.show,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 94,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorConstants.secondaryColor.withOpacity(.4)),
      child: InkWell(
        onTap: function,
        splashColor: ColorConstants.secondaryColor,
        borderRadius: BorderRadius.circular(20),
        child: Row(
          children: [
            SizedBox(
              width: 125,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                child: Hero(
                  tag: show.id,
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
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Flexible(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Divider(
                            thickness: 1,
                            color: ColorConstants.richBlack,
                          ),
                        ),
                      ),
                      Text(
                        show.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.apply(
                            color: ColorConstants.pureBlack,
                            fontSizeDelta: -5,
                            fontWeightDelta: 3),
                      ),
                      const Flexible(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Divider(
                            thickness: 1,
                            color: ColorConstants.richBlack,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${show.season.toString()} sezon',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.apply(fontStyle: FontStyle.italic),
                          ),
                          Text(
                            '${show.episodes.toString()} bölüm',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.apply(fontWeightDelta: 1),
                          ),
                          Text(
                            '${show.genre} türünde',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.apply(fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
