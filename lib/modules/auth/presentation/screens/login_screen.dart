import 'package:flutter/material.dart';
import 'package:flutter_luca_zaga30/modules/auth/presentation/screens/forget_password.dart';
import 'package:flutter_luca_zaga30/modules/auth/presentation/screens/signup_screen.dart';
import 'package:get/get.dart';
import '../../../../core/common/widget/reactive_button/save_button.dart';
import '../../../../core/notifiers/snackbar_notifier.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../onbording/common/app_logo.dart';
import '../../../onbording/common/textfield.dart';
import '../../../onbording/widgets/background_image.dart';
import '../../controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(
      LoginController(SnackbarNotifier(context: context)),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AuthBackgroundImage(
        child: SafeArea(
          child: Form(
            key: controller.formKey,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 0),
                            const AppLogo(),

                            SizedBox(height: 20),

                            LabeledTextField(
                              title: "Email",
                              hintText: "Enter your email",
                              prefixIcon: Icons.email_outlined,
                              // prefixIconColor: Colors.grey,
                              controller: controller.emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your email";
                                }
                                if (!GetUtils.isEmail(value)) {
                                  return "Please enter a valid email";
                                }
                                return null;
                              },
                            ),

                            Obx(
                              () => LabeledTextField(
                                title: "Password",
                                hintText: "Enter your password",
                                controller: controller.passwordController,
                                isPassword: !controller.isPasswordVisible.value,
                                prefixIcon: Icons.lock_outline,
                                // prefixIconColor: Colors.grey,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your password";
                                  }
                                  if (value.length < 6) {
                                    return "Password must be at least 6 characters";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Obx(
                                  () => Checkbox(
                                    value: controller.keepSignedIn.value,
                                    checkColor: Colors.white,
                                    hoverColor: AppColors.white,
                                    focusColor: AppColors.white,
                                    activeColor: AppColors.primarybutton,
                                    fillColor:
                                        MaterialStateProperty.resolveWith<
                                          Color
                                        >((states) {
                                          if (states.contains(
                                            MaterialState.selected,
                                          )) {
                                            return AppColors.primarybutton;
                                          }
                                          return Colors.white;
                                        }),
                                    side: const BorderSide(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                    onChanged: (bool? value) {
                                      controller.toggleKeepSignedIn(
                                        value ?? false,
                                      );
                                    },
                                  ),
                                ),
                                const Text(
                                  "Remember me",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                Spacer(),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ForgetPassword(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Forgot password?",
                                    style: TextStyle(
                                      color: AppColors.textButtonColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: RSaveButton(
                                saveText: "Sign in",
                                loadingText: "Signing in...",
                                doneText: "Signed in",
                                errorText: "Sign in failed",
                                key: null,
                                buttonStatusNotifier:
                                    controller.processStatusNotifier,
                                onSaveTap: () {
                                  // controller.login(
                                  //   needVerifyAccount: () {
                                  //     controller.snackbarNotifier;
                                  //   },
                                  // );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Scaffold(),
                                    ),
                                  );
                                },

                                onDone: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Scaffold(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 20),
                                Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignupScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Sign up here",
                                    style: TextStyle(
                                      color: AppColors.textButtonColor,
                                      fontSize: 14,
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
