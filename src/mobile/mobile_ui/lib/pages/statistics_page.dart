import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';


class StatisticsPage extends StatelessWidget {
  final List<int> weeklySalesData = [5, 8, 10, 7, 12, 6, 9]; // Example data for cars sold each week
  final List<int> monthlySalesData = [20, 30, 25, 40, 35, 50, 45]; // Example data for cars sold each month

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Car Sales Statistics', style: GoogleFonts.dmSerifText(fontSize: 24)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25, bottom: 10),
              child: Text(
                'Sales Statistics',
                style: GoogleFonts.dmSerifText(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: true),
                  barGroups: List.generate(weeklySalesData.length, (index) {
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          y: weeklySalesData[index].toDouble(), // Use 'y' instead of 'toY'
                          colors: [Colors.blue], // Correct color assignment
                          width: 15,
                          borderRadius: BorderRadius.zero,
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: true),
                  barGroups: List.generate(monthlySalesData.length, (index) {
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          y: monthlySalesData[index].toDouble(), // Use 'y' instead of 'toY'
                          colors: [Colors.green], // Correct color assignment
                          width: 15,
                          borderRadius: BorderRadius.zero,
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
