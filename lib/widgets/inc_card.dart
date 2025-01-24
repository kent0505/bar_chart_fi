import 'package:flutter/material.dart';

import '../core/colors.dart';
import '../models/inc.dart';
import '../pages/edit_inc_sheet.dart';
import 'button.dart';

class IncCard extends StatelessWidget {
  const IncCard({super.key, required this.inc});

  final Inc inc;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Button(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            builder: (context) {
              return EditIncSheet(inc: inc);
            },
          );
        },
        child: Row(
          children: [
            SizedBox(width: 20),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: getColor(inc.tag),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                inc.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'w700',
                ),
              ),
            ),
            SizedBox(width: 10),
            Text(
              inc.income ? '\$${inc.amount}' : '-\$${inc.amount}',
              style: TextStyle(
                color: inc.income ? mainColor : redColor,
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
