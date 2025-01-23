import 'package:flutter/material.dart';

class BarChart extends StatefulWidget {
  const BarChart({
    super.key,
    required this.titles,
    required this.values1,
    required this.values2,
  }) : assert(titles.length == values1.length &&
            values1.length == values2.length);

  final List<String> titles;
  final List<double> values1;
  final List<double> values2;

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  final _normalized = ValueNotifier(<double>[]);

  void _zero() {
    _normalized.value = List.generate(
      [
        ...widget.values1,
        ...widget.values2,
      ].length,
      (index) => 0,
    );
  }

  void _normalize() async {
    await Future.delayed(
      const Duration(milliseconds: 200),
      () {
        _normalized.value = [...widget.values1, ...widget.values2];
        double maxVal = _normalized.value.reduce((a, b) => a > b ? a : b);
        _normalized.value = _normalized.value.map((value) {
          return maxVal == 0 ? 0.0 : (value / maxVal) * 120;
        }).toList();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _zero();
    _normalize();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          widget.values1.length,
          (index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ValueListenableBuilder(
                  valueListenable: _normalized,
                  builder: (context, value, child) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _Bar(
                          height: value[index],
                          color: Colors.greenAccent,
                        ),
                        _Bar(
                          height: value[index + widget.values2.length],
                          color: Colors.redAccent,
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  widget.titles[index],
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'w700',
                  ),
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({
    required this.height,
    required this.color,
  });

  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: 14,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
