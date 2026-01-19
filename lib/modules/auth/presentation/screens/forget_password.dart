import 'package:flutter/material.dart';
import 'package:flutter_luca_zaga30/modules/auth/controller/forget_password%20controller.dart';
import 'package:get/get.dart';
import '../../../../core/common/widget/reactive_button/save_button.dart';
import '../../../../core/notifiers/snackbar_notifier.dart';
import '../../../onbording/common/app_logo.dart';
import '../../../onbording/common/textfield.dart';
import '../../../onbording/widgets/background_image.dart';
import 'enter_otp.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late final ForgetPasswordController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(
      ForgetPasswordController(
        SnackbarNotifier(context: context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AuthBackgroundImage(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppLogo(),
                const SizedBox(height: 24),

                const Text(
                  "Reset Password",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  "Enter your email to receive the OTP",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),

                const SizedBox(height: 40),

                /// EMAIL FIELD
                LabeledTextField(
                  controller: controller.emailController,
                  title: "Email",
                  hintText: "Enter your email",
                  prefixIcon: Icons.email_outlined,
                ),

                const SizedBox(height: 24),

                /// SEND OTP BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: RSaveButton(
                    saveText: "Send OTP",
                    loadingText: "Sending...",
                    doneText: "Sent",
                    errorText: "Failed",
                    buttonStatusNotifier:
                        controller.processStatusNotifier,
                    onSaveTap: () async {
                      await controller.forgetPassword();
                    },
                    onDone: () {
                      Get.to(
                        () => EnterOtp(email: controller.email),
                      );
                    }, key: null,
                  ),
                ),

                const SizedBox(height: 64),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<ForgetPasswordController>();
    super.dispose();
  }
}
