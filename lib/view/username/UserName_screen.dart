import 'package:albertyg/view/username/home_screen.dart';
import 'package:albertyg/view/username/mybuttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserNameScreen extends StatefulWidget {
  const UserNameScreen({super.key});

  @override
  _UserNameScreenState createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  TextEditingController usernameController = TextEditingController();
  String? errorText;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.h,
              ),
              Text(
                "Set Username",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 35.h,
              ),
              Text(
                "Let's get started! Enter your username to sign up.",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.black54),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextField(
                controller: usernameController,
                autofocus: true,
                autocorrect: true,

                cursorColor: Color(0xFF04505A),
                decoration: InputDecoration(
                  hintText: "Enter your user name",
                  enabledBorder: OutlineInputBorder(

                      borderRadius: BorderRadius.circular(4.r),
                      borderSide: BorderSide(color: Color(0xFF9BA2A7))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.r),
                      borderSide: BorderSide(color: Color(0xFF04505A))),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.r),
                      borderSide: BorderSide(color: Color(0xFF9BA2A7))),

                  errorText: errorText,
                ),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Color(0xFF000000)),
              ),
              SizedBox(
                height: 32.h,
              ),
              Hero(
                tag: 'nextButton',
                child: Mybuttons(
                  text: "Next",
                  onTap: () {
                    setState(() {
                      if (usernameController.text.isEmpty) {
                        errorText = "Username cannot be empty";
                      } else {
                        errorText = null;
                        print("Next button clicked");
                        showSuccessDialog(context);
                      }
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void showSuccessDialog(BuildContext context) {
    print("showSuccessDialog called");
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
                Text("By creating an account, you agree to our Terms and Conditions."),
                SizedBox(height: 20.h),
                Text("User created successfully!"),
              ],
            ),

            actions: [
              TextButton(

                onPressed: () {
                  usernameController.clear();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomeScreen();
                  }));
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
