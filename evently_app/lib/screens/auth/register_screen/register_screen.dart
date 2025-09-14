import 'package:easy_localization/easy_localization.dart';
import 'package:evently_v2/config/firebase/firebase_auth.dart';
import 'package:evently_v2/core/assets/assets_manager.dart';
import 'package:evently_v2/core/colors/colors_manager.dart';
import 'package:evently_v2/core/extension/build_context_extension.dart';
import 'package:evently_v2/core/models/user_data.dart';
import 'package:evently_v2/core/providers/providers_manager.dart';
import 'package:evently_v2/core/routes/routes_manager.dart';
import 'package:evently_v2/core/widgets/custome_elevated_button.dart';
import 'package:evently_v2/core/widgets/custome_text_button.dart';
import 'package:evently_v2/core/widgets/custome_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui' as ui;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  bool obscureText1 = true;
  bool obscureText2 = true;
  bool isLoading = false;
  ProvidersManager providersManager = ProvidersManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("register".tr()), centerTitle: true),
      body: SafeArea(
        child: Padding(
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
                    prefixIcon: Icons.person,
                    prefixIconColor: Theme.of(context).primaryColorLight,
                    hintText: "name".tr(),
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    label: "name".tr(),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "name_required".tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15.h),
                  CustomeTextFormField(
                    prefixIcon: Icons.phone,
                    prefixIconColor: Theme.of(context).primaryColorLight,
                    hintText: "phone".tr(),
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    label: "phone".tr(),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "phone_required".tr();
                      }
                      if (value.length < 11) {
                        return "invalid_phone_number".tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15.h),
                  CustomeTextFormField(
                    prefixIcon: Icons.email,
                    prefixIconColor: Theme.of(context).primaryColorLight,
                    hintText: "email".tr(),
                    label: "email".tr(),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (!RegExp(
                        r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value!)) {
                        return "email_invalid".tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  CustomeTextFormField(
                    obscureText: obscureText1,
                    prefixIcon: Icons.lock,
                    prefixIconColor: Theme.of(context).primaryColorLight,
                    onPressedSufixIcon: () {
                      setState(() {
                        obscureText1 = !obscureText1;
                      });
                    },
                    hintText: "password".tr(),
                    label: "password".tr(),
                    sufixIcon: obscureText1
                        ? Icons.visibility_off
                        : Icons.visibility,
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
                  CustomeTextFormField(
                    obscureText: obscureText2,
                    prefixIcon: Icons.lock,
                    prefixIconColor: Theme.of(context).primaryColorLight,
                    onPressedSufixIcon: () {
                      setState(() {
                        obscureText2 = !obscureText2;
                      });
                    },
                    label: "re_password".tr(),
                    hintText: "re_password".tr(),
                    sufixIcon: obscureText2
                        ? Icons.visibility_off
                        : Icons.visibility,
                    controller: _rePasswordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "password_required".tr();
                      }
                      if (value.length < 8) {
                        return "password_too_short".tr();
                      }
                      if (value != _passwordController.text) {
                        return "password_not_match".tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  isLoading
                      ?  Center(
                          child: CircularProgressIndicator(
                            color: ColorsManager.blue56,
                          ),
                        )
                      : CustomeElevatedButton(
                          label: "create_account_btn".tr(),
                          onPressed: () async {
                            setState(() {
                              _autoValidateMode = AutovalidateMode.always;
                              isLoading = true;
                            });
                            bool success = false;

                            if (_formKey.currentState!.validate()) {
                              UserModel user = UserModel(
                                id: "",
                                name: _nameController.text,
                                email: _emailController.text,
                                phone: _phoneController.text,
                              );

                              success = await FirebaseAuthentication.signUp(
                                user: user,
                                password: _passwordController.text,
                                onError: (value) {
                                  setState(() => isLoading = false);
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text("error".tr()),
                                      content: Text(value),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("ok".tr()),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }

                            if (success) {
                              Navigator.pushReplacementNamed(
                                context,
                                RoutesManager.loginScreen,
                              );
                            }

                            setState(() {
                              isLoading = false;
                            });
                          },
                        ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "already_have_account".tr(),
                        style: context.labelSmall?.copyWith(
                          color: Theme.of(context).primaryColorLight,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CustomeTextButton(
                        onPressd: () {
                          Navigator.pushReplacementNamed(
                            context,
                            RoutesManager.loginScreen,
                          );
                        },
                        text: "login".tr(),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Directionality(
                        textDirection: ui.TextDirection.ltr,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorsManager.blue56,
                              width: 2.w,
                            ),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () => context.setLocale(Locale('en')),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: context.locale.toString() == 'en'
                                          ? ColorsManager.blue56
                                          : ColorsManager.transparent,
                                      width: 5.w,
                                    ),
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                  child: SvgPicture.asset(
                                    SvgAssets.usLogo,
                                    width: 30,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => context.setLocale(Locale('ar')),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: context.locale.toString() == 'ar'
                                          ? ColorsManager.blue56
                                          : ColorsManager.transparent,
                                      width: 5.w,
                                    ),
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                  child: SvgPicture.asset(
                                    SvgAssets.egLogo,
                                    width: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
