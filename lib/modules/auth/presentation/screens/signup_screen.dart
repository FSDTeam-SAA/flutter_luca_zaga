import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/common/widget/reactive_button/save_button.dart';
import '../../../../core/notifiers/snackbar_notifier.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../onbording/common/textfield.dart';
import '../../../onbording/widgets/background_image.dart';
import '../../controller/sign_up_controller.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final snackbarNotifier = SnackbarNotifier(context: context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: AuthBackgroundImage(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  Text(
                    "Create Your Account",
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Name
                  LabeledTextField(
                    title: "Name",
                    hintText: "Enter your full name",
                    prefixIcon: Icons.person_outline,
                    onChanged: controller.setName,
                    validator: (v) =>
                        v == null || v.isEmpty ? "Enter your name" : null,
                  ),

                  // Email
                  LabeledTextField(
                    title: "Email",
                    hintText: "Enter your email",
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: controller.setEmail,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Enter your email";
                      }
                      if (!GetUtils.isEmail(v)) {
                        return "Invalid email";
                      }
                      return null;
                    },
                  ),

                  // Phone
                  LabeledTextField(
                    title: "Phone",
                    hintText: "Enter phone number",
                    prefixIcon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    onChanged: controller.setPhone,
                    validator: (v) =>
                        v == null || v.isEmpty ? "Enter phone number" : null,
                  ),

                  // Password
                  LabeledTextField(
                    title: "Password",
                    hintText: "Enter password",
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                    onChanged: controller.setPassword,
                    validator: (v) {
                      if (v == null || v.length < 6) {
                        return "Min 6 characters";
                      }
                      return null;
                    },
                  ),

                  // Confirm Password
                  LabeledTextField(
                      title: "Confirm Password",
                      hintText: "Confirm password",
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                      onChanged: controller.setConfirmPassword,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "Confirm password";
                        }
                        if (v != controller.password.value) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                  ),

                  const SizedBox(height: 20),

                  // Sign up button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: RSaveButton(
                      saveText: "Sign Up",
                      loadingText: "Signing up...",
                      doneText: "Done",
                      errorText: "Failed",
                      buttonStatusNotifier: controller.processNotifier,
                      onSaveTap: () {
                        if (_formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          controller.signup(
                            snackbarNotifier: snackbarNotifier,
                            onDone: () {
                              Get.offAll(() => const LoginScreen());
                            },
                          );
                        }
                      },
                      key: null,
                      onDone: () {},
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.off(() => const LoginScreen());
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(color: AppColors.textButtonColor),
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
