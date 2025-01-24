import 'package:flutter/material.dart';

import 'button.dart';

class SheetWidget extends StatelessWidget {
  const SheetWidget({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 250,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            child: body,
          ),
          Positioned(
            right: 10,
            top: 10,
            child: Button(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close_rounded,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
