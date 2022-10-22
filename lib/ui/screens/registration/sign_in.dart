import 'dart:developer' as developer;
import 'package:agency31_app/controller/authentication.dart';
import 'package:agency31_app/ui/screens/registration/widgets/registration_next_button.dart';
import 'package:agency31_app/ui/widgets/custom_text_field.dart';
import 'package:agency31_app/utils/base/colors.dart';
import 'package:agency31_app/utils/base/images.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  late TextEditingController userCtrl;
  late TextEditingController passwordCtrl;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    userCtrl = TextEditingController();
    passwordCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    userCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.08.sw),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 0.1.sh),
                      Text(
                        "Welcome \nBack".tr,
                        style: TextStyle(
                          fontSize: 51.sp,
                          fontWeight: FontWeight.bold,
                          color: MyColors.primary,
                        ),
                      ),
                      SizedBox(height: 0.03.sh),
                      CustomTextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: userCtrl,
                        label: "Username".tr,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your username".tr;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 0.03.sh),
                      CustomTextField(
                        obscureText: _obscureText,
                        controller: passwordCtrl,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            _toggle();
                          },
                          child: _obscureText
                              ? const Icon(
                                  Icons.visibility_off,
                                  color: MyColors.secondary,
                                )
                              : const Icon(
                                  Icons.visibility,
                                  color: MyColors.secondary,
                                ),
                        ),
                        label: "Password".tr,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your password".tr;
                          }
                          if (value.length < 4) {
                            return "Password is short".tr;
                          }
                          return null;
                        },
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forgot Password?".tr,
                              style: const TextStyle(
                                color: MyColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 0.05.sh),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sign In'.tr,
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: MyColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          RegistrationNextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 0.05.sh),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.white,
                          minimumSize: Size(1.sw, 50),
                          foregroundColor: MyColors.primary,
                        ),
                        onPressed: () async {
                          // User? user = await Authentication.signInWithGoogle(
                          //     context: context);

                          AuthController.to.signInWithGoogle();
                          // if (user != null) {
                          //   MySharedPreferences.isLogIn = true;
                          //   MySharedPreferences.email =
                          //       user.email ?? 'user email';
                          //   Get.to(() => const HomeScreen());
                          // }
                        },
                        icon: Image.asset(
                          MyImages.google,
                          width: 45,
                          height: 45,
                        ),
                        label: const Text('Sign in with google'),
                      ),
                      SizedBox(height: 0.05.sh),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: "Don’t have an a account? ".tr,
                            children: [
                              TextSpan(
                                text: "Sign up".tr,
                                style: const TextStyle(
                                  color: MyColors.secondary,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    developer.log('sign up');
                                  },
                              ),
                            ],
                            style: TextStyle(
                              color: MyColors.primary,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 0.05.sh),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
