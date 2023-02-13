import 'dart:async';

import 'package:flutter/material.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) =>
    showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: const Text('An error occurred'),
              content: Text(text),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                )
              ],
            )));
