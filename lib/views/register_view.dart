import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';

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
              FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  )
                  .then((_) => sendEmailVerification(context))
                  // ignore: invalid_return_type_for_catch_error
                  .catchError((e) => showErrorDialog(context, e.message));
            },
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text('Already registered? Log in here!'),
          )
        ],
      ),
    );
  }
}

Future<Object?>? sendEmailVerification(context) =>
    FirebaseAuth.instance.currentUser
        ?.sendEmailVerification()
        .then((_) => Navigator.of(context).pushNamed(verifyEmailRoute))
        // ignore: invalid_return_type_for_catch_error
        .catchError((e) => showErrorDialog(context, e.message));
