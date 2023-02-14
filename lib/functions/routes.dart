import 'package:flutter/material.dart';

import '../constants/routes.dart';

Future<void> goToLoginView(BuildContext context) =>
    Navigator.of(context).pushNamedAndRemoveUntil(
      loginRoute,
      (_) => false,
    );

Future<void> goToRegisterView(BuildContext context) =>
    Navigator.of(context).pushNamedAndRemoveUntil(
      registerRoute,
      (route) => false,
    );

Future<void> goToNotesView(BuildContext context) =>
    Navigator.of(context).pushNamedAndRemoveUntil(
      notesRoute,
      (_) => false,
    );

Future<void> goToVerifyEmailView(BuildContext context, {removeUntil = false}) =>
    removeUntil
        ? Navigator.of(context).pushNamed(verifyEmailRoute)
        : Navigator.of(context).pushNamedAndRemoveUntil(
            verifyEmailRoute,
            (_) => false,
          );
