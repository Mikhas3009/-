import 'package:flutter/material.dart';

void showSnackBar(context, String title) {
  final snackBar = SnackBar(
    content: Text(title),
    duration: const Duration(milliseconds: 2000),
    width: 300,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
