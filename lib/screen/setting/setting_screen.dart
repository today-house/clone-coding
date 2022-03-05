import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_house/provider/auth/auth_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('setting')),
      body: ListView(
        children: [
          const ListTile(
            title: Text('language'),
            trailing: Text('개발중'),
          ),
          const ListTile(
            title: Text('theme'),
            trailing: Text('개발중'),
          ),
          ListTile(
            title: const Text('sign out'),
            trailing: ElevatedButton(
              child: const Text('sign out'),
              onPressed: () {
                context.read<AuthProvider>().signOut();
                Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
              },
            ),
          )
        ],
      ),
    );
  }
}

