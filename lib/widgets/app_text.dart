import 'package:flutter/material.dart';
import 'package:mentoons/utils/app_fonts.dart';
 
class AppText extends StatelessWidget {

  final String text;
  final double size;
  final Color color;
  final String font;
  final FontWeight weight;
  final TextAlign align;

  const AppText({
    super.key,
    required this.text,
    this.size = 16,
    this.color = Colors.black,
    this.font = AppFonts.helvetica,
    this.weight = FontWeight.normal,
    this.align = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontFamily: font,
        fontWeight: weight,
      ),
    );
  }
}