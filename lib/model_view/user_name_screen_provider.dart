import 'package:flutter/material.dart';

class UserNameScreenProvider extends ChangeNotifier {
  TextEditingController usernameController = TextEditingController();
  String? errorText;

  void validateUsername() {
    if (usernameController.text.isEmpty) {
      errorText = "Username cannot be empty";
    } else {
      errorText = null;
    }
    notifyListeners();
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Hero(
          tag: 'nextButton',
          child: AlertDialog(
            title: Text("Terms and Conditions"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    "By creating an account, you agree to our Terms and Conditions."),
                SizedBox(height: 20),
                Text("User created successfully!"),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          ),
        );
      },
    );
  }
}
