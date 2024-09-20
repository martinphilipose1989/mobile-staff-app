import 'dart:ui';
import 'package:flutter/material.dart';

class CommonAppLoader extends StatelessWidget {
  final Color backdropFilterColor;
  final Color? progressColor;
  const CommonAppLoader(
      {super.key,
      this.backdropFilterColor = Colors.black12,
      this.progressColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: backdropFilterColor,
            ),
          ),
        ),
        Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(
                progressColor ?? Theme.of(context).colorScheme.primary),
          ),
        ),
      ],
    );
  }
}
