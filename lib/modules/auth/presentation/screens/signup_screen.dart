import 'package:flutter/material.dart';
import 'package:flutter_luca_zaga30/modules/auth/presentation/screens/login_screen.dart';
import 'package:get/get.dart';
import '../../../../core/common/widget/reactive_button/save_button.dart';
import '../../../../core/notifiers/button_status_notifier.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../onbording/common/textfield.dart';
import '../../../onbording/widgets/background_image.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: AuthBackgroundImage(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),

                          Text(
                            "Create Your Account",
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 20),

                          /// Full Name
                          LabeledTextField(
                            title: "Name",
                            hintText: "Enter your full name",
                            prefixIcon: Icons.person_outline,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your name";
                              }
                              return null;
                            },
                          ),

                          /// Email
                          LabeledTextField(
                            title: "Email",
                            hintText: "Enter your email",
                            prefixIcon: Icons.email_outlined,
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

                          LabeledTextField(
                            title: "Phone Number",
                            hintText: "Enter your phone number",
                            prefixIcon: Icons.email_outlined,
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

                          LabeledDropdown(
                            title: "Choose the country",
                            hintText: "Choose the country",
                            items: ["India", "United States", "United Kingdom"],
                            onChanged: (value) {},
                          ),

                          /// Password
                          LabeledTextField( 
                            title: "Password",
                            hintText: "Enter your password",
                            prefixIcon: Icons.lock_outline,
                            isPassword: true,
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

                           LabeledTextField(
                            title: "Confirm Password",
                            hintText: "Confirm your password",
                            prefixIcon: Icons.lock_outline,
                            isPassword: true,
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

                          const SizedBox(height: 12),

                          /// Create Account Button
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: RSaveButton(
                              saveText: "Sign Up",
                              loadingText: "Signing Up...",
                              doneText: "Done",
                              errorText: "Error",
                              buttonStatusNotifier: ProcessStatusNotifier(
                                initialStatus: EnabledStatus(),
                              ),
                              onSaveTap: () {
                                if (_formKey.currentState!.validate()) {
                                  FocusScope.of(context).unfocus();
                                }
                              },
                              onDone: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const Scaffold(),
                                  ),
                                );
                              },
                              key: null,
                            ),
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const LoginScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Sign In here",
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
