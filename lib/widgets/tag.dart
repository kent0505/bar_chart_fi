import 'package:flutter/material.dart';

import '../core/utils.dart';
import 'button.dart';

class Tag extends StatelessWidget {
  const Tag({
    super.key,
    required this.id,
    required this.tag,
    required this.onPressed,
  });

  final int id;
  final int tag;
  final void Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 50,
      child: Button(
        onPressed: () {
          onPressed(id);
        },
        minSize: 40,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          height: id == tag ? 50 : 40,
          width: id == tag ? 50 : 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: getColor(id),
          ),
          child: id == tag
              ? Center(
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
