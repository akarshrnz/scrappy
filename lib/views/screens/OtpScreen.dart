import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:scrappy/controller/provider/authProvider.dart';
import 'package:scrappy/core/utils/color_const.dart';
import 'package:scrappy/core/utils/image_constant.dart';
import 'package:scrappy/views/widgets/BackArrowWidget.dart';
import 'package:scrappy/views/widgets/DotLoadingIndicator.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  final String mobile;
  const OtpScreen({super.key, required this.email, required this.mobile});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> otpControllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> otpFocusNodes = List.generate(4, (_) => FocusNode());

  Timer? _timer;
  int _start = 30;
  bool _showResend = false;
   late AuthProvider authProvider;

 
  @override
  void initState() {
     authProvider = Provider.of<AuthProvider>(context, listen: false); 
      WidgetsBinding.instance.addPostFrameCallback(
      (
        timeStamp,
      ) {

        authProvider.clearLoading();
      },
    );

    super.initState();
    _startTimer();
  }



  void _startTimer() {
    setState(() {
      _start = 30;
      _showResend = false;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        timer.cancel();
        setState(() {
          _showResend = true;
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void _handleOtpInput(String value, int index) {
    if (value.isNotEmpty) {
      if (index < otpControllers.length - 1) {
        FocusScope.of(context).requestFocus(otpFocusNodes[index + 1]);
      } else {
        FocusScope.of(context).unfocus();
      }
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(otpFocusNodes[index - 1]);
    }
  }

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in otpFocusNodes) {
      node.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFCE6D9),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(height: size.height, width: size.width),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  SizedBox(height: 80.h),
                  Image.asset(
                    ImageConstant.loginTopImage,
                    height: 180.h,
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
            Positioned(bottom: 0, left: 0, right: 0, child: bodySection(context)),
            Positioned(top: 30, left: 0, child: BackArrowWidget()),
          ],
        ),
      ),
    );
  }

  Widget bodySection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            ColorConst.appPrimaryColor,
            ColorConst.appSecondaryColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Please,\nEnter OTP!",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "An OTP has been sent to you via SMS",
            style: TextStyle(color: Colors.white70, fontSize: 14.sp),
          ),
          SizedBox(height: 24.h),

          /// OTP Fields
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (index) {
              return Container(
                width: 50.w,
                height: 60.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: TextField(
                  controller: otpControllers[index],
                  focusNode: otpFocusNodes[index],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  style: TextStyle(fontSize: 24.sp),
                  decoration: const InputDecoration(
                    counterText: "",
                    border: InputBorder.none,
                  ),
                  onChanged: (value) => _handleOtpInput(value, index),
                ),
              );
            }),
          ),

          SizedBox(height: 24.h),

          /// Verify OTP Button
           Consumer<
            AuthProvider
          >(
            builder:
                (
                  context,
                  authProvider,
                  child,
                ) {
                  return 
                    authProvider.verifyOtpLoading
                        ? Center(child: const DotLoadingIndicator())
                        : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h),
                ),
                onPressed: () {
                  final enteredOtp = otpControllers.map((e) => e.text).join();
                  print("Entered OTP: $enteredOtp");
               authProvider.verifyOtpAndNavigate(context: context, email: widget.email, mobile:  widget.mobile, mobileOtp: enteredOtp);
                },
                child: Text("Verify OTP", style: TextStyle(fontSize: 16.sp)),
              );
            }
          ),

          SizedBox(height: 24.h),

          /// Resend OTP or Timer
          Center(
            child: _showResend
                ? GestureDetector(
                    onTap: () {
                      authProvider.generateOtpForUser(email:widget. email, mobile:widget. mobile);
                      // Resend OTP logic here
                      _startTimer(); // Restart timer
                    },
                    child: Text(
                      "Click to resend",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                : Text(
                    "Resend in $_start sec",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.sp,
                    ),
                  ),
          ),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
