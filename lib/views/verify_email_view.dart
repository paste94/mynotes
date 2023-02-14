import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';

import '../functions/routes.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verification')),
      body: Column(children: [
        const Text(
            'We\'ve sent you a verification email. Please open it to verify your account.'),
        const Text(
            'If you haven\'t received a verification email yet, press the button below'),
        TextButton(
            onPressed: () => AuthService.firebase().sendEmailVerification(),
            child: const Text('Send verification mail')),
        TextButton(
            onPressed: () {
              AuthService.firebase()
                  .logOut()
                  .then((_) => goToRegisterView(context))
                  .catchError((e) => showErrorDialog(context, e.message));
            },
            child: const Text('Restart')),
      ]),
    );
  }
}
