import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_house/infra/helpers/logger.dart';
import 'package:your_house/provider/auth/auth_provider.dart';
import 'package:your_house/screen/home/home_screen.dart';
import 'package:your_house/screen/login/add_profile_screen.dart';

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
  void initState() {
    super.initState();
    _phoneNumberController.text = '11-2222-3333'; /// test 번호 인증번호 111111
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _smsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      // 로그인한 경우
      if(firebaseUser.displayName != null){
        return const HomeScreen();
      }else{
        return const AddProfileScreen();
      }
    }else{
      return SafeArea(
        child: Scaffold(
          body: _phoneTab(context),
        ),
      );
    }
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
            decoration: InputDecoration(
                labelText: '전화번호',
                suffixIcon: IconButton(
                  onPressed: () {
                    log.i('📞 $_dialCode ${_phoneNumberController.text.trim()}');
                    context.read<AuthProvider>().verifyPhoneNumber(_dialCode, _phoneNumberController.text.trim());
                  },
                  icon: const Icon(Icons.send),

                )),
          ),
          TextFormField(
            keyboardType: TextInputType.phone,
            controller: _smsController,
            maxLength: 6,
            decoration: InputDecoration(labelText: '인증번호', suffix: ElevatedButton(
              child: const Text('인증'),
              onPressed: () {
                context.read<AuthProvider>().signInWithPhoneNumber(_smsController.text.trim());
              },
            )),
          ),
        ],
      ),
    );
  }
}
