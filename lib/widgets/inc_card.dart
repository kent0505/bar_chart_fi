import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/inc/inc_bloc.dart';
import '../models/inc.dart';
import 'button.dart';

class IncCard extends StatelessWidget {
  const IncCard({super.key, required this.inc});

  final Inc inc;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Button(
        onPressed: () {
          context.read<IncBloc>().add(UpdateInc(inc: inc, delete: true));
        },
        child: Row(
          children: [
            SizedBox(width: 20),
            Expanded(
              child: Text(
                inc.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'w700',
                ),
              ),
            ),
            Text(
              '\$${inc.amount}',
              style: TextStyle(
                color: Colors.orangeAccent,
                fontSize: 16,
                fontFamily: 'w700',
              ),
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
