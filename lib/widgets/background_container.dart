import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  BackgroundContainer({Key? key,
    this.child,
  }) : super(key: key);

  Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/images/bg.webp"
          ),
          repeat: ImageRepeat.repeat,
        ),
        ),
      child: child,
    );
  }
}
