import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DotLoadingIndicator extends StatelessWidget {
  final double? width;
  final double? height;
  final double? size;
  final Color? indicatorColor;

  const DotLoadingIndicator({super.key, this.width, this.height, this.indicatorColor, this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 50.w,
      height:  height,
      child: Center(
        child: SpinKitThreeBounce(
          size: size ?? 15,
          color: indicatorColor ?? Colors.white,
        ),
      ),
    );
  }
}
