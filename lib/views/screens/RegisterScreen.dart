import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:scrappy/controller/provider/authProvider.dart';
import 'package:scrappy/core/utils/color_const.dart';
import 'package:scrappy/core/utils/image_constant.dart';
import 'package:scrappy/views/screens/LoginScreen.dart';
import 'package:scrappy/views/screens/OtpScreen.dart';
import 'package:scrappy/views/widgets/BackArrowWidget.dart';
import 'package:scrappy/views/widgets/CutomTextFormField.dart';
import 'package:scrappy/views/widgets/DotLoadingIndicator.dart';

class RegisterScreen
    extends
        StatefulWidget {
  const RegisterScreen({
    super.key,
  });

  @override
  State<
    RegisterScreen
  >
  createState() => _RegisterScreenState();
}

class _RegisterScreenState
    extends
        State<
          RegisterScreen
        > {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode mobileFocus = FocusNode();

  late AuthProvider authProvider;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    mobileController.dispose();
    nameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    mobileFocus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    authProvider =
        Provider.of<
          AuthProvider
        >(
          context,
          listen: false,
        );
    WidgetsBinding.instance.addPostFrameCallback(
      (
        _,
      ) {
        authProvider.clearLoading();
      },
    );
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final size = MediaQuery.of(
      context,
    ).size;

    return Scaffold(
      backgroundColor: const Color(
        0xFFFCE6D9,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: size.height,
              width: size.width,
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  SizedBox(
                    height: 80.h,
                  ),
                  Image.asset(
                    ImageConstant.loginTopImage,
                    height: 129.h,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: bodySection(
                context,
              ),
            ),
            const Positioned(
              top: 30,
              left: 0,
              child: BackArrowWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget bodySection(
    BuildContext context,
  ) {
    return Container(
      padding: EdgeInsets.all(
        24.w,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            ColorConst.appPrimaryColor,
            ColorConst.appSecondaryColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            32.r,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sign up!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            "Welcome back, Please enter your details.",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(
            height: 24.h,
          ),

          // Name
          CustomTextField(
            label: 'Name',
            hintText: 'Enter name',
            controller: nameController,
            focusNode: nameFocus,
            onFieldSubmitted:
                (
                  _,
                ) =>
                    FocusScope.of(
                      context,
                    ).requestFocus(
                      emailFocus,
                    ),
          ),
          SizedBox(
            height: 16.h,
          ),

          // Email
          CustomTextField(
            label: 'Email',
            hintText: 'Enter email',
            controller: emailController,
            focusNode: emailFocus,
            onFieldSubmitted:
                (
                  _,
                ) =>
                    FocusScope.of(
                      context,
                    ).requestFocus(
                      mobileFocus,
                    ),
          ),
          SizedBox(
            height: 16.h,
          ),

          // Mobile
          CustomTextField(
            label: 'Mobile',
            hintText: 'Enter number',
            controller: mobileController,
            focusNode: mobileFocus,
            keyboardType: TextInputType.phone,
            onFieldSubmitted:
                (
                  _,
                ) =>
                    FocusScope.of(
                      context,
                    ).requestFocus(
                      passwordFocus,
                    ),
          ),
          SizedBox(
            height: 16.h,
          ),

          // Password
          CustomTextField(
            label: 'Password',
            hintText: 'Enter password',
            controller: passwordController,
            obscureText: true,
            focusNode: passwordFocus,
          ),
          SizedBox(
            height: 24.h,
          ),

          Consumer<
            AuthProvider
          >(
            builder:
                (
                  context,
                  authProvider,
                  child,
                ) {
                  return Center(
                    child: authProvider.isLoading
                        ? const DotLoadingIndicator()
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConst.buttonColor,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  32.r,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 40.w,
                                vertical: 12.h,
                              ),
                            ),
                            onPressed: () async {
                              nameFocus.unfocus();
                              emailFocus.unfocus();
                              passwordFocus.unfocus();
                              mobileFocus.unfocus();
                              final response = await authProvider.registerUser(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                mobile: mobileController.text,
                              );

                              if (response ==
                                  true) {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: OtpScreen(
                                      email: emailController.text,
                                      mobile: mobileController.text,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              "Get OTP",
                              style: TextStyle(
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                  );
                },
          ),
          SizedBox(
            height: 16.h,
          ),

          Row(
            children: [
              Expanded(
                child: Divider(
                  color: Colors.white38,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                ),
                child: Text(
                  "OR",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Expanded(
                child: Divider(
                  color: Colors.white38,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSocialButton(
                'Google',
                ImageConstant.googleIcon,
                Colors.white,
              ),
              _buildSocialButton(
                'Facebook',
                ImageConstant.facebookIcon,
                Colors.white,
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: LoginScreen(),
                ),
              );
            },
            child: Center(
              child: RichText(
                text: TextSpan(
                  text: "Already have an account?   ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                  children: [
                    TextSpan(
                      text: "Login",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(
    String text,
    String icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 8.w,
        ),
        child: OutlinedButton.icon(
          onPressed: () {},
          icon: Image.asset(
            icon,
            height: 20.h,
          ),
          label: Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 14.sp,
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(
              color: ColorConst.buttonColor,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                12.r,
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 12.h,
            ),
          ),
        ),
      ),
    );
  }
}
