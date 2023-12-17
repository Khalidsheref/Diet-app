import 'package:flutter/material.dart';

class SlidingText extends StatelessWidget {
  const SlidingText({
    Key? key,
    required this.slidingAnimation,
  }) : super(key: key);

  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slidingAnimation,
      builder: (context, _) {
        return SlideTransition(
          position: slidingAnimation,
          child: const Text(
            'Healthy LifeStyle',
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
