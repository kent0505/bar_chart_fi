import 'package:flutter/material.dart';

import '../pages/sort_sheet.dart';
import 'button.dart';

class Sort extends StatelessWidget {
  const Sort({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Align(
        alignment: Alignment.centerRight,
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
                return SortSheet();
              },
            );
          },
          child: Text(
            'Sort',
            textAlign: TextAlign.end,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'w700',
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }
}
