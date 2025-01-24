import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/inc/inc_bloc.dart';
import '../core/colors.dart';
import '../core/utils.dart';
import '../widgets/bar_chart.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20).copyWith(bottom: 90),
      children: [
        SizedBox(
          height: MediaQuery.of(context).viewPadding.top,
        ),
        BlocBuilder<IncBloc, IncState>(
          builder: (context, state) {
            if (state is IncLoaded) {
              final todayInc = getTodayAmount(true);
              final todayExp = getTodayAmount(false);

              final weekInc = getCurrentWeekAmounts(true);
              final weekExp = getCurrentWeekAmounts(false);

              final monthInc = getCurrentMonthAmounts(true);
              final monthExp = getCurrentMonthAmounts(false);

              return Column(
                children: [
                  BarChart(
                    titles: [getWeekday()],
                    values1: [todayInc],
                    values2: [todayExp],
                  ),
                  SizedBox(height: 20),
                  _Data(
                    incomes: todayInc,
                    expenses: todayExp,
                  ),
                  SizedBox(height: 20),
                  BarChart(
                    titles: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                    values1: weekInc,
                    values2: weekExp,
                  ),
                  SizedBox(height: 20),
                  _Data(
                    incomes: weekInc.fold(0.0, (sum, value) => sum + value),
                    expenses: weekExp.fold(0.0, (sum, value) => sum + value),
                  ),
                  SizedBox(height: 20),
                  BarChart(
                    titles: ['W1', 'W2', 'W3', 'W4'],
                    values1: monthInc,
                    values2: monthExp,
                  ),
                  SizedBox(height: 20),
                  _Data(
                    incomes: monthInc.fold(0.0, (sum, value) => sum + value),
                    expenses: monthExp.fold(0.0, (sum, value) => sum + value),
                  ),
                  SizedBox(height: 20),
                ],
              );
            }

            return Container();
          },
        ),
      ],
    );
  }
}

class _Data extends StatelessWidget {
  const _Data({
    required this.incomes,
    required this.expenses,
  });

  final double incomes;
  final double expenses;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: mainColor,
              ),
            ),
            SizedBox(width: 10),
            Text(
              '\$$incomes',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'w700',
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: redColor,
              ),
            ),
            SizedBox(width: 10),
            Text(
              '\$$expenses',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'w700',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
