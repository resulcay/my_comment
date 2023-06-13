import 'package:flutter/material.dart';
import 'package:my_comment/constants/color_constants.dart';

class TitleWidget extends StatelessWidget {
  final List<Color> colors;
  final String title;

  const TitleWidget({
    Key? key,
    required this.colors,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),

        // Renk geçişi için kullandığımız bir yapıdır.
        gradient: LinearGradient(
          end: Alignment.centerRight,
          colors: colors,
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
              color: ColorConstants.pureWhite,
              fontSize: 25,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
