import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GPALinear extends StatefulWidget {
  @override
  _GPALinearState createState() => _GPALinearState();

  final List data;

  const GPALinear({Key key, this.data}) : super(key: key);
}

class _GPALinearState extends State<GPALinear> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff5fce84),
    const Color(0xfff2a749),
  ];

  List gpas = [];

  @override
  void initState() {
    super.initState();
    for (int i = widget.data.length - 2; i >= 0; i--) {
      gpas.add(widget.data[i]);
    }
  }

//  new Text("学年总绩点：" +
//  widget.data[widget.data.length - 1]['point'].toString()),

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
          padding: const EdgeInsets.only(
              right: 18.0, left: 12.0, top: 24, bottom: 0),
          child: LineChart(
            mainData(),
          )),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            textStyle: TextStyle(
                color: const Color(0xff68737d),
                fontWeight: FontWeight.bold,
                fontSize: 10),
            getTitles: (value) {
              int idx = value.toInt();
              if (idx >= 0 && idx < gpas.length) {
                return gpas[idx]['year'];
              }
              return '';
            },
            margin: 10,
            rotateAngle: -50.0),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: const Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1.0';
              case 3:
                return '3.0';
              case 5:
                return '5.0';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      minX: -1,
      maxX: gpas.length.toDouble(),
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: generateData(this.gpas),
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
        ),
      ],
    );
  }

  List<FlSpot> generateData(List gpas) {
    List<FlSpot> spots = [];
    for (int i = 0; i < gpas.length; i++) {
      FlSpot spot =
          new FlSpot(i.toDouble(), double.parse(gpas[i]['point'].toString()));
      spots.add(spot);
    }
    return spots;
  }
}
