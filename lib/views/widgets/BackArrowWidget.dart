import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackArrowWidget extends StatelessWidget {
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double? radius;
  const BackArrowWidget({
    super.key, this.onTap,  this.padding, this.backgroundColor, this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap ,
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding:padding?? EdgeInsets.only(left: 16.w,top: 15),
          child: CircleAvatar(
            backgroundColor:backgroundColor?? Colors.white,
            radius: 20.r,
            child: Icon(Icons.arrow_back, color: Colors.black, size: 20.sp),
          ),
        ),
      ),
    );
  }
}