// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_house/provider/auth/auth_provider.dart';

import 'router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthProvider>(create: (_) => AuthProvider(FirebaseAuth.instance)),
        StreamProvider<User?>(create: (context) => context.read<AuthProvider>().authState, initialData: null),
      ],
      child: MaterialApp(
        initialRoute: '/login',
        // home: const Authenticate(),
        routes: routes,
      ),
    );
  }
}

// class Authenticate extends StatelessWidget {
//   const Authenticate({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final firebaseUser = context.watch<User?>();
//
//     if (firebaseUser != null) {
//       // 로그인한 경우
//       if(firebaseUser.displayName != null){
//         return const HomeScreen();
//       }else{
//         return const AddProfileScreen();
//       }
//     }else{
//       return const LoginScreen();
//     }
//
//   }
// }
