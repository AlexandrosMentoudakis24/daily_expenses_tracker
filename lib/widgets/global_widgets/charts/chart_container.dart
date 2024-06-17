import 'package:daily_expense_tracker/models/transaction.dart';
import 'package:daily_expense_tracker/widgets/modals/modal_contents.dart/choose_modal_content.dart';
import 'package:flutter/material.dart';

import 'package:daily_expense_tracker/widgets/global_widgets/charts/date_filter_buttons_container.dart';
import 'package:daily_expense_tracker/widgets/global_widgets/charts/lines_chart/lines_chart.dart';
import 'package:daily_expense_tracker/widgets/global_widgets/charts/bars_chart/bars_chart.dart';
import 'package:daily_expense_tracker/utils/enum_values/enum_values.dart';

enum DisplayedLinesTransactions {
  all,
}

class ChartContainer extends StatefulWidget {
  const ChartContainer({
    ChartType? chartType,
    super.key,
  }) : chartType = chartType ?? ChartType.bars;

  final ChartType? chartType;

  @override
  State<ChartContainer> createState() => _ChartContainerState();
}

class _ChartContainerState extends State<ChartContainer> {
  var _activeDateSection = DateSection.values[0];
  var _showExpenses = true;
  var _showIncomes = true;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;

        return Stack(
          children: [
            IconButton(
              onPressed: () async {
                final choise = await showModalBottomSheet(
                  context: context,
                  builder: (context) => chooseModalContent(
                    context,
                    [
                      ...DisplayedLinesTransactions.values,
                      ...TransactionType.values,
                    ],
                    {
                      DisplayedLinesTransactions.all: Icons.money,
                      TransactionType.income: Icons.wallet,
                      TransactionType.expense: Icons.euro_symbol_outlined,
                    },
                    "Select Displayed Category",
                  ),
                );

                if (choise == null) return;

                if (choise == DisplayedLinesTransactions.all) {
                  setState(() {
                    _showExpenses = true;
                    _showIncomes = true;
                  });

                  return;
                }

                if (choise == TransactionType.income) {
                  setState(() {
                    _showExpenses = false;
                    _showIncomes = true;
                  });
                } else {
                  setState(() {
                    _showExpenses = true;
                    _showIncomes = false;
                  });
                }
              },
              icon: const Icon(
                Icons.remove_red_eye,
                color: Colors.white,
                size: 30,
              ),
            ),
            SizedBox(
              width: constraints.maxWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: maxWidth * 0.7,
                    child: DateFilterButtonsContainer(
                      onDateTypeChangedHandler: (newDateSection) {
                        setState(() {
                          _activeDateSection = newDateSection;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 150,
              width: constraints.maxWidth,
              margin: EdgeInsets.only(
                top: 70,
                right: widget.chartType == ChartType.lines ? 15.0 : 0.0,
              ),
              child: widget.chartType == ChartType.bars
                  ? BarsChart(
                      dateSection: _activeDateSection,
                      showIncomes: _showIncomes,
                      showExpenses: _showExpenses,
                    )
                  : LinesChart(
                      dateSection: _activeDateSection,
                      showIncomes: _showIncomes,
                      showExpenses: _showExpenses,
                    ),
            ),
          ],
        );
      },
    );
  }
}
