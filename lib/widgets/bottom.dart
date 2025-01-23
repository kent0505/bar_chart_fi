import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bottom/bottom_bloc.dart';
import 'button.dart';

class Bottom extends StatelessWidget {
  const Bottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(
          bottom: 20,
          left: 20,
          right: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: BlocBuilder<BottomBloc, BottomState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _BottomButton(
                  bottom: 1,
                  icons: Icons.home_rounded,
                  active: state is BottomInitial,
                ),
                _BottomButton(
                  bottom: 2,
                  icons: Icons.add_rounded,
                  active: state is BottomInc,
                ),
                _BottomButton(
                  bottom: 3,
                  icons: Icons.remove_rounded,
                  active: state is BottomExp,
                ),
                _BottomButton(
                  bottom: 4,
                  icons: Icons.bar_chart_rounded,
                  active: state is BottomStats,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _BottomButton extends StatelessWidget {
  const _BottomButton({
    required this.bottom,
    required this.icons,
    required this.active,
  });

  final int bottom;
  final IconData icons;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: active
          ? null
          : () {
              context.read<BottomBloc>().add(SwitchBottom(bottom: bottom));
            },
      padding: 0,
      child: SizedBox(
        width: 62,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Icon(
              icons,
              size: 30,
              color: active ? Colors.black : Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
