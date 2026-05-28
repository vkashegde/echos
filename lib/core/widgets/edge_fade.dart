import 'package:flutter/material.dart';

class EdgeFade extends StatelessWidget {
  const EdgeFade({super.key, required this.child, this.fadeWidth = 24});

  final Widget child;
  final double fadeWidth;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: const [
            Colors.transparent,
            Colors.white,
            Colors.white,
            Colors.transparent,
          ],
          stops: [
            0,
            fadeWidth / bounds.width,
            1 - fadeWidth / bounds.width,
            1,
          ],
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: child,
    );
  }
}
