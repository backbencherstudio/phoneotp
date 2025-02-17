import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class Mybuttons extends StatelessWidget {
  void Function()? onTap;
  final String text;
  Mybuttons({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: Color(0xFF04505A),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500, color: Color(0XFFFFFFFF)),
            ),
          ),
        ),
      ),
    );
  }
}
