import 'package:flutter/material.dart';
import 'package:mentoons/utils/colors.dart';

class DefaultContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final Color? color;
  final BorderRadius? borderRadius;

  const DefaultContainer({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.color,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,

      decoration: BoxDecoration(
        color: color ?? Colors.white,

        borderRadius: borderRadius ?? BorderRadius.circular(16),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: child,
    );
  }
}
