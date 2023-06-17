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
      height: 170,
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
                    // Resim verisi yüklenirken kurguladığımız yapıdır.
                    loadingBuilder: (context, child, loadingProgress) =>
                        NetworkImageHandler.imageNetworkHandler(
                            context, child, loadingProgress),
                    // Resim verisi yüklenirken hata oluştuğunda kurguladığımız yapıdır.
                    errorBuilder: (_, __, ___) => NetworkImageHandler.onError(),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 35,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: ColorConstants.primaryColor,
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(20))),
                    child: Text(
                      show.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.apply(
                          color: ColorConstants.pureWhite,
                          fontSizeDelta: 0,
                          fontWeightDelta: 3),
                    ),
                  ),
                  Text(
                    '${show.season.toString()} sezon',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.apply(fontSizeDelta: 3, fontStyle: FontStyle.italic),
                  ),
                  Text(
                    '${show.episodes.toString()} bölüm',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.apply(fontSizeDelta: 3, fontWeightDelta: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      '${show.genre} türünde',
                      style: Theme.of(context).textTheme.titleMedium?.apply(
                          fontSizeDelta: 3, fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
