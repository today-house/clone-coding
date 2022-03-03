import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_house/infra/helpers/logger.dart';
import 'package:today_house/provider/auth/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _dialCode = '+82';
  final _phoneNumberController = TextEditingController();
  final _smsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _phoneTab(context),
      ),
    );
  }

  Widget _phoneTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: ListView(
        children: [
          const SizedBox(
            height: 40.0,
          ),
          const Center(child: Text('실력자들', style: TextStyle(fontSize: 40.0))),
          const SizedBox(
            height: 20.0,
          ),
          TextFormField(
            keyboardType: TextInputType.phone,
            controller: _phoneNumberController,
            decoration: const InputDecoration(labelText: '전화번호'),
          ),
          ElevatedButton(
            child: const Text('문자 전송'),
            onPressed: () {
              log.i('📞 $_dialCode ${_phoneNumberController.text.trim()}');
              context.read<AuthProvider>().verifyPhoneNumber(_dialCode, _phoneNumberController.text.trim());
            },
          ),
          TextFormField(
            keyboardType: TextInputType.phone,
            controller: _smsController,
            maxLength: 6,
            decoration: const InputDecoration(labelText: '인증번호'),
          ),
          ElevatedButton(
            child: const Text('로그인'),
            onPressed: () {
              context.read<AuthProvider>().signInWithPhoneNumber(_smsController.text.trim());
            },
          ),
        ],
      ),
    );
  }
}
