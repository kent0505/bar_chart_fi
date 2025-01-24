import 'package:flutter/cupertino.dart';

import '../core/colors.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        radius: 15,
        color: mainColor,
      ),
    );
  }
}
