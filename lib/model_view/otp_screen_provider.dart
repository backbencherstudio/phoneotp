import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/route_name.dart';

class OTPScreenProvider extends ChangeNotifier {

  bool _isChecked = false;
  bool get isChecked => _isChecked;

  void toggleCheckMark(){
    _isChecked = !_isChecked;
    notifyListeners();
  }

  PhoneAuthCredential? _credential;
  PhoneAuthCredential? get credential => _credential;

  Future<void> verifyOTP(BuildContext context, String otp, String vfID) async {
    try {
      // Create a PhoneAuthCredential
       _credential = PhoneAuthProvider.credential(
        verificationId: vfID,
        smsCode: otp,
      );
       // Try signing in with the credential
       UserCredential userCredential =
       await FirebaseAuth.instance.signInWithCredential(_credential!);

       // If successful, navigate to the username screen
       if (userCredential.user != null) {
         debugPrint("OTP Verification Successful");
         Navigator.pushNamed(
           context,
           RouteName.usernamescreen,
           arguments: credential,
         );
       } else {
         throw FirebaseAuthException(
           code: "invalid-verification-code",
           message: "Invalid OTP provided. Please try again.",
         );
       }
    } on FirebaseAuthException catch (e) {
      debugPrint("OTP Verification Failed: ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.message}"), backgroundColor: Colors.red),
      );
    } catch (e) {
      debugPrint("An error occurred: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An unexpected error occurred."), backgroundColor: Colors.red),
      );
    }
  }


}
