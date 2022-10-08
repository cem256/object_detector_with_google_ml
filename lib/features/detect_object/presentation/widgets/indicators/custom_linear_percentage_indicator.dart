import 'package:flutter/material.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../../core/extensions/context_extensions.dart';

class CustomLinearPercentageIndicator extends StatelessWidget {
  const CustomLinearPercentageIndicator({super.key, required this.prediction});

  final ImageLabel prediction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            prediction.label,
            maxLines: 1,
          ),
        ),
        Expanded(
          flex: 4,
          child: LinearPercentIndicator(
            animation: true,
            animationDuration: 1000,
            animateFromLastPercent: true,
            padding: EdgeInsets.zero,
            lineHeight: context.dynamicHeight(0.03),
            percent: prediction.confidence,
            center: Text("${(prediction.confidence * 100).toStringAsFixed(2)}%"),
            progressColor: context.theme.focusColor,
            backgroundColor: context.theme.scaffoldBackgroundColor,
            barRadius: context.defaultRadius,
          ),
        ),
      ],
    );
  }
}
