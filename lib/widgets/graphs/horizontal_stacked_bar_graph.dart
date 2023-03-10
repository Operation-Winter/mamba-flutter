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
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            blurRadius: 3,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
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
    );
  }
}
