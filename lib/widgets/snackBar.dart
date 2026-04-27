import 'dart:ui';

import 'package:flutter/material.dart';

void showPillSnackBar(
  BuildContext context,
  String message, {
  Color backgroundColor = Colors.black,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),

      backgroundColor: backgroundColor,

      behavior: SnackBarBehavior.floating,

      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),

      duration: const Duration(seconds: 2),

      elevation: 6,
    ),
  );
}
