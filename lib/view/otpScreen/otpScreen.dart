
import 'package:albertyg/model_view/otp_screen_provider.dart';
import 'package:albertyg/utils/route_name.dart';
import 'package:albertyg/view/widgets/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../model_view/login_screen_provider.dart';

class Otpscreen extends StatelessWidget {
   Otpscreen({super.key});

  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: ()=> Navigator.pop(context),
            icon : Icon(Icons.arrow_back_ios),),
        centerTitle: true,
        title: Text("Enter OPT"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 32.h,
              ),
              Text(
                "Enter the One-Time OTP sent to your to confirm your identity",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black54),
              ),
              SizedBox(
                height: 24.h,
              ),
              PinCodeTextField(
                length: 6,
                obscureText: false,
                controller: otpController,
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(4.r),
                    fieldHeight: 50.h,
                    fieldWidth: 45.w,
                    activeFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    selectedColor: Colors.red,
                    inactiveFillColor: Colors.white,
                    inactiveColor: Colors.red),
                appContext: context,
                animationDuration: Duration(milliseconds: 200),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                onCompleted: (v) {
                  print("Completed");
                },
                onChanged: (value) {},
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");

                  return true;
                },
              ),
              SizedBox(height: 12.h,),
              Row(
                children: [
                  Consumer<OTPScreenProvider>(
                    builder: (context,otpProvider,child) {
                      return IconButton(onPressed: (){
                       otpProvider.toggleCheckMark();
                      },
                          icon:otpProvider.isChecked ? Icon(Icons.check_box,color: CupertinoColors.activeGreen,) : Icon( Icons.check_box_outline_blank,size: 24.r,));
                    }
                  ),
                  Text("I am over this age and I accept the T&C",style: Theme.of(context).textTheme.bodyMedium)
                ],
              ),
              SizedBox(
                height: 32.h,
              ),
              PrimaryButton(
                title: "Submit",
                onTap: context.watch<OTPScreenProvider>().isChecked ? () async  {
                  String vfID = context.read<LoginScreenProvider>().verificationId ?? "";
                  if(vfID.isNotEmpty){
                    await context.read<OTPScreenProvider>().verifyOTP(context, otpController.text, vfID);
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed! Going to previous page..."),backgroundColor: Colors.red,),);
                    Future.delayed(Duration(seconds: 1),);
                    Navigator.pop(context);
                  }

                } : () async {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please accept terms & condition"),backgroundColor: Colors.red,duration: Duration(seconds: 1),),);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}






