import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key, required this.title, required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor:  Color(0xFF04505A),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r)
              )

          ),
          onPressed: onTap, child: Text(title,style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Colors.white
      ),)),
    );
  }
}
