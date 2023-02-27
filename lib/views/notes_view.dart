import 'package:flutter/material.dart';
import 'package:mynotes/functions/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';

import '../enums/menu_action.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main UI'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  bool shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    try {
                      await AuthService.firebase().logOut();
                      if (!mounted) return;
                      goToLoginView(context);
                    } catch (e) {
                      if (!mounted) return;
                      showErrorDialog(context, e.toString());
                    }
                  }
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Log out'),
                )
              ];
            },
          )
        ],
      ),
      body: const Text('Notes'),
    );
  }
}
