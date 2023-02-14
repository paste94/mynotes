import 'package:flutter/material.dart';
import 'package:mynotes/functions/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
      appBar: AppBar(title: const Text('Login')),
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
            child: const Text('Login'),
            onPressed: () {
              final email = _email.text;
              final password = _password.text;
              AuthService.firebase()
                  .logIn(email: email, password: password)
                  .then((_) =>
                      AuthService.firebase().currentUser?.isEmailVerified ??
                              false
                          ?
                          // User's email verified
                          goToNotesView(context)
                          :
                          // User's email NOT verified
                          goToVerifyEmailView(context))
                  .catchError((e) => showErrorDialog(context, e.message));
            },
          ),
          TextButton(
            child: const Text('Not registered yet? Register now here!'),
            onPressed: () => goToRegisterView(context),
          )
        ],
      ),
    );
  }
}
