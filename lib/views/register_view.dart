import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';

import '../functions/routes.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration:
                const InputDecoration(hintText: 'Enter your email here'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration:
                const InputDecoration(hintText: 'Enter your password here'),
          ),
          TextButton(
            child: const Text('Register'),
            onPressed: () {
              final email = _email.text;
              final password = _password.text;
              AuthService.firebase()
                  .createUser(
                    email: email,
                    password: password,
                  )
                  .then((_) => sendEmailVerification(context))
                  .catchError((e) {
                showErrorDialog(context, e.message);
              });
            },
          ),
          TextButton(
            onPressed: () => goToLoginView(context),
            child: const Text('Already registered? Log in here!'),
          )
        ],
      ),
    );
  }
}

Future<Object?>? sendEmailVerification(context) => AuthService.firebase()
    .sendEmailVerification()
    .then((_) => goToVerifyEmailView(context, removeUntil: true))
    .catchError((e) => showErrorDialog(context, e.message));
