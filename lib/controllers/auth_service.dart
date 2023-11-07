import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static String verifyId = "";
  // function to send an OTP to user

  static Future sendOtp(
      {required String phone,
      required Function errorStep,
      required Function nextStep}) async {
    await _firebaseAuth
        .verifyPhoneNumber(
            timeout: Duration(seconds: 30),
            phoneNumber: "+91$phone",
            verificationCompleted: (PhoneAuthCredential) async {
              return;
            },
            verificationFailed: (error) async {
              return;
            },
            //fuction used when we have completed sending a code
            codeSent: (verificationId, forceResendingToken) async {
              verifyId = verificationId;
              nextStep();
            },
            codeAutoRetrievalTimeout: (verificationId) async {
              return;
            })
        .onError((error, stackTrace) {
      errorStep();
    });
  }

  // fuction to verify the OTP code and login

  static Future loginWithOtp({required String otp}) async {
    final cred = // credietial
        PhoneAuthProvider.credential(verificationId: verifyId, smsCode: otp);

    try {
      final user = await _firebaseAuth.signInWithCredential(cred);
      if (user.user != null) {
        return "success";
      } else {
        return "Error loggin in using OTP ";
      }
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  // to logout the user
  static Future logout() async {
    await _firebaseAuth.signOut();
  }

  // to check if the user is logged in or not
  static Future<bool> isLoggedIn() async {
    var user = _firebaseAuth.currentUser;
    return user != null;
  }
}
