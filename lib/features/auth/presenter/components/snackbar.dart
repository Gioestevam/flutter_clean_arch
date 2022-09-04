import 'package:flutter/material.dart';

class SnackBarUtil {
  static openSnackBarError(GlobalKey<ScaffoldMessengerState> key, String text) {
    return key.currentState!.showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(text),
          duration: const Duration(seconds: 2)
        )
      );
  }
}
