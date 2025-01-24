import 'package:flutter/material.dart';

import '../core/utils.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      color: Colors.greenAccent,
      child: Row(
        children: [
          SizedBox(width: 50),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 120),
                Text(
                  'Balance',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'w700',
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '\$${getIncomes() - getExpenses()}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontFamily: 'w800',
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(height: 130),
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 20),
                  _Amount(getIncomes()),
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
                      color: Colors.redAccent,
                    ),
                  ),
                  SizedBox(width: 20),
                  _Amount(getExpenses()),
                ],
              ),
            ],
          ),
          SizedBox(width: 50),
        ],
      ),
    );
  }
}

class _Amount extends StatelessWidget {
  const _Amount(this.amount);

  final double amount;

  @override
  Widget build(BuildContext context) {
    return Text(
      '\$$amount',
      style: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontFamily: 'w700',
      ),
    );
  }
}
