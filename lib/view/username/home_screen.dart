import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'mybuttons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Home Screen"),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(" User Created Successfully !",style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500
            ),),
            SizedBox(height: 32.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 24.w),
              child: Mybuttons(onTap: () {  }, text: 'Log Out',),
            )
          ],
        ),
      ),
    );
  }
}
