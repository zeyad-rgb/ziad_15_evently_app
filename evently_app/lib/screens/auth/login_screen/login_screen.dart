import 'package:easy_localization/easy_localization.dart';
import 'package:evently_v2/config/firebase/firebase_auth.dart';
import 'package:evently_v2/core/assets/assets_manager.dart';
import 'package:evently_v2/core/colors/colors_manager.dart';
import 'package:evently_v2/core/extension/build_context_extension.dart';
import 'package:evently_v2/core/models/user_data.dart';
import 'package:evently_v2/core/routes/routes_manager.dart';
import 'package:evently_v2/core/widgets/custome_elevated_button.dart';
import 'package:evently_v2/core/widgets/custome_text_button.dart';
import 'package:evently_v2/core/widgets/custome_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  bool obscureText = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("login".tr()), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: _autoValidateMode,
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 16.h),
                Image.asset(PngAssets.logo),
                SizedBox(height: 25.h),
                CustomeTextFormField(
                  prefixIcon: Icons.email,
                  prefixIconColor: Theme.of(context).primaryColorLight,
                  hintText: "email".tr(),
                  label: "email".tr(),
                  controller: _emailController,
                  validator: (value) {
                    if (!RegExp(
                      r"^[\w-.]+@([\w-]+\.)+\w{2,4}$",
                    ).hasMatch(value!)) {
                      return "email_invalid".tr();
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                CustomeTextFormField(
                  obscureText: obscureText,
                  prefixIcon: Icons.lock,
                  prefixIconColor: Theme.of(context).primaryColorLight,
                  onPressedSufixIcon: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  hintText: "password".tr(),
                  sufixIcon: obscureText
                      ? Icons.visibility_off
                      : Icons.visibility,
                  label: "password".tr(),
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "password_required".tr();
                    }
                    if (value.length < 8) {
                      return "password_too_short".tr();
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomeTextButton(
                    text: "forget_password".tr(),
                    onPressd: () {},
                  ),
                ),
                SizedBox(height: 16.h),
                isLoading
                    ? CircularProgressIndicator(color: ColorsManager.blue56)
                    : CustomeElevatedButton(
                        label: "login_btn".tr(),
                        onPressed: () async {
                          setState(() {
                            _autoValidateMode = AutovalidateMode.always;
                            isLoading = true;
                          });

                          bool success = false;

                          if (_formKey.currentState!.validate()) {
                            UserModel user = UserModel(
                              id: "",
                              name: "",
                              email: _emailController.text.trim(),
                              phone: "",
                            );

                            success = await FirebaseAuthentication.signIn(
                              user: user,
                              password: _passwordController.text.trim(),
                              onError: (message) async {
                                if (message == "email_not_verified".tr()) {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Text("email_not_verified".tr()),
                                      content: Text("please_verify_email".tr()),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            try {
                                              final currentUser = FirebaseAuth
                                                  .instance
                                                  .currentUser;
                                              await currentUser
                                                  ?.sendEmailVerification();
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    "verification_email_sent"
                                                        .tr(),
                                                  ),
                                                ),
                                              );
                                            } catch (e) {
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(e.toString()),
                                                ),
                                              );
                                            }
                                          },
                                          child: Text("resend".tr()),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("cancel".tr()),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text("error".tr()),
                                      content: Text(message),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("ok".tr()),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            );
                          }

                          setState(() {
                            isLoading = false;
                          });

                          if (success) {
                            Navigator.pushReplacementNamed(
                              context,
                              RoutesManager.homeLayout,
                            );
                            _emailController.clear();
                            _passwordController.clear();
                          } else {
                            _passwordController.clear();
                          }
                        },
                      ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "dont_have_account".tr(),
                      style: context.labelSmall?.copyWith(
                        color: Theme.of(context).primaryColorLight,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomeTextButton(
                      onPressd: () {
                        Navigator.pushReplacementNamed(
                          context,
                          RoutesManager.registerScreen,
                        );
                      },
                      text: "create_account".tr(),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        color: Theme.of(context).primaryColor,
                        thickness: 2.h,
                        endIndent: 16.w,
                        indent: 26.w,
                      ),
                    ),
                    Text(
                      "or".tr(),
                      style: context.labelSmall?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Theme.of(context).primaryColor,
                        thickness: 2.h,
                        endIndent: 26.w,
                        indent: 16.w,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                InkWell(
                  onTap: () async {
                    try {
                      await FirebaseAuthentication.signInWithGoogle();

                      final user = FirebaseAuth.instance.currentUser;

                      if (user != null) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Success"),
                            content: Text("Login Successfully"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    RoutesManager.homeLayout,
                                  );
                                },
                                child: Text("ok"),
                              ),
                            ],
                          ),
                        );
                      }
                    } catch (e) {
                      print(e.toString());
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Error"),
                          content: Text(e.toString()),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("ok"),
                            ),
                          ],
                        ),
                      );
                    }
                  },

                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(16.0.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(SvgAssets.googleLogo),
                        SizedBox(width: 10.w),
                        Text(
                          "login_with_google".tr(),
                          style: context.labelMedium?.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
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
