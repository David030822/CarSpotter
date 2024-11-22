import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsPage extends StatelessWidget {
  final List<_BarData> weeklySalesData = [
    _BarData('Mon', 5),
    _BarData('Tue', 8),
    _BarData('Wed', 10),
    _BarData('Thu', 7),
    _BarData('Fri', 12),
    _BarData('Sat', 6),
    _BarData('Sun', 9),
  ];

  final List<_PieData> monthlySalesData = [
    _PieData('Jan', 20),
    _PieData('Feb', 30),
    _PieData('Mar', 25),
    _PieData('Apr', 40),
    _PieData('May', 35),
    _PieData('Jun', 50),
    _PieData('Jul', 45),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'Car Sales Statistics',
          style: GoogleFonts.dmSerifText(fontSize: 24),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Weekly Sales',
                    style: GoogleFonts.dmSerifText(
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
                Container(
                  height: 300,
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    series: <ChartSeries<_BarData, String>>[
                      ColumnSeries<_BarData, String>(
                        dataSource: weeklySalesData,
                        xValueMapper: (_BarData data, _) => data.xData,
                        yValueMapper: (_BarData data, _) => data.yData,
                        color: Colors.blue,
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40), 
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Monthly Sales',
                    style: GoogleFonts.dmSerifText(
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
                Container(
                  height: 300,
                  child: SfCircularChart(
                    legend: Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.wrap, 
                    ),
                    series: <PieSeries<_PieData, String>>[
                      PieSeries<_PieData, String>(
                        dataSource: monthlySalesData,
                        xValueMapper: (_PieData data, _) => data.xData,
                        yValueMapper: (_PieData data, _) => data.yData,
                        dataLabelMapper: (_PieData data, _) => '${data.yData} cars',
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class _BarData {
  _BarData(this.xData, this.yData);
  final String xData;
  final num yData;
}

class _PieData {
  _PieData(this.xData, this.yData);
  final String xData;
  final num yData;
}
