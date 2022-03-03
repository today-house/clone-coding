import 'package:flutter/material.dart';
import 'package:today_house/infra/helpers/logger.dart';
import 'package:today_house/provider/auth/auth_provider.dart';
import 'package:provider/provider.dart';

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
    return _phoneTab(context);
  }

  Widget _phoneTab(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20.0,
        ),
        TextFormField(
          keyboardType: TextInputType.phone,
          controller: _phoneNumberController,
          decoration: const InputDecoration(labelText: 'Phone number(xxx-xxxx-xxxx)'),
        ),
        ElevatedButton(
          child: const Text('Verify Number'),
          onPressed: () {
            log.i('📞 $_dialCode ${_phoneNumberController.text.trim()}');
            context.read<AuthProvider>().verifyPhoneNumber(_dialCode, _phoneNumberController.text.trim());
          },
        ),
        TextFormField(
          keyboardType: TextInputType.phone,
          controller: _smsController,
          maxLength: 6,
          decoration: const InputDecoration(labelText: 'Verification code'),
        ),
        ElevatedButton(
          child: const Text('Sign in'),
          onPressed: () {
            context.read<AuthProvider>().signInWithPhoneNumber(_smsController.text.trim());
          },
        ),
      ],
    );
  }

}

