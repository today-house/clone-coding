import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    return Scaffold(
        appBar: AppBar(title: const Text('홈'), actions: [
          IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, '/setting');
              }),
        ]),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('phoneNumber: ${firebaseUser?.phoneNumber}'),
            // Text('email: ${firebaseUser?.email}'),
            Text('displayName: ${firebaseUser?.displayName}')
          ],
        ));
  }
}
