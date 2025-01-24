import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  const NoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No data',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontFamily: 'w700',
        ),
      ),
    );
  }
}
