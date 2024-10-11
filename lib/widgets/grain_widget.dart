import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class GrainWidget extends StatelessWidget {
  final Widget child;

  const GrainWidget({
    required this.child,
  });

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          ///
          /// SHADER EFFECT
          ///
          ShaderBuilder(
            assetKey: 'assets/shaders/noise.frag',
            (context, shader, child) => AnimatedSampler(
              (image, size, canvas) {
                final paint = Paint()..shader = shader;

                shader
                  ..setFloat(0, size.width)
                  ..setFloat(1, size.height);

                canvas.drawRect(Offset.zero & size, paint);
              },
              child: child ?? Container(),
            ),
          ),

          ///
          /// WIDGET
          ///
          Positioned.fill(
            child: child,
          ),
        ],
      );
}
