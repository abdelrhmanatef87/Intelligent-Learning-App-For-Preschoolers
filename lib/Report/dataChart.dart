import 'package:charts_flutter/flutter.dart' as charts;

class BarChartModel {
  String questionType;
  int score;
  final charts.Color color;

  BarChartModel({
    required this.questionType,
    required this.score,
    required this.color,
  });
}
