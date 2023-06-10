import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:my_comment/constants/color_constants.dart';

class ActivityBar extends StatelessWidget {
  final int maxSteps;
  final int currentStep;
  final Color color;
  const ActivityBar({
    super.key,
    required this.maxSteps,
    required this.currentStep,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: LinearProgressBar(
          maxSteps: maxSteps,
          progressType: LinearProgressBar.progressTypeLinear,
          currentStep: currentStep,
          minHeight: 20,
          progressColor: color,
          backgroundColor: ColorConstants.lavender,
        ),
      ),
    );
  }
}
