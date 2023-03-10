import 'package:flutter/material.dart';
import 'package:mamba/ui_constants.dart';

class HorizontalStackedBarGraphData {
  final String title;
  double transparency;
  Color color;
  final int ratio;

  HorizontalStackedBarGraphData({
    required this.title,
    required this.transparency,
    required this.color,
    required this.ratio,
  });
}

class HorizontalStackedBarGraph extends StatelessWidget {
  final List<HorizontalStackedBarGraphData> barGraphData;

  const HorizontalStackedBarGraph({
    super.key,
    required this.barGraphData,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: barGraphData
              .map(
                (data) => Flexible(
                  flex: data.ratio,
                  child: Container(
                    color: darkPurple.withOpacity(data.transparency),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          data.title,
                          style: TextStyle(color: data.color),
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
