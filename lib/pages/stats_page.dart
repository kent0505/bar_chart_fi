import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/inc/inc_bloc.dart';
import '../core/utils.dart';
import '../widgets/bar_chart.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        SizedBox(
          height: MediaQuery.of(context).viewPadding.top,
        ),
        BlocBuilder<IncBloc, IncState>(
          builder: (context, state) {
            if (state is IncLoaded) {
              return Column(
                children: [
                  BarChart(
                    titles: [getWeekday()],
                    values1: [getTodayAmount(true)],
                    values2: [getTodayAmount(false)],
                  ),
                  SizedBox(height: 20),
                  BarChart(
                    titles: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                    values1: getCurrentWeekAmounts(true),
                    values2: getCurrentWeekAmounts(false),
                  ),
                  SizedBox(height: 20),
                  BarChart(
                    titles: ['w1', 'w2', 'w3', 'w4'],
                    values1: [10, 20, 30, 40],
                    values2: [40, 30, 20, 10],
                  ),
                  SizedBox(height: 100),
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
