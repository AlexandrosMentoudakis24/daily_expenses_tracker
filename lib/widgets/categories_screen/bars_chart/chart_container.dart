import 'dart:math';

import 'package:daily_expense_tracker/colors/custom_colors.dart';
import 'package:daily_expense_tracker/widgets/categories_screen/bars_chart/date_filter_buttons_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';

class ChartContainer extends StatefulWidget {
  const ChartContainer({super.key});

  @override
  State<ChartContainer> createState() => _ChartContainerState();
}

class _ChartContainerState extends State<ChartContainer> {
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  var random = Random();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;

        return Stack(
          children: [
            SizedBox(
              width: constraints.maxWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: maxWidth * 0.7,
                    child: const DateFilterButtonsContainer(),
                  ),
                ],
              ),
            ),
            Container(
              height: 150,
              width: constraints.maxWidth,
              margin: const EdgeInsets.only(top: 70),
              child: BarChart(
                BarChartData(
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        reservedSize: 40,
                        showTitles: true,
                        interval: 200,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        reservedSize: 25,
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              value.toString().split(".")[0],
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(),
                    topTitles: AxisTitles(),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: const Border(
                      left: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                      bottom: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                  gridData: const FlGridData(
                    show: false,
                  ),
                  maxY: 1000,
                  groupsSpace: 30,
                  minY: 0,
                  barGroups: [
                    for (int x = 0; x < 7; x++)
                      BarChartGroupData(
                        x: x + 1,
                        barRods: [
                          BarChartRodData(
                            toY: random.nextDouble() * 1000,
                            color: CustomColors.expenseBarFillColor,
                          ),
                          BarChartRodData(
                            toY: random.nextDouble() * 1000,
                            color: CustomColors.incomeBarFillColor,
                          ),
                        ],
                      ),
                  ],
                ),
                swapAnimationCurve: Curves.linear,
              ),
            ),
          ],
        );
      },
    );
  }
}
