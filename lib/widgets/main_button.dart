import 'package:flutter/material.dart';

import 'button.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.title,
    this.width,
    this.active = true,
    this.color = const Color(0xff74c69d),
    required this.onPressed,
  });

  final String title;
  final double? width;
  final bool active;
  final Color color;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 50,
      width: width,
      decoration: BoxDecoration(
        color: active ? color : Colors.black.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Button(
        onPressed: active ? onPressed : null,
        padding: 0,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color:
                  active ? Colors.white : Colors.white.withValues(alpha: 0.5),
              fontSize: 18,
              fontFamily: 'w700',
            ),
          ),
        ),
      ),
    );
  }
}
