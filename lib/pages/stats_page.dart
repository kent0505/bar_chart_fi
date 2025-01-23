import 'package:bar_chart_fi/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/inc/inc_bloc.dart';
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
              final today = state.incList
                  .where((element) => isToday(element.id))
                  .toList();
              final todayInc = today.where((inc) => inc.income).toList();
              final todayExp = today.where((inc) => !inc.income).toList();

              return BarChart(
                titles: ['Today'],
                values1: [todayInc.fold(0, (sum, inc) => sum + inc.amount)],
                values2: [todayExp.fold(0, (sum, inc) => sum + inc.amount)],
              );
            }

            return Container();
          },
        ),
      ],
    );
  }
}
