// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_house/provider/auth/auth_provider.dart';
import 'package:today_house/screen/login/login_screen.dart';
import 'package:today_house/screen/sample/sample_screen.dart';

import 'router.dart';

/// This is a reimplementation of the default Flutter application using provider + [ChangeNotifier].

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // context.read<AuthProvider>().
    return MultiProvider(
      providers: [
        Provider<AuthProvider>(
          create: (_) => AuthProvider(FirebaseAuth.instance),
        ),
        StreamProvider<User?>(
          create: (context) => context.read<AuthProvider>().authState,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        // initialRoute: '/',
        home: const Authenticate(),
        routes: routes,
      ),
    );
  }
}

class Authenticate extends StatelessWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const SampleScreen();
    }
    return const LoginScreen();
  }
}