import 'package:firebase_auth/firebase_auth.dart';
import 'package:today_house/infra/helpers/logger.dart';

class AuthProvider {
  final FirebaseAuth _firebaseAuth;
  late final String _verificationId;
  //FirebaseAuth instance
  AuthProvider(this._firebaseAuth);

  //Using Stream to listen to Authentication State
  Stream<User?> get authState => _firebaseAuth.authStateChanges();

  //SIGN OUT METHOD
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// 전화번호 sms 인증(숫자 6자리 보내기)
  void verifyPhoneNumber(String countryDialCode, String phoneNumber) async {

    void verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
      await _firebaseAuth.signInWithCredential(phoneAuthCredential);
      log.i('Phone number automatically verified and user signed in: ${_firebaseAuth.currentUser?.uid}');
    }

    void verificationFailed(FirebaseAuthException authException) async {
      log.e('aPhone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
    }

    void codeSent(String verificationId, int? forceResendingToken) async {
      _verificationId = verificationId;
      log.i('Please check your phone for the verification code.');
    }

    void codeAutoRetrievalTimeout(String verificationId) {
      _verificationId = verificationId;
    }

    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: countryDialCode + phoneNumber,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      log.e('Failed to Verify Phone Number', e);
      // showSnackbar('verifyPhoneNumber', 'Failed to Verify Phone Number: $e');
    }
  }

  /// 전화번호 인증: verificationId, smsCode 로 인증
  void signInWithPhoneNumber(String smsCode) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: smsCode,
      );
      final User? user = (await _firebaseAuth.signInWithCredential(credential)).user;
      log.i('Successfully signed in : $user');
    } catch (e) {
      log.e('Failed to sign in', e);
    }
  }

  /// 닉네임 이메일 업데이트
  void updateProfile(String nickName, String email){
    _firebaseAuth.currentUser?.updateDisplayName(nickName);
    _firebaseAuth.currentUser?.updateEmail(email);
  }

}