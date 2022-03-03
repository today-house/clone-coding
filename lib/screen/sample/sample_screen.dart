import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_house/provider/auth/auth_provider.dart';

class SampleScreen extends StatelessWidget {
  const SampleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('기본정보 입력'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Text('기본 정'),
            // ElevatedButton(
            //   onPressed: () {
            //     context.read<AuthProvider>().signOut();
            //   },
            //   child: const Text('로그아웃'),
            // )
          ],
        ),
      ),
    );
  }
}
