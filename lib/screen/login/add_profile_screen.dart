import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/auth/auth_provider.dart';

class AddProfileScreen extends StatefulWidget {
  const AddProfileScreen({Key? key}) : super(key: key);

  @override
  State<AddProfileScreen> createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {
  final _nicknameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nicknameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('추가정보 입력'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: ListView(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: _nicknameController,
                    decoration: const InputDecoration(labelText: '닉네임'),
                  ),
                  // TextFormField(
                  //   keyboardType: TextInputType.phone,
                  //   controller: _emailController,
                  //   decoration: const InputDecoration(labelText: 'email'),
                  // ),
                  ElevatedButton(
                      onPressed: () {
                        // 프로필 업데이트 후 homescreen 으로 이동.
                        context.read<AuthProvider>().updateProfile(
                              _nicknameController.text.trim(),
                              _emailController.text.trim(),
                            );
                        Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
                      },
                      child: const Text('입력'))
                ],
              ),
            ),
          )),
    );
  }
}
