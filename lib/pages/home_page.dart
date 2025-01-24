import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bottom/bottom_bloc.dart';
import '../bloc/inc/inc_bloc.dart';
import '../core/utils.dart';
import '../widgets/balance_card.dart';
import '../widgets/bottom.dart';
import '../widgets/inc_card.dart';
import '../widgets/loading.dart';
import '../widgets/no_data.dart';
import 'stats_page.dart';
import 'add_inc_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<IncBloc, IncState>(
        builder: (context, state) {
          if (state is IncLoading) return Loading();

          return Stack(
            children: [
              BlocConsumer<BottomBloc, BottomState>(
                listener: (context, state) {
                  logger(state.runtimeType);
                },
                builder: (context, state) {
                  if (state is BottomInc) return AddIncPage(income: true);

                  if (state is BottomExp) return AddIncPage(income: false);

                  if (state is BottomStats) return StatsPage();

                  return _Home();
                },
              ),
              const Bottom(),
            ],
          );
        },
      ),
    );
  }
}

class _Home extends StatelessWidget {
  const _Home();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IncBloc, IncState>(
      builder: (context, state) {
        if (state is IncLoaded) {
          return Stack(
            children: [
              BalanceCard(),
              Container(
                margin: EdgeInsets.only(top: 250),
                decoration: BoxDecoration(
                  color: Color(0xffF5F5F5),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: state.incList.isEmpty
                    ? NoData()
                    : ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        child: ListView.builder(
                          padding: EdgeInsets.all(20).copyWith(bottom: 90),
                          itemCount: state.incList.length,
                          itemBuilder: (context, index) {
                            return IncCard(inc: state.incList[index]);
                          },
                        ),
                      ),
              ),
            ],
          );
        }

        return Container();
      },
    );
  }
}
