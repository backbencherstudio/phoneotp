import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/route_name.dart';

class LoginScreenProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String? get verificationId => _verificationId;



  Future<void> sendOTP(BuildContext context, String phoneNumber) async {
    _isLoading = true;
    debugPrint("\nLoading status : $_isLoading\n");
    notifyListeners();

    try{
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          debugPrint("Auto Verification Completed");
          _isLoading = false;
          notifyListeners();
        },
        verificationFailed: (FirebaseAuthException e) {
          debugPrint("Verification Failed: ${e.message}");
          _isLoading = false;
          notifyListeners();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${e.message}"),backgroundColor: Colors.red,),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          _isLoading = false;
          notifyListeners();
          debugPrint("\n\n verificationId \n ${_verificationId} \n\n");
          Navigator.pushNamed(context, RouteName.otpscreen, arguments: verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _isLoading = false;
          notifyListeners();
          debugPrint("Code Auto Retrieval Timeout");
        },
      );
    }catch(error){
      _isLoading = false;
      notifyListeners();
      debugPrint("\nError while sending otp : $error\n");
    }
    _isLoading = false;
    notifyListeners();


  }
}
