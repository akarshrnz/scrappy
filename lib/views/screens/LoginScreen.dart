import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:scrappy/controller/provider/authProvider.dart';
import 'package:scrappy/core/utils/color_const.dart';
import 'package:scrappy/core/utils/image_constant.dart';
import 'package:scrappy/views/screens/RegisterScreen.dart';
import 'package:scrappy/views/widgets/BackArrowWidget.dart';
import 'package:scrappy/views/widgets/CutomTextFormField.dart';
import 'package:scrappy/views/widgets/DotLoadingIndicator.dart';

class LoginScreen
    extends
        StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<
    LoginScreen
  >
  createState() => _LoginScreenState();
}

class _LoginScreenState
    extends
        State<
          LoginScreen
        > {
  final TextEditingController emaiController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  late AuthProvider authProvider;

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
        timeStamp,
      ) {
        authProvider.clearLoading();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    emaiController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
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
                  // BackArrowWidget(),
                  SizedBox(
                    height: 80.h,
                  ),
                  Image.asset(
                    ImageConstant.loginTopImage,
                    height: 180.h,
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
            Positioned(
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
            "Login!",
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
          CustomTextField(
            label: 'Email',
            hintText: 'Enter email',
            controller: emaiController,
            focusNode: emailFocus,
            onFieldSubmitted:
                (
                  _,
                ) {
                  FocusScope.of(
                    context,
                  ).requestFocus(
                    passwordFocus,
                  );
                },
          ),
          SizedBox(
            height: 16.h,
          ),
          CustomTextField(
            label: 'Password',
            hintText: 'Enter password',
            controller: passwordController,
            focusNode: passwordFocus,
            textInputAction: TextInputAction.done,
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
                            onPressed: () {
                              emailFocus.unfocus();
                              passwordFocus.unfocus();
                              authProvider.loginAndNavigate(
                                context: context,
                                email: emaiController.text,
                                password: passwordController.text,
                              );
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                  );
                },
          ),
          SizedBox(
            height: 24.h,
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
            height: 24.h,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: RegisterScreen(),
                ),
              );
            },
            child: Center(
              child: RichText(
                text: TextSpan(
                  text: "Don’t have an account?  ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                  children: [
                    TextSpan(
                      text: "Sign up",
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
          SizedBox(
            height: 20.h,
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
