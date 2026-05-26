import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignOutTile extends StatelessWidget {
  final Function signOut;

  const SignOutTile({super.key, required this.signOut});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: ColorScheme.of(context).error,
      title: Text(
        'SignOut',
        style: TextStyle(color: ColorScheme.of(context).onError),
      ),
      leading: Icon(
        FontAwesomeIcons.arrowRightFromBracket,
        color: ColorScheme.of(context).onError,
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Sign out'),
              content: const Text('Are you sure you want to sign out?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    signOut();
                    //Navigator.pushReplacementNamed(context, 'login');
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: ColorScheme.of(context).errorContainer,
                  ),
                  child: Text(
                    'Sign out',
                    style: TextStyle(
                      color: ColorScheme.of(context).onErrorContainer,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
